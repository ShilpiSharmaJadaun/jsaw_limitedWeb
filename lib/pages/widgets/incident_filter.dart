import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jsaw_limited/pages/widgets/observation_filter.dart';
import 'package:jsaw_limited/utils/app_color.dart';
import 'package:jsaw_limited/utils/compact_date_range_picker.dart';

/// Filter model + dialog for the All Incident page tabs (Phase-2 point 2).
///
/// One dialog is shared by the Received / Raised / All tabs; each tab keeps
/// its own [IncidentFilter] and passes it back in as [initial]. The dialog
/// returns the new filter on **Apply**, [IncidentFilter.empty] on **Clear**,
/// and `null` when simply closed.
///
/// Visual pieces ([FilterDropdownChip], [showObservationPicker],
/// [CompactDateRangeField], the violet header, Clear / Apply row) are the same
/// ones the Observation tabs use, so both pages look identical.

// ─────────────────────────────────────────────────────────────────────────────
// Status labels (IncidentReport.Status is the medical → safety stage only)
// ─────────────────────────────────────────────────────────────────────────────
const Map<String, String> kIncidentStatusLabels = {
  'PENDING_MEDICAL_OFFICER': 'Pending Medical Officer',
  'PENDING_SAFETY_REMARKS': 'Pending Safety Remarks',
  // The DB value is CLOSED but it only means the safety remarks are in; the
  // real closure is "Compliance Closure", so avoid the word "Closed" here.
  'CLOSED': 'Safety Completed',
};

String incidentStatusLabel(String code) =>
    kIncidentStatusLabels[code.trim().toUpperCase()] ?? code;

/// Full workflow stage of an incident, for the list cards / view header:
/// medical → safety → investigation → compliance review → closure.
/// [status] = IncidentReport.Status, [investigationStatus] = latest
/// InvestigationReport.Status ('' when no investigation yet).
/// [viewerIsRaiser]: the logged-in user raised this incident — a stage that
/// waits on the raiser reads as theirs ("Pending Your Review").
String incidentStageLabel(String status, String investigationStatus,
    {bool viewerIsRaiser = false}) {
  final inv = investigationStatus.trim().toUpperCase();
  if (inv.isNotEmpty) {
    switch (inv) {
      case 'CLOSED':
        return 'Closed';
      case 'REVIEW_COMPLETED':
      case 'RAISER_REVIEWED':
        return 'Awaiting Closure';
      case 'COMPLETE':
        return viewerIsRaiser ? 'Pending Your Review' : 'Pending Raiser Review';
      default:
        return 'Compliance Pending';
    }
  }
  final st = status.trim().toUpperCase();
  if (st == 'CLOSED') return 'Pending Investigation';
  return incidentStatusLabel(status);
}

/// Colour for [incidentStageLabel] — one DISTINCT colour per workflow stage
/// (customer request Sep-2026), progressing through the chain:
/// Pending Medical Officer (amber) → Pending Safety Remarks (cyan) →
/// Pending Investigation (indigo) → Compliance Pending (blue) →
/// Pending Raiser Review (pink) → Awaiting Closure (purple) → Closed (green).
Color incidentStageColor(String status, String investigationStatus) {
  final inv = investigationStatus.trim().toUpperCase();
  if (inv.isNotEmpty) {
    switch (inv) {
      case 'CLOSED':
        return kcStatGreen;
      case 'REVIEW_COMPLETED':
      case 'RAISER_REVIEWED':
        return kcStatPurple;
      case 'COMPLETE':
        return kcInfoLocation; // pink — waiting on the raiser's review
      default:
        return kcStatBlue; // compliance submissions pending
    }
  }
  switch (status.trim().toUpperCase()) {
    case 'PENDING_MEDICAL_OFFICER':
      return kcStatAmber;
    case 'PENDING_SAFETY_REMARKS':
      return kcObservationCyan;
    case 'CLOSED': // safety done, no investigation yet
      return kcInfoResponsibility; // indigo — Pending Investigation
    default:
      return kcStatAmber;
  }
}

/// Small rounded status chip used on the incident cards and the view header.
class IncidentStagePill extends StatelessWidget {
  const IncidentStagePill({
    super.key,
    required this.status,
    required this.investigationStatus,
    this.viewerIsRaiser = false,
    this.fontSize = 11.5,
  });

  final String status;
  final String investigationStatus;

