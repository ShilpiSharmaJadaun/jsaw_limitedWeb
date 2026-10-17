import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:web/web.dart' show window;

import '../../model/allIncident_model.dart';
import '../../model/employeeBasicDetail_model.dart';
import '../../model/employeeResponsibility_model.dart';
import '../../model/employeeShift_model.dart';
import '../../service/observation_service.dart';
import '../../utils/employee_picker.dart';
import '../../utils/progressive_image.dart';
import '../incident_Reporting_page.dart' show OtherEmployeeDialog, OtherEmployeeDetails;
import '../../service/incident_admin_service.dart';
import '../../service/incident_service.dart';
import '../../utils/app_color.dart';

/// HSE-only Edit / Delete dialogs for an incident (customer request Oct-2026).
///
/// Each `show…` function returns `true` when the server accepted the change, so the
/// caller can reload. Edits never change the workflow status and send no mail.

final _admin = IncidentAdminService();
final _lookups = IncidentService();

final DateFormat _displayDateTime = DateFormat('dd-MMMM-yyyy h:mm:ss a');
final DateFormat _displayDate = DateFormat('dd-MMMM-yyyy');
final DateFormat _apiDateTime = DateFormat('yyyy-MM-dd HH:mm:ss');
final DateFormat _apiDate = DateFormat('yyyy-MM-dd');

DateTime? _tryParse(DateFormat f, String v) {
  if (v.trim().isEmpty) return null;
  try {
    return f.parseLoose(v.trim());
  } catch (_) {
    return null;
  }
}

void _toast(BuildContext context, String msg) {
  ScaffoldMessenger.maybeOf(context)
    ?..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(msg)));
}

String _err(Object e) => e.toString().replaceFirst('Exception: ', '');

// ─────────────────────────────────────────────────────────────── incident

Future<bool> showEditIncidentDialog(BuildContext context, AllIncidentModel r) async {
  final observationService = Provider.of<ObservationService>(context, listen: false);
  final res = await showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (_) => _EditIncidentDialog(r: r, observationService: observationService),
  );
  return res == true;
}

/// Same controls as the Incident Reporting form: employee picker (fills code, age,
/// contractor, work group, plant, department), shift / gender / location / HOD /
/// incident-type pickers, date-time picker. Responsible Shift Engg stays read-only.
class _EditIncidentDialog extends StatefulWidget {
  const _EditIncidentDialog({required this.r, required this.observationService});
  final AllIncidentModel r;
  final ObservationService observationService;

  @override
  State<_EditIncidentDialog> createState() => _EditIncidentDialogState();
}

class _EditIncidentDialogState extends State<_EditIncidentDialog> {
  // Employee block — set together by the employee picker, read-only otherwise.
  late String _empName, _empCode, _age, _contName, _contCode, _wrkGrp;
  late String _plant, _plantCode, _dept, _deptCode;
  late String _gender, _shift, _location, _hod, _type;
  DateTime? _when;
  late final TextEditingController _contact;
  late final TextEditingController _descp;
  Uint8List? _newImage;
  bool _busy = false;

  List<EmployeeBasicDetailModel>? _employees;
  List<EmployeeShiftModel> _shifts = const [];
  List<String> _types = const [];
  List<String> _locations = const [];
  List<EmployeeResponsibilityModel> _hods = const [];

  AllIncidentModel get r => widget.r;

  @override
  void initState() {
    super.initState();
    _empName = r.employeeName;
    _empCode = r.employeeCode;
    _age = r.age == 0 ? '' : '${r.age}';
    _contName = r.contractorName;
    _contCode = r.contCode;
    _wrkGrp = r.wrkGrp;
    _plant = r.plant.trim();
    _plantCode = r.plantCode;
    _dept = r.deptName.trim();
    _deptCode = r.deptCode;
    _gender = r.gender;
    _shift = r.shift;
    _location = r.location;
    _hod = r.responsibleHod;
    _type = r.incidentType;
    _when = _tryParse(_displayDateTime, r.incidentDateTime);
    _contact = TextEditingController(text: r.contactNumber);
    _descp = TextEditingController(text: r.descpOfIncident);

    _lookups.getEmployeeShift().then((l) {
      if (mounted) setState(() => _shifts = l);
    }).catchError((_) {});
    _lookups.getAllTypeOfIncident().then((l) {
      if (mounted) {
        setState(() => _types =
            l.map((e) => e.description).where((s) => s.isNotEmpty).toSet().toList());
      }
    }).catchError((_) {});
    _loadLocations();
    _lookups.getEmployeeBasicDetail().then((l) {
      if (!mounted) return;
      setState(() => _employees = l);
      _loadHods(l);
    }).catchError((_) {
      if (mounted) setState(() => _employees = const []);
    });
  }

