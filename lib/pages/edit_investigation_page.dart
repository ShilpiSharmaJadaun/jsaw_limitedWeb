import 'package:flutter/foundation.dart' show Uint8List;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../model/allDepartment_model.dart';
import '../model/allemployee_model.dart';
import '../model/investigationReport_response_model.dart';
import '../service/employee_reporting_service.dart';
import '../service/incident_service.dart';
import '../service/observation_service.dart';
import '../utils/app_color.dart';
import 'employee_picker_dialog.dart';
import 'inquired_with_picker_dialog.dart';
import '../model/activeEmployeeLookup_model.dart';

/// Edit screen for an existing investigation report.
/// Wired to investigationReport/updateInvestigationReport (multipart).
class EditInvestigationPage extends StatefulWidget {
  final InvestigationReportResponse report;
  final VoidCallback? onClose;
  final VoidCallback? onSaved;
  const EditInvestigationPage({
    super.key,
    required this.report,
    this.onClose,
    this.onSaved,
  });

  @override
  State<EditInvestigationPage> createState() => _EditInvestigationPageState();
}

class _EditInvestigationPageState extends State<EditInvestigationPage> {
  static const int _maxTeam = 6;
  static const int _maxRootCauses = 2;
  static const int _maxCapa = 6;

  late final TextEditingController _reportDateController;

  // ---------- Team ----------
  List<_TeamDraft> _team = [];

  // ---------- Root Causes ----------
  List<TextEditingController> _rootCauseControllers = [];

  // ---------- Facts Leading to the Incident (points 4 & 5) ----------
  static const int _maxFactsChars = 1000;
  late final TextEditingController _machineryDetailsController;
  late final TextEditingController _activityBeforeIncidentController;

  // ---------- CAPA ----------
  List<_CapaDraft> _capa = [];

  // ---------- Image ----------
  String _existingImageUrl = '';
  Uint8List? _newImageBytes;
  bool _imageRemoved = false;

  bool _saving = false;

  // ---------- Lookup state (employees + departments) ----------
  List<AllEmployeeModel> _allEmployees = [];
  bool _loadingEmployees = false;

  // ---------- Root Cause – Inquired With (point 6) ----------
  List<ActiveEmployeeLookupModel> _activeLookup = [];
  bool _loadingActiveLookup = false;
  String? _activeLookupError;
  List<_InquiredDraft> _inquiredWith = [];

  // "deptCode|statCode" -> statName, for CAPA "Resp. Station" lookup
  // (station table filtered by employee's DeptCode/StatCode/WrkGrp)
  final Map<String, String> _stationNameCache = {};
  final Set<String> _stationFetchInFlight = {};

  @override
  void initState() {
    super.initState();
    final r = widget.report;
    _reportDateController = TextEditingController(text: r.reportDate);
    _existingImageUrl = r.highQualityImageUrl.isNotEmpty
        ? r.highQualityImageUrl
        : r.associatedRiskImageUrl;

    _team = r.team
        .map((t) => _TeamDraft(
              id: t.id,
              seq: t.seq,
              empUnqId: t.empUnqId,
              empName: t.empName,
            ))
        .toList();
    if (_team.isEmpty) _team.add(_TeamDraft.empty());

    _rootCauseControllers = r.rootCauses
        .map((rc) => TextEditingController(text: rc.rootCauseText))
        .toList();
    if (_rootCauseControllers.isEmpty) {
      _rootCauseControllers = [TextEditingController()];
    }

    _machineryDetailsController =
        TextEditingController(text: r.machineryDetails);
    _activityBeforeIncidentController =
        TextEditingController(text: r.activityBeforeIncident);

    _inquiredWith = r.inquiredWith
        .map((i) => _InquiredDraft(
              empUnqId: i.empUnqId,
              empName: i.empName,
              deptCode: i.deptCode,
              statName: i.statName,
              gradeName: i.gradeName,
              desgName: i.desgName,
            ))
        .toList();

    _capa = r.capa
        .map((c) => _CapaDraft(
              id: c.id,
              seq: c.seq,
              capaController: TextEditingController(text: c.capaText),
              empCode: c.respEmpCode,
              empName: c.respEmpName,
              deptCode: c.respDeptCode,
              targetDateController:
                  TextEditingController(text: _normaliseDate(c.targetDate)),
            ))
        .toList();
    if (_capa.isEmpty) _capa.add(_CapaDraft.empty());

    _loadEmployees(); // active-only lookup: CAPA engineer + Inquired With
  }

  String _normaliseDate(String input) {
    if (input.isEmpty) return '';
    for (final pattern in const ['yyyy-MM-dd', 'dd-MMMM-yyyy', 'dd/MM/yyyy']) {
      try {
        final parsed = DateFormat(pattern).parseStrict(input);
        return DateFormat('dd/MM/yyyy').format(parsed);
      } catch (_) {}
    }
    return input;
  }