  /// The logged-in user raised this incident — stages that wait on the raiser
  /// read as "Pending Your Review".
  final bool viewerIsRaiser;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    final color = incidentStageColor(status, investigationStatus);
    final label = incidentStageLabel(status, investigationStatus,
        viewerIsRaiser: viewerIsRaiser);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.55)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 7,
            height: 7,
            decoration: BoxDecoration(shape: BoxShape.circle, color: color),
          ),
          const SizedBox(width: 6),
          Text(label,
              style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w700,
                  color: color)),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// IncidentFilter — immutable value object sent to the API
// ─────────────────────────────────────────────────────────────────────────────
class IncidentFilter {
  const IncidentFilter({
    this.uniqueId = '',
    this.plant = '',
    this.deptName = '',
    this.incidentType = '',
    this.shift = '',
    this.status = '',
    this.employeeSearch = '',
    this.raisedBySearch = '',
    this.incidentDateFrom = '',
    this.incidentDateTo = '',
    this.responsibleShiftEngg = '',
    this.raisedDateFrom = '',
    this.raisedDateTo = '',
  });

  static const IncidentFilter empty = IncidentFilter();

  final String uniqueId;
  final String plant;
  final String deptName;
  final String incidentType;
  final String shift;

  /// Raw status code (PENDING_MEDICAL_OFFICER / PENDING_SAFETY_REMARKS / CLOSED).
  final String status;

  /// Contains-match on the involved employee's name or code.
  final String employeeSearch;

  /// Contains-match on the raiser's name or code.
  final String raisedBySearch;

  /// yyyy-MM-dd, inclusive, on the incident date/time.
  final String incidentDateFrom;
  final String incidentDateTo;

  // Legacy filters kept for the old positional bloc API (not in the dialog).
  final String responsibleShiftEngg;
  final String raisedDateFrom;
  final String raisedDateTo;

  bool get isEmpty => activeCount == 0;

  int get activeCount => chips.length;

  /// Human-readable (label, value) pairs for every active filter — used for
  /// the chip strip above the list. Date range counts as one chip.
  List<MapEntry<String, String>> get chips {
    final out = <MapEntry<String, String>>[];
    if (incidentDateFrom.isNotEmpty || incidentDateTo.isNotEmpty) {
      final from = incidentDateFrom.isEmpty ? '…' : incidentDateFrom;
      final to = incidentDateTo.isEmpty ? '…' : incidentDateTo;
      out.add(MapEntry('Incident Date', '$from → $to'));
    }
    if (plant.isNotEmpty) out.add(MapEntry('Plant', plant));
    if (deptName.isNotEmpty) out.add(MapEntry('Department', deptName));
    if (incidentType.isNotEmpty) out.add(MapEntry('Type', incidentType));
    if (status.isNotEmpty) out.add(MapEntry('Status', incidentStatusLabel(status)));
    if (shift.isNotEmpty) out.add(MapEntry('Shift', shift));
    if (employeeSearch.isNotEmpty) out.add(MapEntry('Employee', employeeSearch));
    if (raisedBySearch.isNotEmpty) out.add(MapEntry('Raised By', raisedBySearch));
    if (uniqueId.isNotEmpty) out.add(MapEntry('Incident ID', uniqueId));
    if (responsibleShiftEngg.isNotEmpty) {
      out.add(MapEntry('Shift Engineer', responsibleShiftEngg));
    }
    if (raisedDateFrom.isNotEmpty || raisedDateTo.isNotEmpty) {
      out.add(MapEntry('Raised Date', '$raisedDateFrom → $raisedDateTo'));
    }
    return out;
  }

  /// Request-body fragment understood by
  /// `incidentReport/getIncidentReportFullViewByShiftEngg`.
  Map<String, dynamic> toBody() => {
        'uniqueId': uniqueId,
        'plant': plant,
        'deptName': deptName,
        'incidentType': incidentType,
        'shift': shift,
        'status': status,
        'employeeSearch': employeeSearch,
        'raisedBySearch': raisedBySearch,
        'incidentDateFrom': incidentDateFrom,
        'incidentDateTo': incidentDateTo,
        'responsibleShiftEngg': responsibleShiftEngg,
        'firDateTimeFrom': raisedDateFrom,
        'firDateTimeTo': raisedDateTo,
      };