  @override
  void dispose() {
    _contact.dispose();
    _descp.dispose();
    super.dispose();
  }

  void _loadLocations() {
    if (_deptCode.trim().isEmpty) return;
    widget.observationService.getAllLocation(_deptCode).then((l) {
      if (mounted) {
        setState(() => _locations =
            l.map((e) => e.locations).where((s) => s.trim().isNotEmpty).toSet().toList());
      }
    }).catchError((_) {});
  }

  /// HOD list as the raiser saw it (raiser's dept / station / grade), falling back to
  /// the logged-in user when the raiser is not in the employee list.
  void _loadHods(List<EmployeeBasicDetailModel> employees) {
    final raiserCode = r.raisedByEmpCode.trim();
    EmployeeBasicDetailModel? raiser;
    for (final e in employees) {
      if (raiserCode.isNotEmpty && e.empCode.trim() == raiserCode) {
        raiser = e;
        break;
      }
    }
    final ls = window.localStorage;
    widget.observationService
        .getResponsibleHOD(
          raiser?.deptCode ?? ls.getItem('kdepart') ?? '',
          raiser?.statCode ?? ls.getItem('kstatCode') ?? '',
          raiser?.gradeCode ?? ls.getItem('kGradeCode') ?? '',
          raiser?.empCode ?? ls.getItem('kEmployeeCode') ?? '',
        )
        .then((l) {
      if (mounted) setState(() => _hods = l);
    }).catchError((_) {});
  }

  Future<void> _pickEmployee() async {
    final list = _employees;
    if (list == null) return;
    final picked = await showEmployeePicker<EmployeeBasicDetailModel>(
      context,
      items: list,
      name: (e) => e.empName,
      code: (e) => e.empCode,
      title: 'Select Employee',
      onOther: _otherEmployee,
      otherLabel: 'Others — injured person not in the list',
      otherSubtitle: "Enter the injured person's details manually",
    );
    if (picked == null || !mounted) return;
    final deptChanged = picked.deptCode != _deptCode;
    setState(() {
      _empName = picked.empName;
      _empCode = picked.empCode;
      _age = picked.age == 0 ? '' : '${picked.age}';
      _contName = picked.contName;
      _contCode = picked.contCode;
      _wrkGrp = picked.wrkGrp;
      _plant = picked.statName;
      _plantCode = picked.statCode;
      _dept = picked.deptName;
      _deptCode = picked.deptCode;
      if (deptChanged) {
        _location = '';
        _locations = const [];
      }
    });
    if (deptChanged) _loadLocations();
  }

  Future<void> _otherEmployee() async {
    final result = await showDialog<OtherEmployeeDetails>(
      context: context,
      builder: (_) => OtherEmployeeDialog(
        observationService: widget.observationService,
        initial: _empCode == 'OTHER'
            ? OtherEmployeeDetails(
                name: _empName,
                age: _age,
                contractorName: _contName,
                wrkGrp: _wrkGrp,
                deptName: _dept,
                deptCode: _deptCode,
                statName: _plant,
                statCode: _plantCode,
              )
            : null,
      ),
    );
    if (result == null || !mounted) return;
    setState(() {
      _empName = result.name;
      _empCode = 'OTHER';
      _age = result.age;
      _contName = result.contractorName;
      _contCode = '';
      _wrkGrp = result.wrkGrp;
      _dept = result.deptName;
      _deptCode = result.deptCode;
      _plant = result.statName;
      _plantCode = result.statCode;
      _location = '';
      _locations = const [];
    });
    _loadLocations();
  }

  Future<void> _pickWhen() async {
    final base = _when ?? DateTime.now();
    final d = await showDatePicker(
      context: context,
      initialDate: base.isAfter(DateTime.now()) ? DateTime.now() : base,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (d == null || !mounted) return;
    final t = await showTimePicker(context: context, initialTime: TimeOfDay.fromDateTime(base));
    if (!mounted) return;
    setState(() => _when =
        DateTime(d.year, d.month, d.day, t?.hour ?? base.hour, t?.minute ?? base.minute));
  }

  Future<void> _pickHod() async {
    final picked = await showEmployeePicker<EmployeeResponsibilityModel>(
      context,
      items: _hods,
      name: (e) => e.empName,
      code: (e) => e.empUnqId,
      title: 'Select Responsible HOD',
    );
    if (picked != null && mounted) setState(() => _hod = picked.empName);
  }

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (picked == null) return;
    final bytes = await picked.readAsBytes();
    if (mounted) setState(() => _newImage = bytes);
  }