  /// Active employees (with station / grade / designation names) for the
  /// "Root Cause – Inquired With" picker (point 6).
  /// Single fetch of `employees/getActiveEmployeeLookup` feeding BOTH the
  /// CAPA engineer picker (point 7: active only) and the "Inquired With"
  /// picker (point 6).
  Future<void> _loadEmployees() async {
    setState(() {
      _loadingEmployees = true;
      _loadingActiveLookup = true;
      _activeLookupError = null;
    });
    try {
      final service =
          Provider.of<EmployeeReportingService>(context, listen: false);
      final list = await service.getActiveEmployeeLookup();
      if (!mounted) return;
      setState(() {
        _activeLookup = list;
        _allEmployees = list.map(_lookupToEmployee).toList();
        _seedStationCache(list);
        _loadingEmployees = false;
        _loadingActiveLookup = false;
      });
      // Existing CAPA rows only carry respDeptCode from the backend; resolve
      // each row's StatCode/WrkGrp from the employee record so the station
      // name can be shown, same as a freshly-picked employee.
      final unresolved = _backfillCapaRows(_allEmployees);
      // An engineer picked on an older report may have gone INACTIVE since;
      // they are not in the active lookup, so fall back to the full employee
      // list once, purely to display their station (they cannot be picked
      // again — the picker stays active-only).
      if (unresolved.isNotEmpty) {
        final all = await service.getAllEmployee();
        if (!mounted) return;
        _backfillCapaRows(all);
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _loadingEmployees = false;
        _loadingActiveLookup = false;
        _activeLookupError = e.toString().replaceFirst('Exception: ', '');
      });
    }
  }

  /// Fills statCode/wrkGrp on CAPA rows from [source]; returns the rows that
  /// could not be matched.
  List<_CapaDraft> _backfillCapaRows(List<AllEmployeeModel> source) {
    final unresolved = <_CapaDraft>[];
    for (final row in _capa) {
      if (row.empCode.isEmpty || row.statCode.isNotEmpty) continue;
      final match = source.where((e) => e.empUnqId == row.empCode);
      if (match.isEmpty) {
        unresolved.add(row);
        continue;
      }
      final emp = match.first;
      row.statCode = emp.statCode;
      row.wrkGrp = emp.wrkGrp;
      _ensureStationName(emp);
    }
    if (mounted) setState(() {});
    return unresolved;
  }

  /// Point 7: the CAPA engineer picker must list ACTIVE employees only.
  /// The active lookup already carries dept/station/grade/designation, so we
  /// map it onto the [AllEmployeeModel] shape the CAPA row expects and seed
  /// the station-name cache from it (no per-pick stations/ call needed).
  AllEmployeeModel _lookupToEmployee(ActiveEmployeeLookupModel e) =>
      AllEmployeeModel(
        empUnqId: e.empUnqId,
        empName: e.empName,
        active: 1,
        desgCode: e.desgCode,
        deptCode: e.deptCode,
        wrkGrp: e.wrkGrp,
        statCode: e.statCode,
        gradeCode: e.gradeCode,
      );

  void _seedStationCache(List<ActiveEmployeeLookupModel> list) {
    for (final e in list) {
      if (e.deptCode.isEmpty || e.statCode.isEmpty || e.statName.isEmpty) {
        continue;
      }
      _stationNameCache.putIfAbsent(
          '${e.deptCode}|${e.statCode}', () => e.statName);
    }
  }

  // Resolves the employee's station name via stations/getAllStationByDeptCode,
  // filtered to the employee's own DeptCode/StatCode/WrkGrp, and caches it.
  Future<void> _ensureStationName(AllEmployeeModel emp) async {
    if (emp.deptCode.isEmpty || emp.statCode.isEmpty) return;
    final key = '${emp.deptCode}|${emp.statCode}';
    if (_stationNameCache.containsKey(key) ||
        _stationFetchInFlight.contains(key)) {
      return;
    }
    _stationFetchInFlight.add(key);
    try {
      final service = Provider.of<ObservationService>(context, listen: false);
      final stations = await service.getDepartment(emp.deptCode);
      final match = stations.firstWhere(
        (s) => s.statCode == emp.statCode && s.wrkGrp == emp.wrkGrp,
        orElse: () => stations.firstWhere(
          (s) => s.statCode == emp.statCode,
          orElse: () => const AllDepartmentModel(),
        ),
      );
      if (!mounted) return;
      setState(() {
        _stationNameCache[key] =
            match.statName.isNotEmpty ? match.statName : emp.statCode;
      });
    } catch (_) {
      // Non-fatal: fall back to statCode
    } finally {
      _stationFetchInFlight.remove(key);
    }
  }

  String _stationDisplay(_CapaDraft row) {
    if (row.deptCode.isEmpty || row.statCode.isEmpty) return '';
    final key = '${row.deptCode}|${row.statCode}';
    return _stationNameCache[key] ?? row.statCode;
  }

  Future<AllEmployeeModel?> _openEmployeePicker({
    bool searchByCodeAndNameOnly = false,
  }) async {
    if (_loadingEmployees) {
      _showSnack('Loading employees, please wait…');
      return null;
    }
    if (_allEmployees.isEmpty) {
      _showSnack('Employee list is empty. Try again.');
      return null;
    }
    return showDialog<AllEmployeeModel>(
      context: context,
      builder: (_) => EmployeePickerDialog(
        employees: _allEmployees,
        searchByCodeAndNameOnly: searchByCodeAndNameOnly,
      ),
    );
  }

  Future<void> _pickTeamEmployee(int index) async {
    final picked = await _openEmployeePicker(searchByCodeAndNameOnly: false);
    if (picked == null) return;
    setState(() {
      _team[index].empUnqId = picked.empUnqId;
      _team[index].empName = picked.empName;
    });
  }

  Future<void> _pickCapaEmployee(_CapaDraft row) async {
    final picked = await _openEmployeePicker(searchByCodeAndNameOnly: true);
    if (picked == null) return;
    setState(() {
      row.empCode = picked.empUnqId;
      row.empName = picked.empName;
      row.deptCode = picked.deptCode;
      row.statCode = picked.statCode;
      row.wrkGrp = picked.wrkGrp;
    });
    _ensureStationName(picked);
  }

  @override
  void dispose() {
    _reportDateController.dispose();
    for (final t in _team) {
      t.dispose();
    }
    for (final c in _rootCauseControllers) {
      c.dispose();
    }
    _machineryDetailsController.dispose();
    _activityBeforeIncidentController.dispose();
    for (final c in _capa) {
      c.dispose();
    }
    super.dispose();
  }

  // ---------- Image actions ----------
  Future<void> _pickImage() async {
    try {
      final picker = ImagePicker();
      final picked =
          await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
      if (picked == null) return;
      final bytes = await picked.readAsBytes();
      if (!mounted) return;
      setState(() {
        _newImageBytes = bytes;
        _imageRemoved = false;
      });
    } catch (e) {
      if (!mounted) return;
      _showSnack('Could not pick image: $e');
    }
  }

  void _clearImage() {
    setState(() {
      _newImageBytes = null;
      _imageRemoved = true;
    });
  }

  // ---------- Team actions ----------
  void _addTeamMember() {
    if (_team.length >= _maxTeam) {
      _showSnack('Maximum $_maxTeam team members allowed.');
      return;
    }
    setState(() => _team.add(_TeamDraft.empty()));
  }

  void _removeTeamMember(int index) {
    if (_team.length <= 1) return;
    setState(() => _team.removeAt(index).dispose());
  }

  // ---------- Root cause actions ----------
  void _addRootCause() {
    if (_rootCauseControllers.length >= _maxRootCauses) {
      _showSnack('Maximum $_maxRootCauses root causes allowed.');
      return;
    }
    setState(() => _rootCauseControllers.add(TextEditingController()));
  }

  void _removeRootCause(int index) {
    if (_rootCauseControllers.length <= 1) return;
    setState(() => _rootCauseControllers.removeAt(index).dispose());
  }

  // ---------- CAPA actions ----------
  void _addCapa() {
    if (_capa.length >= _maxCapa) {
      _showSnack('Maximum $_maxCapa CAPA entries allowed.');
      return;
    }
    setState(() => _capa.add(_CapaDraft.empty()));
  }

  void _removeCapa(int index) {
    if (_capa.length <= 1) return;
    setState(() => _capa.removeAt(index).dispose());
  }

  Future<void> _pickTargetDate(_CapaDraft row) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked == null) return;
    setState(() {
      row.targetDateController.text =
          "${picked.day.toString().padLeft(2, '0')}/"
          "${picked.month.toString().padLeft(2, '0')}/"
          "${picked.year}";
    });
  }

  // ---------- Save ----------
  Future<void> _save() async {
    final report = widget.report;

    // Validate team
    final teamPayload = <Map<String, String>>[];
    for (final t in _team) {
      final code = t.empUnqId.trim();
      final name = t.empName.trim();
      if (code.isEmpty && name.isEmpty) continue;
      if (code.isEmpty || name.isEmpty) {
        _showSnack('Every team member needs both code and name.');
        return;
      }
      teamPayload.add({'empUnqId': code, 'empName': name});
    }
    if (teamPayload.isEmpty) {
      _showSnack('Add at least one team member.');
      return;
    }

    // Validate root causes
    final rootPayload = <String>[];
    for (final c in _rootCauseControllers) {
      final v = c.text.trim();
      if (v.isNotEmpty) rootPayload.add(v);
    }
    if (rootPayload.isEmpty) {
      _showSnack('Add at least one root cause.');
      return;
    }

    // Validate Facts Leading to the Incident (point 5 is mandatory)
    final machineryDetails = _machineryDetailsController.text.trim();
    final activityBeforeIncident =
        _activityBeforeIncidentController.text.trim();
    if (activityBeforeIncident.isEmpty) {
      _showSnack(
          'Describe what the injured person was doing just before and at the time of the occurrence.');
      return;
    }

    // Root Cause – Inquired With (optional)
    final inquiredPayload = _inquiredWith
        .map((e) => {
              'empUnqId': e.empUnqId,
              'empName': e.empName,
              'deptCode': e.deptCode,
              'statName': e.statName,
              'gradeName': e.gradeName,
              'desgName': e.desgName,
            })
        .toList();

    // Validate CAPA
    final capaPayload = <Map<String, dynamic>>[];
    for (final c in _capa) {
      final capaText = c.capaController.text.trim();
      final code = c.empCode.trim();
      final name = c.empName.trim();
      final dept = c.deptCode.trim();
      final tDate = c.targetDateController.text.trim();
      if (capaText.isEmpty &&
          code.isEmpty &&
          name.isEmpty &&
          dept.isEmpty &&
          tDate.isEmpty) {
        continue;
      }
      if (capaText.isEmpty ||
          code.isEmpty ||
          name.isEmpty ||
          dept.isEmpty ||
          tDate.isEmpty) {
        _showSnack(
            'Every CAPA row needs an action, an employee and a target date.');
        return;
      }
      capaPayload.add({
        'capaText': capaText,
        'respEmpCode': code,
        'respEmpName': name,
        'respDeptCode': dept,
        'targetDate': _toIsoDate(tDate),
      });
    }
    if (capaPayload.isEmpty) {
      _showSnack('Add at least one CAPA entry.');
      return;
    }

    final reportDateIso = _toIsoDate(_reportDateController.text.trim());
    if (reportDateIso == null) {
      _showSnack('Report date is invalid.');
      return;
    }

    // Image action
    final clearImage = _imageRemoved && _newImageBytes == null;
    final newImage = _newImageBytes;

    setState(() => _saving = true);

    // Blocking progress dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const _SavingDialog(),
    );

    try {
      final service = IncidentService();
      final msg = await service.updateInvestigationReport(
        id: report.id,
        incidentUniqueId: report.incidentUniqueId,
        reportDate: reportDateIso,
        team: teamPayload,
        rootCauses: rootPayload,
        capa: capaPayload,
        machineryDetails: machineryDetails,
        activityBeforeIncident: activityBeforeIncident,
        inquiredWith: inquiredPayload,
        newImageBytes: newImage,
        clearImage: clearImage,
      );
      if (!mounted) return;
      Navigator.of(context, rootNavigator: true).pop(); // dismiss progress
      await _showSuccessDialog(
          msg ?? 'Investigation Report updated successfully.');
      if (!mounted) return;
      widget.onSaved?.call();
      _close();
    } catch (e) {
      if (!mounted) return;
      Navigator.of(context, rootNavigator: true).pop(); // dismiss progress
      _showSnack(e.toString().replaceFirst('Exception: ', ''));
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _showSuccessDialog(String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        icon: const Icon(Icons.check_circle,
            color: Color(0xFF16A34A), size: 48),
        title: const Text(
          'Updated',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(color: kcValueDark),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.of(ctx).pop(),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF16A34A),
              foregroundColor: kcWhite,
              padding:
                  const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text('OK',
                style: TextStyle(fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }

  /// Accepts either yyyy-MM-dd, dd/MM/yyyy or dd-MMMM-yyyy and returns yyyy-MM-dd.
  String? _toIsoDate(String value) {
    if (value.isEmpty) return null;
    DateTime? parsed;
    for (final pattern in const ['yyyy-MM-dd', 'dd/MM/yyyy', 'dd-MMMM-yyyy']) {
      try {
        parsed = DateFormat(pattern).parseStrict(value);
        break;
      } catch (_) {}
    }
    if (parsed == null) return null;
    return DateFormat('yyyy-MM-dd').format(parsed);
  }

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), duration: const Duration(seconds: 2)),
    );
  }

  void _close() {
    if (widget.onClose != null) {
      widget.onClose!();
    } else if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final r = widget.report;
    return Container(
      color: kcDashboardBg1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _embeddedHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _readOnlyHeader(r),
                      const SizedBox(height: 20),
                      _imageCard(),
                      const SizedBox(height: 20),
                      _teamCard(),
                      const SizedBox(height: 20),
                      _factsCard(),
                      const SizedBox(height: 20),
                      _rootCauseCard(),
                      const SizedBox(height: 20),
                      _inquiredWithCard(),
                      const SizedBox(height: 20),
                      _capaCard(),
                      const SizedBox(height: 28),
                      _bottomActions(),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _embeddedHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      color: kcvoilet,
      child: Row(
        children: [
          IconButton(
            tooltip: 'Back to list',
            onPressed: _close,
            icon: const Icon(Icons.arrow_back, color: kcWhite),
          ),
          const SizedBox(width: 4),
          const Text(
            'Edit Investigation Report',
            style: TextStyle(
              color: kcWhite,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const Spacer(),
          TextButton.icon(
            onPressed: _saving ? null : _save,
            icon: _saving
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                        strokeWidth: 2, color: kcWhite),
                  )
                : const Icon(Icons.save_outlined, color: kcWhite),
            label: const Text(
              'Save Changes',
              style: TextStyle(
                color: kcWhite,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------- Read-only header ----------
  Widget _readOnlyHeader(InvestigationReportResponse r) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(
          colors: [kcStatBlue, kcInfoResponsibility],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.policy_outlined, color: kcWhite),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  r.incidentUniqueId.isEmpty
                      ? '— Unique Id —'
                      : r.incidentUniqueId,
                  style: const TextStyle(
                    color: kcWhite,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Wrap(
                  spacing: 12,
                  children: [
                    _headerChip('Report ID',
                        r.id == 0 ? '—' : r.id.toString()),
                    _headerChip('Report Date',
                        r.reportDate.isEmpty ? '—' : r.reportDate),
                    if (r.updatedDate.isNotEmpty)
                      _headerChip('Last updated', r.updatedDate),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _headerChip(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.18),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        '$label: $value',
        style: const TextStyle(
            color: kcWhite, fontSize: 11, fontWeight: FontWeight.w600),
      ),
    );
  }

  // ---------- Image ----------
  Widget _imageCard() {
    return _sectionContainer(
      title: 'Associated Risk Image',
      icon: Icons.image_outlined,
      accent: kcInfoPlant,
      child: Column(
        children: [
          GestureDetector(
            onTap: _hasImage() ? _openFullImage : null,
            child: Container(
              height: 220,
              decoration: BoxDecoration(
                color: kcDashboardBg2,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              clipBehavior: Clip.antiAlias,
              child: Stack(
                children: [
                  Positioned.fill(child: _imagePreview()),
                  if (_hasImage())
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.55),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.zoom_in,
                                size: 14, color: kcWhite),
                            SizedBox(width: 4),
                            Text(
                              'Tap to expand',
                              style: TextStyle(
                                  color: kcWhite,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              ElevatedButton.icon(
                onPressed: _pickImage,
                icon: const Icon(Icons.upload_outlined, size: 18),
                label: Text(
                    _newImageBytes != null ? 'Replace image' : 'Change image'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: kcvoilet,
                  foregroundColor: kcWhite,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
              const SizedBox(width: 8),
              if (_newImageBytes != null ||
                  (!_imageRemoved && _existingImageUrl.isNotEmpty))
                OutlinedButton.icon(
                  onPressed: _clearImage,
                  icon: const Icon(Icons.delete_outline,
                      color: kcRed, size: 18),
                  label: const Text('Remove',
                      style: TextStyle(color: kcRed)),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: kcRed),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  bool _hasImage() =>
      _newImageBytes != null ||
      (!_imageRemoved && _existingImageUrl.isNotEmpty);

  void _openFullImage() {
    final Widget content = _newImageBytes != null
        ? Image.memory(_newImageBytes!, fit: BoxFit.contain)
        : Image.network(
            _existingImageUrl,
            fit: BoxFit.contain,
            loadingBuilder: (ctx, child, progress) {
              if (progress == null) return child;
              return const Padding(
                padding: EdgeInsets.all(40),
                child: CircularProgressIndicator(),
              );
            },
            errorBuilder: (_, __, ___) => const Padding(
              padding: EdgeInsets.all(40),
              child: Text(
                'Image unavailable',
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
    showDialog<void>(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: Colors.black,
        insetPadding: const EdgeInsets.all(16),
        child: Stack(
          children: [
            InteractiveViewer(
              minScale: 0.5,
              maxScale: 4,
              child: Center(child: content),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: Material(
                color: Colors.black54,
                shape: const CircleBorder(),
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () => Navigator.of(ctx).pop(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _imagePreview() {
    if (_newImageBytes != null) {
      return Image.memory(_newImageBytes!, fit: BoxFit.contain);
    }
    if (!_imageRemoved && _existingImageUrl.isNotEmpty) {
      return Image.network(
        _existingImageUrl,
        fit: BoxFit.contain,
        errorBuilder: (_, __, ___) => const Center(
          child: Text('Image unavailable',
              style: TextStyle(color: kcLabelGrey)),
        ),
        loadingBuilder: (context, child, progress) {
          if (progress == null) return child;
          return const Center(child: CircularProgressIndicator());
        },
      );
    }
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.image_not_supported_outlined,
              color: kcLabelGrey, size: 32),
          SizedBox(height: 6),
          Text('No image', style: TextStyle(color: kcLabelGrey)),
        ],
      ),
    );
  }

  // ---------- Team ----------
  Widget _teamCard() {
    final canAdd = _team.length < _maxTeam &&
        _team.isNotEmpty &&
        _team.last.empUnqId.isNotEmpty;
    return _sectionContainer(
      title: 'Investigation Team',
      icon: Icons.groups_outlined,
      accent: kcvoilet,
      trailing: _countBadge(_team.length, _maxTeam),
      action: ElevatedButton.icon(
        onPressed: canAdd ? _addTeamMember : null,
        icon: const Icon(Icons.person_add_alt_1, size: 18),
        label: const Text('Add member'),
        style: ElevatedButton.styleFrom(
          backgroundColor: canAdd ? kcvoilet : kcLightGrey,
          foregroundColor: kcWhite,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      child: Column(
        children: [
          for (int i = 0; i < _team.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  SizedBox(
                    width: 28,
                    child: Text('${i + 1}.',
                        style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            color: kcLabelGrey)),
                  ),
                  Expanded(child: _teamMemberPicker(i)),
                  const SizedBox(width: 8),
                  _removeButton(
                    enabled: _team.length > 1,
                    tooltip: 'Remove member',
                    onPressed: () => _removeTeamMember(i),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _teamMemberPicker(int index) {
    final t = _team[index];
    final label = t.empUnqId.isEmpty
        ? 'Select employee'
        : '${t.empUnqId} — ${t.empName}';
    return InkWell(
      onTap: () => _pickTeamEmployee(index),
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: kcWhite,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 13,
                  color: t.empUnqId.isEmpty ? kcLightGrey : kcValueDark,
                  fontWeight: t.empUnqId.isEmpty
                      ? FontWeight.w400
                      : FontWeight.w600,
                ),
              ),
            ),
            if (_loadingEmployees)
              const SizedBox(
                width: 14,
                height: 14,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            else
              const Icon(Icons.arrow_drop_down, size: 18),
          ],
        ),
      ),
    );
  }

  // ---------- Facts Leading to the Incident (points 4 & 5) ----------
  Widget _factsCard() {
    return _sectionContainer(
      title: 'Facts Leading to the Incident or Dangerous Occurrence',
      icon: Icons.fact_check_outlined,
      accent: kcvoilet,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _factsField(
            controller: _machineryDetailsController,
            label:
                'If caused by machinery, mention the name of the machine/equipment and the parts that caused the incident',
            hint:
                'Machine / equipment name and the parts involved (leave blank if not machinery related)',
            required: false,
          ),
          const SizedBox(height: 12),
          _factsField(
            controller: _activityBeforeIncidentController,
            label:
                'What the Injured Person Was Doing Just Before and at the Time of the Occurrence',
            hint:
                'Describe the activity just before and at the time of the occurrence',
            required: true,
          ),
        ],
      ),
    );
  }

  Widget _factsField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required bool required,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (required)
              const Padding(
                padding: EdgeInsets.only(right: 4),
                child: Text('*',
                    style: TextStyle(color: Colors.red, fontSize: 16)),
              ),
            Expanded(
              child: Text(label,
                  style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: kcLabelGrey)),
            ),
          ],
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          maxLines: 3,
          minLines: 2,
          maxLength: _maxFactsChars,
          decoration: _inputDecoration(hint),
        ),
      ],
    );
  }

  // ---------- Root Causes ----------
  Widget _rootCauseCard() {
    final canAdd = _rootCauseControllers.length < _maxRootCauses &&
        _rootCauseControllers.isNotEmpty &&
        _rootCauseControllers.last.text.trim().isNotEmpty;
    return _sectionContainer(
      title: 'Root Causes',
      icon: Icons.search_outlined,
      accent: kcobservationgreen,
      trailing: _countBadge(_rootCauseControllers.length, _maxRootCauses),
      action: ElevatedButton.icon(
        onPressed: canAdd ? _addRootCause : null,
        icon: const Icon(Icons.add, size: 18),
        label: const Text('Add'),
        style: ElevatedButton.styleFrom(
          backgroundColor: canAdd ? kcobservationgreen : kcLightGrey,
          foregroundColor: kcWhite,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      child: Column(
        children: [
          for (int i = 0; i < _rootCauseControllers.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 28,
                    child: Text('${i + 1}.',
                        style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            color: kcLabelGrey)),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _rootCauseControllers[i],
                      onChanged: (_) => setState(() {}),
                      maxLines: 2,
                      minLines: 1,
                      decoration:
                          _inputDecoration('Describe root cause'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  _removeButton(
                    enabled: _rootCauseControllers.length > 1,
                    tooltip: 'Remove root cause',
                    onPressed: () => _removeRootCause(i),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  // ---------- Root Cause – Inquired With (point 6) ----------
  Widget _inquiredWithCard() {
    return _sectionContainer(
      title: 'Root Cause – Inquired With',
      icon: Icons.person_search_outlined,
      accent: kcobservationgreen,
      trailing: Text(
        '${_inquiredWith.length} selected · optional',
        style: const TextStyle(
            fontSize: 12, color: kcLabelGrey, fontWeight: FontWeight.w600),
      ),
      action: ElevatedButton.icon(
        onPressed: _addInquiredWith,
        icon: const Icon(Icons.person_add_alt_1, size: 18),
        label: const Text('Add employee'),
        style: ElevatedButton.styleFrom(
          backgroundColor: kcobservationgreen,
          foregroundColor: kcWhite,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      child: _inquiredWith.isEmpty
          ? const Text(
              'No employee added. Use "Add employee" to select who was inquired '
              'while establishing the root cause (active employees only).',
              style: TextStyle(fontSize: 12.5, color: kcLabelGrey),
            )
          : Column(
              children: [
                for (int i = 0; i < _inquiredWith.length; i++)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 28,
                          child: Text('${i + 1}.',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: kcLabelGrey)),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 10),
                            decoration: BoxDecoration(
                              color: kcWhite,
                              border:
                                  Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${_inquiredWith[i].empUnqId} — ${_inquiredWith[i].empName}',
                                  style: const TextStyle(
                                      fontSize: 13.5,
                                      fontWeight: FontWeight.w700,
                                      color: kcValueDark),
                                ),
                                const SizedBox(height: 4),
                                Wrap(
                                  spacing: 16,
                                  runSpacing: 4,
                                  children: [
                                    _inquiredDetail(
                                        'Station', _inquiredWith[i].statName),
                                    _inquiredDetail(
                                        'Grade', _inquiredWith[i].gradeName),
                                    _inquiredDetail('Designation',
                                        _inquiredWith[i].desgName),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        _removeButton(
                          enabled: true,
                          tooltip: 'Remove',
                          onPressed: () =>
                              setState(() => _inquiredWith.removeAt(i)),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
    );
  }

  Widget _inquiredDetail(String label, String value) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(fontSize: 12.5, color: kcValueDark),
        children: [
          TextSpan(
              text: '$label: ',
              style: const TextStyle(
                  color: kcLabelGrey, fontWeight: FontWeight.w600)),
          TextSpan(
              text: value.trim().isEmpty ? '—' : value,
              style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Future<void> _addInquiredWith() async {
    if (_loadingActiveLookup) {
      _showSnack('Loading active employees, please wait…');
      return;
    }
    if (_activeLookup.isEmpty) {
      _showSnack(_activeLookupError == null
          ? 'Active employee list is empty.'
          : 'Could not load active employees: $_activeLookupError');
      return;
    }
    final picked = await showDialog<ActiveEmployeeLookupModel>(
      context: context,
      builder: (_) => InquiredWithPickerDialog(
        employees: _activeLookup,
        alreadySelected: _inquiredWith.map((e) => e.empUnqId).toSet(),
      ),
    );
    if (picked == null || !mounted) return;
    setState(() => _inquiredWith.add(_InquiredDraft(
          empUnqId: picked.empUnqId,
          empName: picked.empName,
          deptCode: picked.deptCode,
          statName: picked.statName,
          gradeName: picked.gradeName,
          desgName: picked.desgName,
        )));
  }

  // ---------- CAPA ----------
  Widget _capaCard() {
    final canAdd = _capa.length < _maxCapa &&
        _capa.isNotEmpty &&
        _capa.last.capaController.text.trim().isNotEmpty;
    return _sectionContainer(
      title: 'CAPA',
      icon: Icons.fact_check_outlined,
      accent: kcmegenta,
      trailing: _countBadge(_capa.length, _maxCapa),
      action: ElevatedButton.icon(
        onPressed: canAdd ? _addCapa : null,
        icon: const Icon(Icons.add, size: 18),
        label: const Text('Add row'),
        style: ElevatedButton.styleFrom(
          backgroundColor: canAdd ? kcmegenta : kcLightGrey,
          foregroundColor: kcWhite,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      child: Column(
        children: [
          _capaTableHeader(),
          for (int i = 0; i < _capa.length; i++) _capaRow(i),
        ],
      ),
    );
  }

  Widget _capaTableHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [kcobservationgreen, kcInfoPlant],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      child: Row(
        children: const [
          Expanded(flex: 3, child: _HeaderCell('CAPA')),
          Expanded(flex: 4, child: _HeaderCell('Responsible Employee')),
          Expanded(flex: 2, child: _HeaderCell('Station')),
          Expanded(flex: 2, child: _HeaderCell('Target Date')),
          SizedBox(width: 44),
        ],
      ),
    );
  }

  Widget _capaRow(int index) {
    final row = _capa[index];
    final empLabel = row.empCode.isEmpty
        ? 'Select employee'
        : '${row.empCode} — ${row.empName}';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      decoration: BoxDecoration(
        color: index.isOdd ? kcDashboardBg1 : kcWhite,
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: TextField(
                controller: row.capaController,
                onChanged: (_) => setState(() {}),
                maxLines: 2,
                minLines: 1,
                decoration:
                    _inputDecoration('Corrective + preventive action'),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: InkWell(
                onTap: () => _pickCapaEmployee(row),
                borderRadius: BorderRadius.circular(6),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    color: kcWhite,
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          empLabel,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 13,
                            color: row.empCode.isEmpty
                                ? kcLightGrey
                                : kcValueDark,
                            fontWeight: row.empCode.isEmpty
                                ? FontWeight.w400
                                : FontWeight.w600,
                          ),
                        ),
                      ),
                      const Icon(Icons.arrow_drop_down, size: 18),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Text(
                row.statCode.isEmpty ? '—' : _stationDisplay(row),
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: kcValueDark,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: TextField(
                controller: row.targetDateController,
                readOnly: true,
                onTap: () => _pickTargetDate(row),
                decoration: _inputDecoration('DD/MM/YYYY').copyWith(
                  suffixIcon: const Icon(Icons.calendar_today, size: 16),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 44,
            child: _removeButton(
              enabled: _capa.length > 1,
              tooltip: 'Remove row',
              onPressed: () => _removeCapa(index),
            ),
          ),
        ],
      ),
    );
  }

  // ---------- Bottom actions ----------
  Widget _bottomActions() {
    const cancelRed = Color(0xFFDC2626);
    const saveGreen = Color(0xFF16A34A);
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton.icon(
          onPressed: _saving ? null : _close,
          icon: const Icon(Icons.close),
          label: const Text('Cancel'),
          style: ElevatedButton.styleFrom(
            backgroundColor: cancelRed,
            foregroundColor: kcWhite,
            padding:
                const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)),
          ),
        ),
        const SizedBox(width: 12),
        ElevatedButton.icon(
          onPressed: _saving ? null : _save,
          icon: _saving
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                      strokeWidth: 2, color: kcWhite),
                )
              : const Icon(Icons.save_outlined),
          label: const Text('Save Changes'),
          style: ElevatedButton.styleFrom(
            backgroundColor: saveGreen,
            foregroundColor: kcWhite,
            padding:
                const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ],
    );
  }

  // ---------- Shared widgets ----------
  Widget _sectionContainer({
    required String title,
    required IconData icon,
    required Color accent,
    Widget? trailing,
    Widget? action,
    required Widget child,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: kcWhite,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
            decoration: BoxDecoration(
              color: accent.withOpacity(0.08),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: accent.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, size: 18, color: accent),
                ),
                const SizedBox(width: 10),
                Text(title,
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: kcValueDark)),
                const SizedBox(width: 8),
                if (trailing != null) trailing,
                const Spacer(),
                if (action != null) action,
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: child,
          ),
        ],
      ),
    );
  }

  Widget _countBadge(int count, int max) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: kcDashboardBg2,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        '$count / $max',
        style: const TextStyle(
            fontSize: 11,
            color: kcLabelGrey,
            fontWeight: FontWeight.w700),
      ),
    );
  }

  Widget _removeButton({
    required bool enabled,
    required String tooltip,
    required VoidCallback onPressed,
  }) {
    const enabledRed = Color(0xFFDC2626);
    final disabledGrey = Colors.grey.shade400;
    return Container(
      decoration: BoxDecoration(
        color: enabled ? const Color(0xFFFEE2E2) : Colors.transparent,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        tooltip: enabled ? tooltip : null,
        iconSize: 20,
        padding: const EdgeInsets.all(6),
        constraints: const BoxConstraints(),
        icon: Icon(Icons.delete_outline,
            color: enabled ? enabledRed : disabledGrey),
        onPressed: enabled ? onPressed : null,
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      isDense: true,
      hintText: hint,
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: kcvoilet, width: 1.5),
      ),
    );
  }
}

class _SavingDialog extends StatelessWidget {
  const _SavingDialog();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              SizedBox(
                width: 48,
                height: 48,
                child: CircularProgressIndicator(
                  strokeWidth: 4,
                  valueColor:
                      AlwaysStoppedAnimation<Color>(Color(0xFF16A34A)),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Saving changes…',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: kcValueDark,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Please wait',
                style: TextStyle(fontSize: 12, color: kcLabelGrey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeaderCell extends StatelessWidget {
  final String text;
  const _HeaderCell(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Text(
        text,
        style: const TextStyle(
            color: kcWhite,
            fontSize: 12,
            fontWeight: FontWeight.w700),
      ),
    );
  }
}

/// Draft row for "Root Cause – Inquired With" (point 6).
class _InquiredDraft {
  final String empUnqId;
  final String empName;
  final String deptCode;
  final String statName;
  final String gradeName;
  final String desgName;
  const _InquiredDraft({
    required this.empUnqId,
    required this.empName,
    this.deptCode = '',
    this.statName = '',
    this.gradeName = '',
    this.desgName = '',
  });
}

class _TeamDraft {
  int id;
  int seq;
  String empUnqId;
  String empName;

  _TeamDraft({
    required this.id,
    required this.seq,
    required this.empUnqId,
    required this.empName,
  });

  factory _TeamDraft.empty() => _TeamDraft(
        id: 0,
        seq: 0,
        empUnqId: '',
        empName: '',
      );

  void dispose() {}
}

class _CapaDraft {
  int id;
  int seq;
  TextEditingController capaController;
  String empCode;
  String empName;
  String deptCode;
  String statCode;
  String wrkGrp;
  TextEditingController targetDateController;

  _CapaDraft({
    required this.id,
    required this.seq,
    required this.capaController,
    required this.empCode,
    required this.empName,
    required this.deptCode,
    this.statCode = '',
    this.wrkGrp = '',
    required this.targetDateController,
  });

  factory _CapaDraft.empty() => _CapaDraft(
        id: 0,
        seq: 0,
        capaController: TextEditingController(),
        empCode: '',
        empName: '',
        deptCode: '',
        statCode: '',
        wrkGrp: '',
        targetDateController: TextEditingController(),
      );

  void dispose() {
    capaController.dispose();
    targetDateController.dispose();
  }
}