  IncidentFilter copyWith({
    String? uniqueId,
    String? plant,
    String? deptName,
    String? incidentType,
    String? shift,
    String? status,
    String? employeeSearch,
    String? raisedBySearch,
    String? incidentDateFrom,
    String? incidentDateTo,
    String? responsibleShiftEngg,
    String? raisedDateFrom,
    String? raisedDateTo,
  }) =>
      IncidentFilter(
        uniqueId: uniqueId ?? this.uniqueId,
        plant: plant ?? this.plant,
        deptName: deptName ?? this.deptName,
        incidentType: incidentType ?? this.incidentType,
        shift: shift ?? this.shift,
        status: status ?? this.status,
        employeeSearch: employeeSearch ?? this.employeeSearch,
        raisedBySearch: raisedBySearch ?? this.raisedBySearch,
        incidentDateFrom: incidentDateFrom ?? this.incidentDateFrom,
        incidentDateTo: incidentDateTo ?? this.incidentDateTo,
        responsibleShiftEngg: responsibleShiftEngg ?? this.responsibleShiftEngg,
        raisedDateFrom: raisedDateFrom ?? this.raisedDateFrom,
        raisedDateTo: raisedDateTo ?? this.raisedDateTo,
      );
}

// ─────────────────────────────────────────────────────────────────────────────
// IncidentFilterOptions — distinct values from incidentReport/getFilterOptions
// ─────────────────────────────────────────────────────────────────────────────
class PlantDepartment {
  const PlantDepartment({required this.plant, required this.deptName});
  final String plant;
  final String deptName;
}

class IncidentFilterOptions {
  const IncidentFilterOptions({
    this.plants = const [],
    this.departments = const [],
    this.incidentTypes = const [],
    this.shifts = const [],
    this.uniqueIds = const [],
  });

  final List<String> plants;
  final List<PlantDepartment> departments;
  final List<String> incidentTypes;
  final List<String> shifts;
  final List<String> uniqueIds;

  static List<String> _strings(dynamic v) => v is List
      ? v.map((e) => e?.toString() ?? '').where((e) => e.isNotEmpty).toList()
      : const [];

  factory IncidentFilterOptions.fromJson(Map<String, dynamic> json,
      {List<String> uniqueIds = const []}) {
    final deps = <PlantDepartment>[];
    final rawDeps = json['departments'];
    if (rawDeps is List) {
      for (final d in rawDeps) {
        if (d is Map) {
          deps.add(PlantDepartment(
            plant: d['plant']?.toString() ?? '',
            deptName: d['deptName']?.toString() ?? '',
          ));
        }
      }
    }
    return IncidentFilterOptions(
      plants: _strings(json['plants']),
      departments: deps,
      incidentTypes: _strings(json['incidentTypes']),
      shifts: _strings(json['shifts']),
      uniqueIds: uniqueIds,
    );
  }

  IncidentFilterOptions withUniqueIds(List<String> ids) => IncidentFilterOptions(
        plants: plants,
        departments: departments,
        incidentTypes: incidentTypes,
        shifts: shifts,
        uniqueIds: ids,
      );