  Future<void> _save() async {
    final missing = <String>[
      if (_empName.trim().isEmpty) 'Employee Name',
      if (_when == null) 'Date & Time',
      if (_shift.trim().isEmpty) 'Shift',
      if (_location.trim().isEmpty) 'Location',
      if (_hod.trim().isEmpty) 'Responsible HOD',
      if (_type.trim().isEmpty) 'Type of Incident',
      if (_descp.text.trim().isEmpty) 'Description of Incident',
    ];
    if (missing.isNotEmpty) {
      _toast(context, 'Please fill: ${missing.join(', ')}');
      return;
    }
    setState(() => _busy = true);
    try {
      final msg = await _admin.updateIncident(
        incidentUniqueId: r.uniqueId,
        newImageBytes: _newImage,
        fields: {
          'employeeCode': _empCode,
          'employeeName': _empName,
          'age': int.tryParse(_age.trim())?.toString() ?? '0',
          'gender': _gender,
          'wrkGrp': _wrkGrp,
          'contractorName': _contName,
          'contCode': _contCode,
          'plant': _plant,
          'plantCode': _plantCode,
          'deptName': _dept,
          'deptCode': _deptCode,
          'location': _location,
          'responsibleShiftEngg': r.responsibleShiftEngg,
          'responsibleHod': _hod,
          'contactNumber': _contact.text.trim(),
          'incidentType': _type,
          'descpOfIncident': _descp.text.trim(),
          'incidentDateTime': _apiDateTime.format(_when!),
          'shift': _shift,
        },
      );
      if (!mounted) return;
      _toast(context, msg);
      Navigator.pop(context, true);
    } catch (e) {
      if (mounted) _toast(context, _err(e));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final shiftLabel = _shifts
        .where((s) => s.shiftCode == _shift)
        .map((s) => '${s.shiftCode} — ${s.shiftDesc}')
        .firstOrNull;
    return _AdminDialog(
      title: 'Edit Incident — ${r.uniqueId}',
      busy: _busy,
      onSave: _save,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _Grid(children: [
            _PickerField(
              label: 'Employee Name',
              value: _empName,
              icon: _employees == null ? Icons.hourglass_empty : Icons.person_search_outlined,
              onTap: _busy || _employees == null ? null : _pickEmployee,
            ),
            _ReadOnlyField(label: 'Employee Code', value: _empCode),
            _PickerField(
              label: 'Date & Time',
              value: _when == null ? '' : _displayDateTime.format(_when!),
              icon: Icons.event,
              onTap: _busy ? null : _pickWhen,
            ),
            _ReadOnlyField(label: 'Contractor Name', value: _contName),
            _PickerField(
              label: 'Shift',
              value: shiftLabel ?? _shift,
              icon: Icons.schedule,
              onTap: _busy
                  ? null
                  : () async {
                      final v = await _pickOne(
                        context,
                        title: 'Select Shift',
                        options: [for (final s in _shifts) s.shiftCode],
                        label: (code) {
                          final s = _shifts.firstWhere((x) => x.shiftCode == code);
                          return '${s.shiftCode} — ${s.shiftDesc}';
                        },
                      );
                      if (v != null && mounted) setState(() => _shift = v);
                    },
            ),
            _ReadOnlyField(label: 'Age', value: _age),
            _DropField(
              label: 'Gender',
              value: _gender,
              options: const ['Male', 'Female'],
              onChanged: (v) => setState(() => _gender = v),
            ),
            _ReadOnlyField(label: 'Work Group', value: _wrkGrp),
            _ReadOnlyField(label: 'Plant', value: _plant),
            _ReadOnlyField(label: 'Department Name', value: _dept),
            _PickerField(
              label: 'Location',
              value: _location,
              icon: Icons.place_outlined,
              onTap: _busy
                  ? null
                  : () async {
                      final v = await _pickOne(context,
                          title: 'Select Location', options: _locations);
                      if (v != null && mounted) setState(() => _location = v);
                    },
            ),
            _ReadOnlyField(label: 'Responsible Shift Engg', value: r.responsibleShiftEngg),
            _PickerField(
              label: 'Responsible HOD',
              value: _hod,
              icon: Icons.supervisor_account_outlined,
              onTap: _busy ? null : _pickHod,
            ),
            _Field(label: 'Contact Number', controller: _contact, number: true),
            _PickerField(
              label: 'Type of Incident',
              value: _type,
              icon: Icons.category_outlined,
              onTap: _busy
                  ? null
                  : () async {
                      final v = await _pickOne(context,
                          title: 'Select Type of Incident', options: _types);
                      if (v != null && mounted) setState(() => _type = v);
                    },
            ),
          ]),
          const SizedBox(height: 12),
          _Field(label: 'Description of Incident', controller: _descp, lines: 4),
          const SizedBox(height: 12),
          _ImagePreview(
            label: 'Incident Image',
            currentUrl: r.imageUrl,
            currentLowUrl: r.lowQualityImageUrl,
            newBytes: _newImage,
            onPick: _busy ? null : _pickImage,
            onUndo: _newImage == null ? null : () => setState(() => _newImage = null),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────── medical

Future<bool> showEditMedicalDialog(BuildContext context, AllIncidentModel r) async {
  final res = await showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (_) => _EditMedicalDialog(r: r),
  );
  return res == true;
}

class _EditMedicalDialog extends StatefulWidget {
  const _EditMedicalDialog({required this.r});
  final AllIncidentModel r;

  @override
  State<_EditMedicalDialog> createState() => _EditMedicalDialogState();
}

class _EditMedicalDialogState extends State<_EditMedicalDialog> {
  late String _nature;
  late Set<String> _parts;
  late final TextEditingController _rest;
  late final TextEditingController _remarks;
  DateTime? _fit;
  bool _busy = false;
  List<String> _natureOptions = const [];
  List<String> _partOptions = const [];

  @override
  void initState() {
    super.initState();
    final r = widget.r;
    _nature = r.natureOfInjury;
    _parts = r.bodyPart.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toSet();
    _rest = TextEditingController(text: r.restUpto);
    _remarks = TextEditingController(text: r.medicalOfficerRemarks);
    _fit = _tryParse(_displayDate, r.fitForDutyFrom);
    // Medical "Nature Of Injury" is picked from the Type-of-Incident list (same as the medical form).
    _lookups.getAllTypeOfIncident().then((l) {
      if (mounted) setState(() => _natureOptions = l.map((e) => e.description).where((s) => s.isNotEmpty).toSet().toList());
    }).catchError((_) {});
    _lookups.getAllBodyParts().then((l) {
      // Inc_BodyParts holds duplicate names — de-duplicate case-insensitively.
      final seen = <String>{};
      final names = <String>[];
      for (final p in l) {
        final n = p.description.trim();
        if (n.isNotEmpty && seen.add(n.toUpperCase())) names.add(n);
      }
      if (mounted) setState(() => _partOptions = names);
    }).catchError((_) {});
  }

  @override
  void dispose() {
    _rest.dispose();
    _remarks.dispose();
    super.dispose();
  }

  Future<void> _pickParts() async {
    final picked = await showDialog<Set<String>>(
      context: context,
      builder: (_) => _MultiPickDialog(
        title: 'Body Parts',
        options: {..._partOptions, ..._parts}.toList(),
        selected: _parts,
      ),
    );
    if (picked != null && mounted) setState(() => _parts = picked);
  }

  Future<void> _save() async {
    final bodyPart = _parts.join(', ');
    if (bodyPart.length > 255) {
      _toast(context, 'Too many body parts selected — please remove some.');
      return;
    }
    setState(() => _busy = true);
    try {
      final msg = await _admin.updateMedical({
        'incidentUniqueId': widget.r.uniqueId,
        'bodyPart': bodyPart,
        'natureOfInjury': _nature,
        'restUpto': int.tryParse(_rest.text.trim()),
        'fitForDutyFrom': _fit == null ? '' : _apiDate.format(_fit!),
        'medicalOfficerRemarks': _remarks.text.trim(),
      });
      if (!mounted) return;
      _toast(context, msg);
      Navigator.pop(context, true);
    } catch (e) {
      if (mounted) _toast(context, _err(e));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _AdminDialog(
      title: 'Edit Medical Assessment — ${widget.r.uniqueId}',
      busy: _busy,
      onSave: _save,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _Grid(children: [
            _PickerField(
              label: 'Nature of Injury',
              value: _nature,
              icon: Icons.local_hospital_outlined,
              onTap: _busy
                  ? null
                  : () async {
                      final v = await _pickOne(context,
                          title: 'Select Nature of Injury', options: _natureOptions);
                      if (v != null && mounted) setState(() => _nature = v);
                    },
            ),
            _PickerField(
              label: 'Body Parts',
              value: _parts.join(', '),
              icon: Icons.accessibility_new_rounded,
              onTap: _busy ? null : _pickParts,
            ),
            _Field(label: 'Rest Upto (days)', controller: _rest, number: true),
            _PickerField(
              label: 'Fit For Duty From',
              value: _fit == null ? '' : _displayDate.format(_fit!),
              icon: Icons.event,
              onTap: _busy
                  ? null
                  : () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _fit ?? DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (d != null && mounted) setState(() => _fit = d);
                    },
              onClear: _fit == null ? null : () => setState(() => _fit = null),
            ),
          ]),
          const SizedBox(height: 12),
          _Field(label: 'Medical Officer Remarks', controller: _remarks, lines: 4),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────── safety

Future<bool> showEditSafetyDialog(BuildContext context, AllIncidentModel r) async {
  final res = await showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (_) => _EditSafetyDialog(r: r),
  );
  return res == true;
}

class _EditSafetyDialog extends StatefulWidget {
  const _EditSafetyDialog({required this.r});
  final AllIncidentModel r;

  @override
  State<_EditSafetyDialog> createState() => _EditSafetyDialogState();
}

class _EditSafetyDialogState extends State<_EditSafetyDialog> {
  late String _type;
  late final TextEditingController _remarks;
  bool _busy = false;
  List<String> _options = const [];

  @override
  void initState() {
    super.initState();
    _type = widget.r.safetyTypeOfInjury;
    _remarks = TextEditingController(text: widget.r.safetyRemarks);
    // Safety "Type Of Injury" is picked from the Nature-of-Injury list (same as the safety form).
    _lookups.getAllNatureInjuryDetail().then((l) {
      if (mounted) setState(() => _options = l.map((e) => e.description).where((s) => s.isNotEmpty).toSet().toList());
    }).catchError((_) {});
  }

  @override
  void dispose() {
    _remarks.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_type.trim().isEmpty || _remarks.text.trim().isEmpty) {
      _toast(context, 'Type of Injury and Safety Remarks are required');
      return;
    }
    setState(() => _busy = true);
    try {
      final msg = await _admin.updateSafety({
        'incidentUniqueId': widget.r.uniqueId,
        'typeOfInjury': _type.trim(),
        'safetyRemarks': _remarks.text.trim(),
      });
      if (!mounted) return;
      _toast(context, msg);
      Navigator.pop(context, true);
    } catch (e) {
      if (mounted) _toast(context, _err(e));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _AdminDialog(
      title: 'Edit Safety Observation — ${widget.r.uniqueId}',
      busy: _busy,
      onSave: _save,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _PickerField(
            label: 'Type of Injury',
            value: _type,
            icon: Icons.healing_outlined,
            onTap: _busy
                ? null
                : () async {
                    final v = await _pickOne(context,
                        title: 'Select Type of Injury', options: _options);
                    if (v != null && mounted) setState(() => _type = v);
                  },
          ),
          const SizedBox(height: 12),
          _Field(label: "Safety Officer's Remark", controller: _remarks, lines: 5),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────── compliance

Future<bool> showEditComplianceDialog(BuildContext context, String incidentUniqueId) async {
  final res = await showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (_) => _EditComplianceDialog(uid: incidentUniqueId),
  );
  return res == true;
}

class _EditComplianceDialog extends StatefulWidget {
  const _EditComplianceDialog({required this.uid});
  final String uid;

  @override
  State<_EditComplianceDialog> createState() => _EditComplianceDialogState();
}

class _EditComplianceDialogState extends State<_EditComplianceDialog> {
  List<ComplianceSubmissionRow>? _rows;
  String? _loadError;
  ComplianceSubmissionRow? _sel;
  final _remark = TextEditingController();
  final _review = TextEditingController();
  Uint8List? _newImage;
  bool _clearImage = false;
  bool _busy = false;
  bool _changed = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _remark.dispose();
    _review.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    try {
      final all = await _admin.getComplianceSubmissions(widget.uid);
      // Newest row per engineer is the live one (same rule as the compliance pages).
      final seen = <String>{};
      final latest = all.where((s) => seen.add(s.empUnqId.trim().toUpperCase())).toList();
      if (!mounted) return;
      setState(() {
        _rows = latest;
        if (latest.isNotEmpty) _select(latest.first);
      });
    } catch (e) {
      if (mounted) setState(() => _loadError = _err(e));
    }
  }

  void _select(ComplianceSubmissionRow s) {
    _sel = s;
    _remark.text = s.remark;
    _review.text = s.reviewRemark;
    _newImage = null;
    _clearImage = false;
  }

  Future<void> _save() async {
    final s = _sel;
    if (s == null) return;
    if (_remark.text.trim().isEmpty) {
      _toast(context, 'Compliance remark is required');
      return;
    }
    setState(() => _busy = true);
    try {
      final msg = await _admin.updateComplianceSubmission(
        id: s.id,
        remark: _remark.text.trim(),
        reviewRemark: _review.text.trim(),
        newImageBytes: _newImage,
        clearImage: _clearImage && _newImage == null,
      );
      if (!mounted) return;
      _toast(context, msg);
      _changed = true;
      setState(() => _rows = null);
      await _load();
    } catch (e) {
      if (mounted) _toast(context, _err(e));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final rows = _rows;
    Widget body;
    if (_loadError != null) {
      body = Text(_loadError!, style: const TextStyle(color: Colors.red));
    } else if (rows == null) {
      body = const Padding(
          padding: EdgeInsets.all(24), child: Center(child: CircularProgressIndicator()));
    } else if (rows.isEmpty) {
      body = const Text('No compliance has been submitted for this incident yet.');
    } else {
      body = Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DropdownButtonFormField<int>(
            value: _sel?.id,
            decoration: _dec('Engineer'),
            items: [
              for (final s in rows)
                DropdownMenuItem(
                    value: s.id,
                    child: Text('${s.empName} (${s.empUnqId}) · ${s.status}',
                        overflow: TextOverflow.ellipsis)),
            ],
            onChanged: _busy
                ? null
                : (id) => setState(() => _select(rows.firstWhere((s) => s.id == id))),
          ),
          const SizedBox(height: 12),
          _Field(label: 'Compliance Remark', controller: _remark, lines: 4),
          const SizedBox(height: 12),
          _Field(label: 'Review / Reopen Remark', controller: _review, lines: 3),
          const SizedBox(height: 12),
          _ImagePreview(
            label: 'Compliance Image',
            currentUrl: _clearImage ? '' : (_sel?.imageUrl ?? ''),
            newBytes: _newImage,
            onPick: _busy
                ? null
                : () async {
                    final p = await ImagePicker()
                        .pickImage(source: ImageSource.gallery, imageQuality: 80);
                    if (p == null) return;
                    final b = await p.readAsBytes();
                    if (mounted) setState(() => _newImage = b);
                  },
            onUndo: _newImage == null ? null : () => setState(() => _newImage = null),
            onRemove: (_sel?.imageUrl ?? '').isEmpty || _clearImage || _newImage != null
                ? null
                : () => setState(() => _clearImage = true),
          ),
        ],
      );
    }
    return _AdminDialog(
      title: 'Edit Compliance — ${widget.uid}',
      busy: _busy,
      onSave: rows == null || rows.isEmpty ? null : _save,
      saveLabel: 'Save This Engineer',
      onCancel: () => Navigator.pop(context, _changed),
      cancelLabel: 'Close',
      child: body,
    );
  }
}

// ─────────────────────────────────────────────────────────────── delete

/// Two-step confirmation (warning + typed reason). Returns true once deleted.
Future<bool> showDeleteIncidentDialog(BuildContext context, AllIncidentModel r) async {
  final res = await showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (_) => _DeleteIncidentDialog(r: r),
  );
  return res == true;
}

class _DeleteIncidentDialog extends StatefulWidget {
  const _DeleteIncidentDialog({required this.r});
  final AllIncidentModel r;

  @override
  State<_DeleteIncidentDialog> createState() => _DeleteIncidentDialogState();
}

class _DeleteIncidentDialogState extends State<_DeleteIncidentDialog> {
  final _reason = TextEditingController();
  bool _busy = false;

  @override
  void dispose() {
    _reason.dispose();
    super.dispose();
  }

  Future<void> _delete() async {
    setState(() => _busy = true);
    try {
      final msg = await _admin.deleteIncident(widget.r.uniqueId, _reason.text.trim());
      if (!mounted) return;
      _toast(context, msg);
      Navigator.pop(context, true);
    } catch (e) {
      if (mounted) _toast(context, _err(e));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final canDelete = !_busy && _reason.text.trim().isNotEmpty;
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      titlePadding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
      title: const Row(
        children: [
          Icon(Icons.warning_amber_rounded, color: Colors.red, size: 28),
          SizedBox(width: 10),
          Expanded(
            child: Text('Delete incident permanently?',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
          ),
        ],
      ),
      content: SizedBox(
        width: 480,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: 0.07),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.red.withValues(alpha: 0.35)),
              ),
              child: Text(
                'This will permanently delete incident ${widget.r.uniqueId} and all its '
                'Medical Assessment, Safety Observation, Investigation, CAPA and Compliance '
                'records and images.\n\nThis action cannot be revoked. Are you sure you want to delete?',
                style: const TextStyle(fontSize: 13.5, height: 1.4, color: kcValueDark),
              ),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: _reason,
              enabled: !_busy,
              maxLength: 1000,
              maxLines: 3,
              onChanged: (_) => setState(() {}),
              decoration: _dec('Reason for deleting (required)'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _busy ? null : () => Navigator.pop(context, false),
          child: const Text('Cancel'),
        ),
        ElevatedButton.icon(
          onPressed: canDelete ? _delete : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: kcWhite,
            disabledBackgroundColor: kcVeryLightGrey,
          ),
          icon: _busy
              ? const SizedBox(
                  width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
              : const Icon(Icons.delete_forever),
          label: const Text('Yes, Delete Permanently'),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────── shared bits

/// Small "Edit" pill used in the View page section headers.
class HseEditButton extends StatelessWidget {
  const HseEditButton({super.key, required this.onPressed, this.label = 'Edit'});
  final VoidCallback? onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: kcvoilet,
        side: const BorderSide(color: kcvoilet),
        visualDensity: VisualDensity.compact,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      icon: const Icon(Icons.edit_outlined, size: 16),
      label: Text(label, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12.5)),
    );
  }
}

InputDecoration _dec(String label) => InputDecoration(
      labelText: label,
      isDense: true,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
    );

class _AdminDialog extends StatelessWidget {
  const _AdminDialog({
    required this.title,
    required this.child,
    required this.busy,
    required this.onSave,
    this.saveLabel = 'Save Changes',
    this.onCancel,
    this.cancelLabel = 'Cancel',
  });
  final String title;
  final Widget child;
  final bool busy;
  final VoidCallback? onSave;
  final String saveLabel;
  final VoidCallback? onCancel;
  final String cancelLabel;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 17)),
      content: SizedBox(
        width: 760,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                margin: const EdgeInsets.only(bottom: 14),
                decoration: BoxDecoration(
                  color: kcvoilet.withValues(alpha: 0.07),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'HSE edit — the workflow status stays as it is and no e-mail is sent.',
                  style: TextStyle(fontSize: 12.5, color: kcLabelGrey),
                ),
              ),
              child,
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: busy ? null : (onCancel ?? () => Navigator.pop(context, false)),
          child: Text(cancelLabel),
        ),
        ElevatedButton.icon(
          onPressed: busy ? null : onSave,
          style: ElevatedButton.styleFrom(backgroundColor: kcvoilet, foregroundColor: kcWhite),
          icon: busy
              ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
              : const Icon(Icons.save_outlined),
          label: Text(saveLabel),
        ),
      ],
    );
  }
}

