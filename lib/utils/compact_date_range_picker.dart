import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jsaw_limited/utils/app_color.dart';

/// Compact, dialog-sized replacement for [showDateRangePicker], which renders
/// fullscreen on web. Shows one month at a time with quick presets, a From/To
/// summary, and Apply / Cancel. Returns null if dismissed.
Future<DateTimeRange?> showCompactDateRangePicker(
  BuildContext context, {
  DateTimeRange? initialRange,
  DateTime? firstDate,
  DateTime? lastDate,
  String title = 'Select Date Range',
}) {
  return showDialog<DateTimeRange>(
    context: context,
    barrierColor: Colors.black38,
    builder: (_) => _CompactDateRangeDialog(
      initialRange: initialRange,
      firstDate: firstDate ?? DateTime(2000),
      lastDate: lastDate ?? DateTime.now(),
      title: title,
    ),
  );
}

class _CompactDateRangeDialog extends StatefulWidget {
  final DateTimeRange? initialRange;
  final DateTime firstDate;
  final DateTime lastDate;
  final String title;

  const _CompactDateRangeDialog({
    required this.initialRange,
    required this.firstDate,
    required this.lastDate,
    required this.title,
  });

  @override
  State<_CompactDateRangeDialog> createState() =>
      _CompactDateRangeDialogState();
}

class _CompactDateRangeDialogState extends State<_CompactDateRangeDialog> {
  static const _dayNames = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
  static final _fmtLong = DateFormat('dd MMM yyyy');
  static final _fmtMonth = DateFormat('MMMM yyyy');

  DateTime? _start;
  DateTime? _end;
  late DateTime _visibleMonth;
  late final DateTime _first;
  late final DateTime _last;

  @override
  void initState() {
    super.initState();
    _first = _day(widget.firstDate);
    _last = _day(widget.lastDate);
    _start = widget.initialRange == null ? null : _day(widget.initialRange!.start);
    _end = widget.initialRange == null ? null : _day(widget.initialRange!.end);
    final anchor = _end ?? _start ?? _last;
    _visibleMonth = DateTime(anchor.year, anchor.month);
  }

  static DateTime _day(DateTime d) => DateTime(d.year, d.month, d.day);

  bool _same(DateTime? a, DateTime? b) =>
      a != null && b != null && a.year == b.year && a.month == b.month && a.day == b.day;

  bool _isDisabled(DateTime d) => d.isBefore(_first) || d.isAfter(_last);

  bool get _canGoPrev =>
      DateTime(_visibleMonth.year, _visibleMonth.month, 1).isAfter(_first);

  bool get _canGoNext =>
      DateTime(_visibleMonth.year, _visibleMonth.month + 1, 1).isBefore(_last) ||
      _same(DateTime(_visibleMonth.year, _visibleMonth.month + 1, 1), _last);

  void _shiftMonth(int delta) => setState(() =>
      _visibleMonth = DateTime(_visibleMonth.year, _visibleMonth.month + delta));

  void _onTapDay(DateTime d) {
    setState(() {
      if (_start == null || (_start != null && _end != null)) {
        _start = d;
        _end = null;
      } else if (d.isBefore(_start!)) {
        _end = _start;
        _start = d;
      } else {
        _end = d;
      }
    });
  }

  void _applyPreset(DateTime s, DateTime e) {
    final start = _day(s).isBefore(_first) ? _first : _day(s);
    final end = _day(e).isAfter(_last) ? _last : _day(e);
    setState(() {
      _start = start;
      _end = end;
      _visibleMonth = DateTime(end.year, end.month);
    });
  }

  List<_Preset> get _presets {
    final today = _day(DateTime.now());
    final thisMonthStart = DateTime(today.year, today.month, 1);
    final lastMonthStart = DateTime(today.year, today.month - 1, 1);
    final lastMonthEnd = DateTime(today.year, today.month, 0);
    return [
      _Preset('Today', today, today),
      _Preset('7 days', today.subtract(const Duration(days: 6)), today),
      _Preset('30 days', today.subtract(const Duration(days: 29)), today),
      _Preset('This month', thisMonthStart, today),
      _Preset('Last month', lastMonthStart, lastMonthEnd),
    ];
  }