  /// Departments for [plant] (all departments when no plant chosen).
  List<String> departmentsFor(String plant) {
    final list = plant.isEmpty
        ? departments
        : departments.where((d) => d.plant == plant).toList();
    final names = list.map((d) => d.deptName).toSet().toList()..sort();
    return names;
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// showIncidentFilterDialog
// ─────────────────────────────────────────────────────────────────────────────
Future<IncidentFilter?> showIncidentFilterDialog({
  required BuildContext context,
  required IncidentFilter initial,
  required Future<IncidentFilterOptions> options,
  bool showEmployee = true,
  bool showRaisedBy = true,
  // false on pages whose status is fixed (Medical / Safety Pending & Complete).
  bool showStatus = true,
}) {
  return showDialog<IncidentFilter>(
    context: context,
    builder: (_) => _IncidentFilterDialog(
      initial: initial,
      options: options,
      showEmployee: showEmployee,
      showRaisedBy: showRaisedBy,
      showStatus: showStatus,
    ),
  );
}

class _IncidentFilterDialog extends StatefulWidget {
  const _IncidentFilterDialog({
    required this.initial,
    required this.options,
    required this.showEmployee,
    required this.showRaisedBy,
    this.showStatus = true,
  });

  final IncidentFilter initial;
  final Future<IncidentFilterOptions> options;
  final bool showEmployee;
  final bool showRaisedBy;
  final bool showStatus;

  @override
  State<_IncidentFilterDialog> createState() => _IncidentFilterDialogState();
}

class _IncidentFilterDialogState extends State<_IncidentFilterDialog> {
  // Pickers (display value == stored value for these).
  late final ValueNotifier<String> plant;
  late final ValueNotifier<String> dept;
  late final ValueNotifier<String> type;
  late final ValueNotifier<String> shift;
  late final ValueNotifier<String> statusLabel; // shows the friendly label
  late final ValueNotifier<String> uniqueId;
  String statusCode = '';

  // Text + date inputs.
  late final TextEditingController employeeCtl;
  late final TextEditingController raisedByCtl;
  late final TextEditingController startDateCtl;
  late final TextEditingController endDateCtl;

  @override
  void initState() {
    super.initState();
    final f = widget.initial;
    plant = ValueNotifier(f.plant);
    dept = ValueNotifier(f.deptName);
    type = ValueNotifier(f.incidentType);
    shift = ValueNotifier(f.shift);
    statusCode = f.status;
    statusLabel = ValueNotifier(f.status.isEmpty ? '' : incidentStatusLabel(f.status));
    uniqueId = ValueNotifier(f.uniqueId);
    employeeCtl = TextEditingController(text: f.employeeSearch);
    raisedByCtl = TextEditingController(text: f.raisedBySearch);
    startDateCtl = TextEditingController(text: f.incidentDateFrom);
    endDateCtl = TextEditingController(text: f.incidentDateTo);
  }

  @override
  void dispose() {
    plant.dispose();
    dept.dispose();
    type.dispose();
    shift.dispose();
    statusLabel.dispose();
    uniqueId.dispose();
    employeeCtl.dispose();
    raisedByCtl.dispose();
    startDateCtl.dispose();
    endDateCtl.dispose();
    super.dispose();
  }

  IncidentFilter _collect() => IncidentFilter(
        uniqueId: uniqueId.value,
        plant: plant.value,
        deptName: dept.value,
        incidentType: type.value,
        shift: shift.value,
        status: widget.showStatus ? statusCode : '',
        employeeSearch: widget.showEmployee ? employeeCtl.text.trim() : '',
        raisedBySearch: widget.showRaisedBy ? raisedByCtl.text.trim() : '',
        incidentDateFrom: startDateCtl.text.trim(),
        incidentDateTo: endDateCtl.text.trim(),
        // Legacy fields are not editable here; carry them through untouched.
        responsibleShiftEngg: widget.initial.responsibleShiftEngg,
        raisedDateFrom: widget.initial.raisedDateFrom,
        raisedDateTo: widget.initial.raisedDateTo,
      );

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: SizedBox(
        width: 380,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _header(context),
            Flexible(
              child: FutureBuilder<IncidentFilterOptions>(
                future: widget.options,
                builder: (context, snap) {
                  final opts = snap.data;
                  final loading =
                      snap.connectionState != ConnectionState.done && opts == null;
                  return SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _section('Incident Date', [
                          CompactDateRangeField(
                            startController: startDateCtl,
                            endController: endDateCtl,
                          ),
                        ]),
                        _section('Location', [
                          loading ? const LoadingChip() : _plantChip(opts),
                          const SizedBox(height: 8),
                          loading ? const LoadingChip() : _deptChip(opts),
                        ]),
                        _section('Classification', [
                          loading ? const LoadingChip() : _typeChip(opts),
                          if (widget.showStatus) ...[
                            const SizedBox(height: 8),
                            _statusChip(),
                          ],
                          const SizedBox(height: 8),
                          loading ? const LoadingChip() : _shiftChip(opts),
                        ]),
                        if (widget.showEmployee || widget.showRaisedBy)
                          _section('People', [
                            if (widget.showEmployee)
                              _textField(employeeCtl,
                                  'Employee name or code', Icons.person_outline),
                            if (widget.showEmployee && widget.showRaisedBy)
                              const SizedBox(height: 8),
                            if (widget.showRaisedBy)
                              _textField(raisedByCtl,
                                  'Raised by (name or code)', Icons.campaign_outlined),
                          ]),
                        _section('Incident ID', [
                          loading ? const LoadingChip() : _uniqueIdChip(opts),
                        ]),
                        if (snap.hasError)
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(
                              'Could not load filter options — text and date filters still work.',
                              style: TextStyle(
                                  fontSize: 11, color: Colors.red.shade400),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
            _actions(context),
          ],
        ),
      ),
    );
  }

  // ── header / actions ──────────────────────────────────────────────────────
  Widget _header(BuildContext context) => Container(
        padding: const EdgeInsets.fromLTRB(20, 16, 16, 16),
        decoration: const BoxDecoration(
          color: kcvoilet,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Row(
          children: [
            const Icon(Icons.filter_alt_outlined, color: kcWhite, size: 20),
            const SizedBox(width: 10),
            const Expanded(
              child: Text('Filter Incidents',
                  style: TextStyle(
                      color: kcWhite,
                      fontSize: 16,
                      fontWeight: FontWeight.w600)),
            ),
            IconButton(
              icon: const Icon(Icons.close, color: kcWhite, size: 20),
              onPressed: () => Navigator.pop(context),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ],
        ),
      );

  Widget _actions(BuildContext context) => Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: kcVeryLightGrey, width: 1)),
        ),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () => Navigator.pop(context, IncidentFilter.empty),
                style: OutlinedButton.styleFrom(
                  foregroundColor: kcLightGrey,
                  side: const BorderSide(color: kcVeryLightGrey),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                icon: const Icon(Icons.clear_all_rounded, size: 16),
                label: const Text('Clear',
                    style: TextStyle(fontWeight: FontWeight.w600)),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 2,
              child: ElevatedButton.icon(
                onPressed: () => Navigator.pop(context, _collect()),
                style: ElevatedButton.styleFrom(
                  backgroundColor: kcvoilet,
                  foregroundColor: kcWhite,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                icon: const Icon(Icons.check_rounded, size: 16),
                label: const Text('Apply Filters',
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
              ),
            ),
          ],
        ),
      );

