import 'package:flutter/material.dart';

/// Due-date markers for compliance (CAPA) actions — customer request Oct-2026:
/// "ensure proper and timely closure of pending compliance actions".

const Color kcOverdueRed = Color(0xFFC62828);

/// Red pill "Overdue · N days" (or "N overdue" when [count] is given).
class OverdueBadge extends StatelessWidget {
  const OverdueBadge({super.key, this.days = 0, this.count, this.compact = false});

  /// Days past the target date (single CAPA person).
  final int days;

  /// Number of overdue CAPA persons (incident-level cards); overrides [days].
  final int? count;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final String text;
    if (count != null) {
      text = '$count overdue';
    } else if (days > 0) {
      text = 'Overdue · $days ${days == 1 ? 'day' : 'days'}';
    } else {
      text = 'Overdue';
    }
    return Tooltip(
      message: count != null
          ? '$count CAPA ${count == 1 ? 'person has' : 'persons have'} not submitted compliance by the target date'
          : 'Compliance not submitted by the CAPA target date',
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: compact ? 6 : 8, vertical: compact ? 2 : 4),
        decoration: BoxDecoration(
          color: kcOverdueRed,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(color: kcOverdueRed.withValues(alpha: 0.3), blurRadius: 6, offset: const Offset(0, 2)),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.alarm, size: compact ? 11 : 13, color: Colors.white),
            const SizedBox(width: 4),
            Text(text,
                style: TextStyle(
                    fontSize: compact ? 10 : 11, fontWeight: FontWeight.w800, color: Colors.white)),
          ],
        ),
      ),
    );
  }
}

/// "Target Date: dd-MMMM-yyyy" line, red + bold when [overdue].
class DueDateLine extends StatelessWidget {
  const DueDateLine({super.key, required this.label, required this.date, this.overdue = false});

  final String label;
  final String date;
  final bool overdue;

  @override
  Widget build(BuildContext context) {
    if (date.isEmpty) return const SizedBox.shrink();
    final color = overdue ? kcOverdueRed : const Color(0xFF0277BD);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(overdue ? Icons.alarm : Icons.event_available_outlined, size: 15, color: color),
        const SizedBox(width: 5),
        Text('$label: ', style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280))),
        Text(date,
            style: TextStyle(
                fontSize: 12, fontWeight: overdue ? FontWeight.w800 : FontWeight.w600, color: color)),
      ],
    );
  }
}