/// Two columns on wide dialogs, one on narrow.
class _Grid extends StatelessWidget {
  const _Grid({required this.children});
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, c) {
      final two = c.maxWidth > 520;
      final w = two ? (c.maxWidth - 12) / 2 : c.maxWidth;
      return Wrap(
        spacing: 12,
        runSpacing: 12,
        children: [for (final ch in children) SizedBox(width: w, child: ch)],
      );
    });
  }
}

class _Field extends StatelessWidget {
  const _Field({required this.label, required this.controller, this.lines = 1, this.number = false});
  final String label;
  final TextEditingController controller;
  final int lines;
  final bool number;

  @override
  Widget build(BuildContext context) => TextField(
        controller: controller,
        minLines: lines,
        maxLines: lines == 1 ? 1 : lines + 4,
        keyboardType: number ? TextInputType.number : TextInputType.text,
        decoration: _dec(label),
      );
}

class _PickerField extends StatelessWidget {
  const _PickerField({
    required this.label,
    required this.value,
    required this.icon,
    required this.onTap,
    this.onClear,
  });
  final String label;
  final String value;
  final IconData icon;
  final VoidCallback? onTap;
  final VoidCallback? onClear;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: InputDecorator(
          decoration: _dec(label).copyWith(
            suffixIcon: onClear != null
                ? IconButton(icon: const Icon(Icons.clear, size: 18), onPressed: onClear)
                : Icon(icon, size: 18),
          ),
          child: Text(value.isEmpty ? '—' : value,
              maxLines: 2, overflow: TextOverflow.ellipsis),
        ),
      );
}