  // ── fields ────────────────────────────────────────────────────────────────
  Widget _plantChip(IncidentFilterOptions? o) => FilterDropdownChip(
        notifier: plant,
        placeholder: 'Filter Plant',
        onTap: () => showObservationPicker<String>(
          context: context,
          title: 'Select Plant',
          items: o?.plants ?? const [],
          label: (s) => s,
          filter: (s, q) => s.toLowerCase().contains(q.toLowerCase()),
          onSelect: (s) {
            plant.value = s;
            // Department belongs to a plant; drop it if it no longer fits.
            if (o != null && !o.departmentsFor(s).contains(dept.value)) {
              dept.value = '';
            }
          },
        ),
      );

  Widget _deptChip(IncidentFilterOptions? o) => FilterDropdownChip(
        notifier: dept,
        placeholder: 'Filter Department',
        onTap: () => showObservationPicker<String>(
          context: context,
          title: plant.value.isEmpty
              ? 'Select Department'
              : 'Select Department (${plant.value})',
          items: o?.departmentsFor(plant.value) ?? const [],
          label: (s) => s,
          filter: (s, q) => s.toLowerCase().contains(q.toLowerCase()),
          onSelect: (s) {
            dept.value = s;
            // Auto-fill the plant when the user picked a department first.
            if (plant.value.isEmpty && o != null) {
              final owner = o.departments.where((d) => d.deptName == s);
              if (owner.length == 1) plant.value = owner.first.plant;
            }
          },
        ),
      );

  Widget _typeChip(IncidentFilterOptions? o) => FilterDropdownChip(
        notifier: type,
        placeholder: 'Filter Incident Type',
        onTap: () => showObservationPicker<String>(
          context: context,
          title: 'Select Incident Type',
          items: o?.incidentTypes ?? const [],
          label: (s) => s,
          filter: (s, q) => s.toLowerCase().contains(q.toLowerCase()),
          onSelect: (s) => type.value = s,
        ),
      );

  Widget _shiftChip(IncidentFilterOptions? o) => FilterDropdownChip(
        notifier: shift,
        placeholder: 'Filter Shift',
        onTap: () => showObservationPicker<String>(
          context: context,
          title: 'Select Shift',
          items: o?.shifts ?? const [],
          label: (s) => s,
          filter: (s, q) => s.toLowerCase().contains(q.toLowerCase()),
          onSelect: (s) => shift.value = s,
        ),
      );

  Widget _statusChip() => FilterDropdownChip(
        notifier: statusLabel,
        placeholder: 'Filter Status',
        onTap: () => showObservationPicker<MapEntry<String, String>>(
          context: context,
          title: 'Select Status',
          items: kIncidentStatusLabels.entries.toList(),
          label: (e) => e.value,
          filter: (e, q) => e.value.toLowerCase().contains(q.toLowerCase()),
          onSelect: (e) {
            statusCode = e.key;
            statusLabel.value = e.value;
          },
        ),
      );

