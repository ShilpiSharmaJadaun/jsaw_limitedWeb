import 'package:flutter/foundation.dart' show Uint8List;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../model/allemployee_model.dart';
import '../model/investigationReport_response_model.dart';
import '../service/employee_reporting_service.dart';
import '../service/incident_service.dart';
import '../service/observation_service.dart';
import '../utils/app_color.dart';
import 'employee_picker_dialog.dart';

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
  Map<String, String> _deptCodeToName = {};

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

    _loadEmployees();
    _loadDepartments();
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

  Future<void> _loadEmployees() async {
    setState(() => _loadingEmployees = true);
    try {
      final service =
          Provider.of<EmployeeReportingService>(context, listen: false);
      final list = await service.getAllEmployee();
      if (!mounted) return;
      setState(() {
        _allEmployees = list;
        _loadingEmployees = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() => _loadingEmployees = false);
    }
  }

  Future<void> _loadDepartments() async {
    try {
      final service = Provider.of<ObservationService>(context, listen: false);
      final plants = await service.getAllPlant();
      if (!mounted) return;
      setState(() {
        _deptCodeToName = {
          for (final p in plants)
            if (p.deptCode.isNotEmpty) p.deptCode: p.deptName,
        };
      });
    } catch (_) {
      // Non-fatal; falls back to deptCode
    }
  }

  String _deptDisplay(String? deptCode) {
    if (deptCode == null || deptCode.isEmpty) return '';
    return _deptCodeToName[deptCode] ?? deptCode;
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
    });
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
                      _rootCauseCard(),
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
          Expanded(flex: 2, child: _HeaderCell('Department')),
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
                row.deptCode.isEmpty ? '—' : _deptDisplay(row.deptCode),
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
  TextEditingController targetDateController;

  _CapaDraft({
    required this.id,
    required this.seq,
    required this.capaController,
    required this.empCode,
    required this.empName,
    required this.deptCode,
    required this.targetDateController,
  });

  factory _CapaDraft.empty() => _CapaDraft(
        id: 0,
        seq: 0,
        capaController: TextEditingController(),
        empCode: '',
        empName: '',
        deptCode: '',
        targetDateController: TextEditingController(),
      );

  void dispose() {
    capaController.dispose();
    targetDateController.dispose();
  }
}