/// Dropdown that always contains the current value, even if it is no longer in the lookup list.
class _DropField extends StatelessWidget {
  const _DropField({
    required this.label,
    required this.value,
    required this.options,
    required this.onChanged,
  });
  final String label;
  final String value;
  final List<String> options;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final items = <String>{if (value.trim().isNotEmpty) value, ...options}.toList();
    return DropdownButtonFormField<String>(
      value: value.trim().isEmpty ? null : value,
      isExpanded: true,
      decoration: _dec(label),
      items: [
        for (final o in items)
          DropdownMenuItem(value: o, child: Text(o, overflow: TextOverflow.ellipsis)),
      ],
      onChanged: (v) {
        if (v != null) onChanged(v);
      },
    );
  }
}

/// Current image (or the newly picked one) shown as a picture, with Replace / Undo / Remove.
class _ImagePreview extends StatelessWidget {
  const _ImagePreview({
    required this.label,
    required this.currentUrl,
    required this.newBytes,
    required this.onPick,
    required this.onUndo,
    this.currentLowUrl = '',
    this.onRemove,
  });
  final String label;
  final String currentUrl;
  final String currentLowUrl;
  final Uint8List? newBytes;
  final VoidCallback? onPick;
  final VoidCallback? onUndo;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    final hasCurrent = currentUrl.trim().isNotEmpty;
    Widget picture;
    if (newBytes != null) {
      picture = Image.memory(newBytes!, fit: BoxFit.contain);
    } else if (hasCurrent) {
      picture = ProgressiveImage(
        highUrl: currentUrl,
        lowUrl: currentLowUrl.trim().isEmpty ? null : currentLowUrl,
        fit: BoxFit.contain,
      );
    } else {
      picture = const Center(
        child: Text('No image', style: TextStyle(color: kcLabelGrey, fontSize: 13)),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Text(label,
                style: const TextStyle(
                    fontSize: 12.5, color: kcLabelGrey, fontWeight: FontWeight.w700)),
            const SizedBox(width: 8),
            if (newBytes != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: kcStatGreen.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text('New image — saved when you click Save',
                    style: TextStyle(
                        fontSize: 11.5, color: kcStatGreen, fontWeight: FontWeight.w700)),
              ),
            const Spacer(),
            if (onUndo != null) TextButton(onPressed: onUndo, child: const Text('Undo')),
            if (onRemove != null)
              TextButton(onPressed: onRemove, child: const Text('Remove image')),
            OutlinedButton.icon(
              onPressed: onPick,
              icon: const Icon(Icons.upload_outlined, size: 16),
              label: Text(hasCurrent || newBytes != null ? 'Replace image' : 'Add image'),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Container(
          height: 220,
          decoration: BoxDecoration(
            color: kcDashboardBg2,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade300),
          ),
          clipBehavior: Clip.antiAlias,
          child: picture,
        ),
      ],
    );
  }
}