  Widget _uniqueIdChip(IncidentFilterOptions? o) => FilterDropdownChip(
        notifier: uniqueId,
        placeholder: 'Filter Incident ID',
        onTap: () => showObservationPicker<String>(
          context: context,
          title: 'Select Incident ID',
          items: o?.uniqueIds ?? const [],
          label: (s) => s,
          filter: (s, q) => s.toLowerCase().contains(q.toLowerCase()),
          onSelect: (s) => uniqueId.value = s,
        ),
      );

  Widget _textField(TextEditingController ctl, String hint, IconData icon) =>
      SizedBox(
        height: 44,
        child: TextField(
          controller: ctl,
          style: const TextStyle(fontSize: 14, color: kcValueDark),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: kcLightGrey, fontSize: 14),
            prefixIcon: Icon(icon, size: 18, color: kcLightGrey),
            suffixIcon: ValueListenableBuilder<TextEditingValue>(
              valueListenable: ctl,
              builder: (_, v, __) => v.text.isEmpty
                  ? const SizedBox.shrink()
                  : IconButton(
                      icon: const Icon(Icons.close, size: 16, color: kcLightGrey),
                      onPressed: ctl.clear,
                    ),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            filled: true,
            fillColor: kcWhite,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: kcVeryLightGrey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: kcvoilet),
            ),
          ),
        ),
      );

  Widget _section(String label, List<Widget> children) => Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: kcLightGrey,
                    letterSpacing: 0.8)),
            const SizedBox(height: 8),
            ...children,
          ],
        ),
      );
}

// ─────────────────────────────────────────────────────────────────────────────
// Observation-style page button (Prev / Next) — identical to observation.dart
// ─────────────────────────────────────────────────────────────────────────────
Widget incidentPageButton({
  required IconData icon,
  required String label,
  required bool enabled,
  required VoidCallback onPressed,
  bool iconAfter = false,
}) {
  return AnimatedOpacity(
    opacity: enabled ? 1.0 : 0.35,
    duration: const Duration(milliseconds: 200),
    child: ElevatedButton(
      onPressed: enabled ? onPressed : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: kcvoilet,
        foregroundColor: kcWhite,
        disabledBackgroundColor: kcLightGrey,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        elevation: 0,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: iconAfter
            ? [
                Text(label,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 13)),
                const SizedBox(width: 4),
                Icon(icon, size: 18),
              ]
            : [
                Icon(icon, size: 18),
                const SizedBox(width: 4),
                Text(label,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 13)),
              ],
      ),
    ),
  );
}

/// "Page x of y" pill — identical to the Observation pages.
Widget incidentPagePill(int currentPage, int totalPages) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: kcvoilet.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: kcvoilet.withValues(alpha: 0.15), width: 1),
      ),
      child: Text(
        'Page ${totalPages == 0 ? 0 : currentPage} of $totalPages',
        style: const TextStyle(
            fontSize: 13, fontWeight: FontWeight.w600, color: kcvoilet),
      ),
    );

// ─────────────────────────────────────────────────────────────────────────────
// IncidentFilterBar — top bar with the same design as the All Observation
// page: Prev | Page x of y | Refresh · Filter · Export Excel · Next, plus the
// active-filter chips underneath when a filter is applied.
// ─────────────────────────────────────────────────────────────────────────────
class IncidentFilterBar extends StatelessWidget {
  const IncidentFilterBar({
    super.key,
    required this.filter,
    required this.onOpen,
    required this.onClear,
    required this.onRefresh,
    required this.currentPage,
    required this.totalPages,
    required this.hasPrev,
    required this.hasNext,
    required this.onPrev,
    required this.onNext,
    this.exporting = false,
    this.onExport,
    this.showPaging = true,
  });

  final IncidentFilter filter;
  final VoidCallback onOpen;
  final VoidCallback onClear;
  final VoidCallback onRefresh;

  /// false on lists that are not server-paged (Medical / Safety pages):
  /// hides Prev · page pill · Next and right-aligns Reset · Filter · Excel.
  final bool showPaging;

  /// 1-based page index and total page count from the bloc.
  final int currentPage;
  final int totalPages;
  final bool hasPrev;
  final bool hasNext;
  final VoidCallback onPrev;
  final VoidCallback onNext;

  /// Export to Excel (Phase-2 point 3); spinner while [exporting].
  final bool exporting;
  final VoidCallback? onExport;