  bool _presetActive(_Preset p) =>
      _same(_start, _day(p.start)) && _same(_end, _day(p.end));

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        width: 340,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _header(),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _presetRow(),
                  const SizedBox(height: 12),
                  _monthNav(),
                  const SizedBox(height: 6),
                  _weekdayRow(),
                  const SizedBox(height: 2),
                  _monthGrid(),
                ],
              ),
            ),
            _footer(),
          ],
        ),
      ),
    );
  }

  // ── Header: title + From/To summary ──────────────────────────────────────
  Widget _header() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 14, 12, 14),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [kcvoilet, Color(0xFF7B67F0)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.date_range_rounded, color: kcWhite, size: 18),
              const SizedBox(width: 8),
              Expanded(
                child: Text(widget.title,
                    style: const TextStyle(
                        color: kcWhite,
                        fontSize: 14,
                        fontWeight: FontWeight.w600)),
              ),
              InkWell(
                onTap: () => Navigator.pop(context),
                borderRadius: BorderRadius.circular(12),
                child: const Padding(
                  padding: EdgeInsets.all(4),
                  child: Icon(Icons.close, color: kcWhite, size: 18),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(child: _summaryChip('FROM', _start)),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Icon(Icons.arrow_forward_rounded,
                    color: Colors.white70, size: 16),
              ),
              Expanded(child: _summaryChip('TO', _end)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _summaryChip(String label, DateTime? d) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.16),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white.withOpacity(0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 9,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.8)),
          const SizedBox(height: 2),
          Text(d == null ? '—' : _fmtLong.format(d),
              style: const TextStyle(
                  color: kcWhite, fontSize: 13, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  // ── Quick presets ────────────────────────────────────────────────────────
  Widget _presetRow() {
    return SizedBox(
      height: 28,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _presets.length,
        separatorBuilder: (_, __) => const SizedBox(width: 6),
        itemBuilder: (_, i) {
          final p = _presets[i];
          final active = _presetActive(p);
          return InkWell(
            onTap: () => _applyPreset(p.start, p.end),
            borderRadius: BorderRadius.circular(14),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 11),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: active ? kcvoilet : kcDashboardBg1,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                    color: active ? kcvoilet : kcVeryLightGrey, width: 1),
              ),
              child: Text(p.label,
                  style: TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w600,
                      color: active ? kcWhite : kcLabelGrey)),
            ),
          );
        },
      ),
    );
  }

  // ── Month navigation ─────────────────────────────────────────────────────
  Widget _monthNav() {
    return Row(
      children: [
        _navBtn(Icons.chevron_left_rounded, _canGoPrev ? () => _shiftMonth(-1) : null),
        Expanded(
          child: Text(_fmtMonth.format(_visibleMonth),
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 14, fontWeight: FontWeight.w700, color: kcValueDark)),
        ),
        _navBtn(Icons.chevron_right_rounded, _canGoNext ? () => _shiftMonth(1) : null),
      ],
    );
  }

  Widget _navBtn(IconData icon, VoidCallback? onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: kcDashboardBg1,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: kcVeryLightGrey),
        ),
        child: Icon(icon,
            size: 20, color: onTap == null ? kcVeryLightGrey : kcValueDark),
      ),
    );
  }

  Widget _weekdayRow() {
    return Row(
      children: _dayNames
          .map((d) => Expanded(
                child: Center(
                  child: Text(d,
                      style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: kcLightGrey)),
                ),
              ))
          .toList(),
    );
  }

  // ── Day grid ─────────────────────────────────────────────────────────────
  Widget _monthGrid() {
    final firstOfMonth = DateTime(_visibleMonth.year, _visibleMonth.month, 1);
    final daysInMonth = DateTime(_visibleMonth.year, _visibleMonth.month + 1, 0).day;
    final leading = firstOfMonth.weekday - 1; // Monday = 0
    final totalCells = ((leading + daysInMonth) / 7).ceil() * 7;
    final today = _day(DateTime.now());

    final rows = <Widget>[];
    for (var r = 0; r < totalCells / 7; r++) {
      final cells = <Widget>[];
      for (var c = 0; c < 7; c++) {
        final idx = r * 7 + c;
        final dayNum = idx - leading + 1;
        if (dayNum < 1 || dayNum > daysInMonth) {
          cells.add(const Expanded(child: SizedBox(height: 34)));
          continue;
        }
        final d = DateTime(_visibleMonth.year, _visibleMonth.month, dayNum);
        cells.add(Expanded(child: _dayCell(d, today)));
      }
      rows.add(Row(children: cells));
    }
    return Column(children: rows);
  }

  Widget _dayCell(DateTime d, DateTime today) {
    final disabled = _isDisabled(d);
    final isStart = _same(d, _start);
    final isEnd = _same(d, _end);
    final hasRange = _start != null && _end != null;
    final inRange = hasRange &&
        !isStart &&
        !isEnd &&
        d.isAfter(_start!) &&
        d.isBefore(_end!);
    final isToday = _same(d, today);
    final edge = isStart || isEnd;

    // Range band behind the circle: left half for end, right half for start.
    Widget band = const SizedBox.shrink();
    if (hasRange && (inRange || (edge && !_same(_start, _end)))) {
      final bandColor = kcvoilet.withOpacity(0.12);
      band = Row(
        children: [
          Expanded(
            child: Container(
              height: 30,
              color: (inRange || isEnd) ? bandColor : Colors.transparent,
            ),
          ),
          Expanded(
            child: Container(
              height: 30,
              color: (inRange || isStart) ? bandColor : Colors.transparent,
            ),
          ),
        ],
      );
    }

    return SizedBox(
      height: 34,
      child: Stack(
        alignment: Alignment.center,
        children: [
          band,
          InkWell(
            onTap: disabled ? null : () => _onTapDay(d),
            customBorder: const CircleBorder(),
            child: Container(
              width: 30,
              height: 30,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: edge ? kcvoilet : Colors.transparent,
                border: isToday && !edge
                    ? Border.all(color: kcvoilet, width: 1.2)
                    : null,
              ),
              child: Text(
                '${d.day}',
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: edge || isToday ? FontWeight.w700 : FontWeight.w500,
                  color: disabled
                      ? kcVeryLightGrey
                      : edge
                          ? kcWhite
                          : inRange
                              ? kcvoilet
                              : kcValueDark,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Footer ───────────────────────────────────────────────────────────────
  Widget _footer() {
    final complete = _start != null && _end != null;
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 14),
      margin: const EdgeInsets.only(top: 8),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: kcVeryLightGrey, width: 1)),
      ),
      child: Row(
        children: [
          TextButton(
            onPressed: (_start == null && _end == null)
                ? null
                : () => setState(() {
                      _start = null;
                      _end = null;
                    }),
            style: TextButton.styleFrom(
              foregroundColor: kcLightGrey,
              padding: const EdgeInsets.symmetric(horizontal: 8),
            ),
            child: const Text('Clear',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
          ),
          const Spacer(),
          OutlinedButton(
            onPressed: () => Navigator.pop(context),
            style: OutlinedButton.styleFrom(
              foregroundColor: kcLabelGrey,
              side: const BorderSide(color: kcVeryLightGrey),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              minimumSize: Size.zero,
            ),
            child: const Text('Cancel',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: complete
                ? () => Navigator.pop(
                    context, DateTimeRange(start: _start!, end: _end!))
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: kcvoilet,
              foregroundColor: kcWhite,
              disabledBackgroundColor: kcvoilet.withOpacity(0.35),
              disabledForegroundColor: kcWhite,
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              minimumSize: Size.zero,
            ),
            child: const Text('Apply',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}

class _Preset {
  final String label;
  final DateTime start;
  final DateTime end;
  const _Preset(this.label, this.start, this.end);
}


/// Single "Select date range" field that opens [showCompactDateRangePicker].
/// Writes `yyyy-MM-dd` into [startController] / [endController] (and
/// [fromController] when given) so existing filter logic keeps working.
class CompactDateRangeField extends StatefulWidget {
  final TextEditingController startController;
  final TextEditingController endController;
  final TextEditingController? fromController;
  final VoidCallback? onChanged;
  final String hint;
  final double? width;
  final double height;
  final EdgeInsetsGeometry padding;
  final DateTime? firstDate;
  final DateTime? lastDate;

  const CompactDateRangeField({
    super.key,
    required this.startController,
    required this.endController,
    this.fromController,
    this.onChanged,
    this.hint = 'Select date range',
    this.width,
    this.height = 44,
    this.padding = EdgeInsets.zero,
    this.firstDate,
    this.lastDate,
  });

  @override
  State<CompactDateRangeField> createState() => _CompactDateRangeFieldState();
}

class _CompactDateRangeFieldState extends State<CompactDateRangeField> {
  static final _fmtOut = DateFormat('yyyy-MM-dd');
  static final _fmtShow = DateFormat('dd MMM yyyy');

  @override
  void initState() {
    super.initState();
    widget.startController.addListener(_onExternalChange);
    widget.endController.addListener(_onExternalChange);
  }

  @override
  void dispose() {
    widget.startController.removeListener(_onExternalChange);
    widget.endController.removeListener(_onExternalChange);
    super.dispose();
  }

  void _onExternalChange() {
    if (mounted) setState(() {});
  }

  DateTimeRange? get _current {
    final s = widget.startController.text.trim();
    final e = widget.endController.text.trim();
    if (s.isEmpty || e.isEmpty) return null;
    try {
      return DateTimeRange(
          start: DateTime.parse(s.split(' ').first),
          end: DateTime.parse(e.split(' ').first));
    } catch (_) {
      return null;
    }
  }

  Future<void> _pick() async {
    final picked = await showCompactDateRangePicker(
      context,
      firstDate: widget.firstDate,
      lastDate: widget.lastDate,
      initialRange: _current ??
          DateTimeRange(
              start: DateTime.now().subtract(const Duration(days: 6)),
              end: DateTime.now()),
    );
    if (picked == null) return;
    widget.startController.text = _fmtOut.format(picked.start);
    widget.fromController?.text = _fmtOut.format(picked.start);
    widget.endController.text = _fmtOut.format(picked.end);
    widget.onChanged?.call();
    if (mounted) setState(() {});
  }

  void _clear() {
    widget.startController.clear();
    widget.endController.clear();
    widget.fromController?.clear();
    widget.onChanged?.call();
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final range = _current;
    final hasValue = range != null;
    const valueStyle = TextStyle(
        fontSize: 14, fontWeight: FontWeight.w600, color: kcValueDark);

    return Padding(
      padding: widget.padding,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: _pick,
        child: Container(
          width: widget.width,
          height: widget.height,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: kcWhite,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(width: 1, color: kcVeryLightGrey),
          ),
          child: Row(
            children: [
              const Icon(Icons.calendar_month_outlined,
                  size: 18, color: kcLightGrey),
              const SizedBox(width: 10),
              Expanded(
                child: hasValue
                    ? Row(
                        children: [
                          Flexible(
                            child: Text(_fmtShow.format(range.start),
                                style: valueStyle,
                                overflow: TextOverflow.ellipsis),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Icon(Icons.arrow_forward_rounded,
                                size: 14, color: kcLightGrey),
                          ),
                          Flexible(
                            child: Text(_fmtShow.format(range.end),
                                style: valueStyle,
                                overflow: TextOverflow.ellipsis),
                          ),
                        ],
                      )
                    : Text(widget.hint,
                        style: const TextStyle(
                            color: kcLightGrey, fontSize: 14),
                        overflow: TextOverflow.ellipsis),
              ),
              if (hasValue)
                InkWell(
                  onTap: _clear,
                  borderRadius: BorderRadius.circular(10),
                  child: const Padding(
                    padding: EdgeInsets.all(2),
                    child: Icon(Icons.close_rounded,
                        size: 16, color: kcLightGrey),
                  ),
                )
              else
                const Icon(Icons.keyboard_arrow_down_rounded,
                    size: 20, color: kcLightGrey),
            ],
          ),
        ),
      ),
    );
  }
}