/// Value filled from another pick (e.g. the employee) — shown greyed, not editable.
class _ReadOnlyField extends StatelessWidget {
  const _ReadOnlyField({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => InputDecorator(
        decoration: _dec(label).copyWith(
          filled: true,
          fillColor: kcDashboardBg1,
          suffixIcon: const Icon(Icons.lock_outline, size: 16, color: kcLabelGrey),
        ),
        child: Text(value.trim().isEmpty ? '—' : value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: kcLabelGrey)),
      );
}

/// Searchable single-choice list (Shift, Location, Type of Incident, …), like the
/// pickers on the original forms. Returns the chosen option or null.
Future<String?> _pickOne(
  BuildContext context, {
  required String title,
  required List<String> options,
  String Function(String)? label,
}) {
  return showDialog<String>(
    context: context,
    builder: (_) => _SinglePickDialog(title: title, options: options, label: label),
  );
}

class _SinglePickDialog extends StatefulWidget {
  const _SinglePickDialog({required this.title, required this.options, this.label});
  final String title;
  final List<String> options;
  final String Function(String)? label;

  @override
  State<_SinglePickDialog> createState() => _SinglePickDialogState();
}

class _SinglePickDialogState extends State<_SinglePickDialog> {
  String _q = '';

  String _text(String o) => widget.label?.call(o) ?? o;