  @override
  Widget build(BuildContext context) {
    final chips = filter.chips;
    return Container(
      decoration: const BoxDecoration(
        color: kcWhite,
        border: Border(bottom: BorderSide(color: kcVeryLightGrey, width: 1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (showPaging)
                  incidentPageButton(
                    icon: Icons.chevron_left_rounded,
                    label: 'Prev',
                    enabled: hasPrev,
                    onPressed: onPrev,
                  ),
                if (showPaging)
                  incidentPagePill(currentPage, totalPages)
                else
                  const Spacer(),
                Row(
                  children: [
                    // Refresh
                    IconButton(
                      onPressed: onRefresh,
                      style: IconButton.styleFrom(
                        backgroundColor: kcgreen,
                        foregroundColor: kcMediumGrey,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                      ),
                      tooltip: 'Reset — clear filters and reload',
                      icon: const Icon(Icons.refresh),
                    ),
                    const SizedBox(width: 10),
                    // Filter
                    ElevatedButton.icon(
                      onPressed: onOpen,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kcvoilet,
                        foregroundColor: kcWhite,
                        fixedSize: const Size(120, 38),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        elevation: 0,
                      ),
                      icon: const Icon(Icons.filter_alt_outlined, size: 16),
                      label: Text(
                          filter.isEmpty
                              ? 'Filter'
                              : 'Filter (${filter.activeCount})',
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 14)),
                    ),
                    const SizedBox(width: 10),
                    // Export Excel — icon only (Phase-3 bug 1c).
                    ExcelExportIconButton(
                        onPressed: onExport, busy: exporting),
                    if (showPaging) const SizedBox(width: 10),
                    if (showPaging)
                    incidentPageButton(
                      icon: Icons.chevron_right_rounded,
                      label: 'Next',
                      enabled: hasNext,
                      onPressed: onNext,
                      iconAfter: true,
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (chips.isNotEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: [
                        for (final c in chips)
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: kcvoilet.withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: kcvoilet.withValues(alpha: 0.25)),
                            ),
                            child: RichText(
                              text: TextSpan(
                                style: const TextStyle(
                                    fontSize: 12, color: kcValueDark),
                                children: [
                                  TextSpan(
                                      text: '${c.key}: ',
                                      style: const TextStyle(
                                          color: kcLabelGrey,
                                          fontWeight: FontWeight.w600)),
                                  TextSpan(text: c.value),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  TextButton.icon(
                    onPressed: onClear,
                    style: TextButton.styleFrom(foregroundColor: kcLabelGrey),
                    icon: const Icon(Icons.clear_all_rounded, size: 16),
                    label: const Text('Clear filters'),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

/// Icon-only "Export to Excel" button (Phase-3 bug 1c / 2 / 4 — customer wants
/// the Excel icon without text). White 38×38 square, green outline, spinner
/// while [busy]; the label lives in the tooltip.
class ExcelExportIconButton extends StatelessWidget {
  const ExcelExportIconButton({
    super.key,
    required this.onPressed,
    this.busy = false,
    this.size = 38,
    this.tooltip = 'Export to Excel',
  });

  final VoidCallback? onPressed;
  final bool busy;
  final double size;
  final String tooltip;

  @override
  Widget build(BuildContext context) {
    if (busy) {
      return SizedBox(
        width: size,
        height: size,
        child: Padding(
          padding: EdgeInsets.all(size * 0.24),
          child: const CircularProgressIndicator(strokeWidth: 2),
        ),
      );
    }
    return Tooltip(
      message: tooltip,
      child: Material(
        color: kcWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(color: kcobservationgreen, width: 1.2),
        ),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(8),
          child: SizedBox(
            width: size,
            height: size,
            child: Center(
              child: Image.asset('assets/images/excelicon.png',
                  width: size * 0.53, height: size * 0.53),
            ),
          ),
        ),
      ),
    );
  }
}

/// Icon-only "Investigation Report (PDF)" download button (Phase-3, user
/// request 29-Aug-2026: icon without text, like the Excel export button).
/// White square with a red outline and PDF icon; spinner while [busy]; the
/// label lives in the tooltip.
class PdfDownloadIconButton extends StatelessWidget {
  const PdfDownloadIconButton({
    super.key,
    required this.onPressed,
    this.busy = false,
    this.size = 38,
    this.tooltip = 'Download Investigation Report (PDF)',
  });

  final VoidCallback? onPressed;
  final bool busy;
  final double size;
  final String tooltip;

  @override
  Widget build(BuildContext context) {
    final iconSize = size * 0.55;
    if (busy) {
      return SizedBox(
        width: size,
        height: size,
        child: Padding(
          padding: EdgeInsets.all(size * 0.25),
          child: const CircularProgressIndicator(
              strokeWidth: 2, color: kcPdfIconRed),
        ),
      );
    }
    return Tooltip(
      message: tooltip,
      child: Material(
        color: kcWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(color: kcPdfIconRed, width: 1.2),
        ),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(8),
          child: SizedBox(
            width: size,
            height: size,
            child: Center(
              child: Icon(Icons.picture_as_pdf_outlined,
                  size: iconSize, color: kcPdfIconRed),
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Client-side matcher (Phase-3 point 2 / 4): the Medical Assessment and Safety
// Remarks lists are loaded whole (no server paging), so the shared filter is
// applied in the browser. Status / Raised-by are not part of those lists.
// ─────────────────────────────────────────────────────────────────────────────
final DateFormat _kIncidentDateTimeFmt = DateFormat('dd-MMMM-yyyy h:mm:ss a');

DateTime? parseIncidentDateTime(String raw) {
  final v = raw.trim();
  if (v.isEmpty) return null;
  try {
    return _kIncidentDateTimeFmt.parse(v);
  } catch (_) {
    return DateTime.tryParse(v);
  }
}

bool incidentFilterMatches(
  IncidentFilter f, {
  required String uniqueId,
  required String incidentDateTime,
  required String plant,
  required String deptName,
  required String incidentType,
  required String shift,
  required String employeeName,
  required String employeeCode,
}) {
  if (f.isEmpty) return true;
  bool eq(String a, String b) => a.trim().toLowerCase() == b.trim().toLowerCase();

  if (f.uniqueId.isNotEmpty && !eq(uniqueId, f.uniqueId)) return false;
  if (f.plant.isNotEmpty && !eq(plant, f.plant)) return false;
  if (f.deptName.isNotEmpty && !eq(deptName, f.deptName)) return false;
  if (f.incidentType.isNotEmpty && !eq(incidentType, f.incidentType)) {
    return false;
  }
  if (f.shift.isNotEmpty) {
    final s = shift.trim().toLowerCase();
    final want = f.shift.trim().toLowerCase();
    if (s != want && !s.startsWith(want)) return false;
  }
  if (f.employeeSearch.isNotEmpty) {
    final q = f.employeeSearch.trim().toLowerCase();
    if (!employeeName.toLowerCase().contains(q) &&
        !employeeCode.toLowerCase().contains(q)) {
      return false;
    }
  }
  if (f.incidentDateFrom.isNotEmpty || f.incidentDateTo.isNotEmpty) {
    final dt = parseIncidentDateTime(incidentDateTime);
    if (dt == null) return false;
    final day = DateTime(dt.year, dt.month, dt.day);
    if (f.incidentDateFrom.isNotEmpty) {
      final from = DateTime.tryParse(f.incidentDateFrom);
      if (from != null && day.isBefore(from)) return false;
    }
    if (f.incidentDateTo.isNotEmpty) {
      final to = DateTime.tryParse(f.incidentDateTo);
      if (to != null && day.isAfter(to)) return false;
    }
  }
  return true;
}

/// Round "open" chevron (Phase-3 bug 4: the customer wants the ">" symbol
/// instead of the "Check Details" text on the Safety Remarks lists).
class IncidentOpenChevronButton extends StatelessWidget {
  const IncidentOpenChevronButton({
    super.key,
    required this.onPressed,
    this.busy = false,
    this.tooltip = 'Open',
    this.color = kcStatBlue,
  });

  final VoidCallback? onPressed;
  final bool busy;
  final String tooltip;
  final Color color;

  @override
  Widget build(BuildContext context) {
    if (busy) {
      return const SizedBox(
        width: 34,
        height: 34,
        child: Padding(
          padding: EdgeInsets.all(8),
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      );
    }
    return Tooltip(
      message: tooltip,
      child: Material(
        color: color,
        shape: const CircleBorder(),
        elevation: 2,
        child: InkWell(
          onTap: onPressed,
          customBorder: const CircleBorder(),
          child: const SizedBox(
            width: 34,
            height: 34,
            child: Icon(Icons.chevron_right_rounded, color: kcWhite, size: 24),
          ),
        ),
      ),
    );
  }
}