  @override
  Widget build(BuildContext context) {
    final shown = widget.options
        .where((o) => _text(o).toLowerCase().contains(_q.toLowerCase()))
        .toList();
    return AlertDialog(
      title: Text(widget.title),
      content: SizedBox(
        width: 420,
        height: 440,
        child: Column(
          children: [
            TextField(
              autofocus: true,
              decoration: _dec('Search').copyWith(prefixIcon: const Icon(Icons.search)),
              onChanged: (v) => setState(() => _q = v),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: widget.options.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : shown.isEmpty
                      ? const Center(child: Text('No match'))
                      : ListView.separated(
                          itemCount: shown.length,
                          separatorBuilder: (_, __) => const Divider(height: 1),
                          itemBuilder: (_, i) => ListTile(
                            dense: true,
                            title: Text(_text(shown[i])),
                            onTap: () => Navigator.pop(context, shown[i]),
                          ),
                        ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
      ],
    );
  }
}

class _MultiPickDialog extends StatefulWidget {
  const _MultiPickDialog({required this.title, required this.options, required this.selected});
  final String title;
  final List<String> options;
  final Set<String> selected;

  @override
  State<_MultiPickDialog> createState() => _MultiPickDialogState();
}

class _MultiPickDialogState extends State<_MultiPickDialog> {
  late final Set<String> _sel = {...widget.selected};
  String _q = '';

  @override
  Widget build(BuildContext context) {
    final shown = widget.options
        .where((o) => o.toLowerCase().contains(_q.toLowerCase()))
        .toList();
    return AlertDialog(
      title: Text(widget.title),
      content: SizedBox(
        width: 420,
        height: 440,
        child: Column(
          children: [
            TextField(
              decoration: _dec('Search').copyWith(prefixIcon: const Icon(Icons.search)),
              onChanged: (v) => setState(() => _q = v),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView(
                children: [
                  for (final o in shown)
                    CheckboxListTile(
                      dense: true,
                      value: _sel.contains(o),
                      title: Text(o),
                      onChanged: (v) => setState(() => v == true ? _sel.add(o) : _sel.remove(o)),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        ElevatedButton(
          onPressed: () => Navigator.pop(context, _sel),
          child: Text('Done (${_sel.length})'),
        ),
      ],
    );
  }
}
