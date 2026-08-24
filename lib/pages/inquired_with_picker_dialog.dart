import 'package:flutter/material.dart';

import '../model/activeEmployeeLookup_model.dart';
import '../utils/app_color.dart';

/// Picker for "Root Cause – Inquired With" (tracker point 6).
///
/// Lists ACTIVE employees only (the list comes from
/// `employees/getActiveEmployeeLookup`), each row showing **Name + Emp Code**,
/// searchable by either. Returns the picked [ActiveEmployeeLookupModel] so the
/// caller can auto-populate station / grade / designation.
class InquiredWithPickerDialog extends StatefulWidget {
  final List<ActiveEmployeeLookupModel> employees;

  /// Codes already selected — shown greyed with a tick so the same person is
  /// not added twice.
  final Set<String> alreadySelected;

  const InquiredWithPickerDialog({
    super.key,
    required this.employees,
    this.alreadySelected = const {},
  });

  @override
  State<InquiredWithPickerDialog> createState() =>
      _InquiredWithPickerDialogState();
}

class _InquiredWithPickerDialogState extends State<InquiredWithPickerDialog> {
  late List<ActiveEmployeeLookupModel> _filtered;
  final _search = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filtered = widget.employees;
  }

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  void _onSearch(String q) {
    final query = q.trim().toLowerCase();
    setState(() {
      _filtered = query.isEmpty
          ? widget.employees
          : widget.employees
              .where((e) =>
                  e.empUnqId.toLowerCase().contains(query) ||
                  e.empName.toLowerCase().contains(query))
              .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      titlePadding: const EdgeInsets.fromLTRB(20, 18, 20, 8),
      contentPadding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.person_search_outlined, color: kcvoilet, size: 20),
              SizedBox(width: 8),
              Text('Select employee (active only)',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
            ],
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _search,
            autofocus: true,
            onChanged: _onSearch,
            decoration: InputDecoration(
              isDense: true,
              hintText: 'Search by name or employee code…',
              prefixIcon: const Icon(Icons.search, size: 20),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            ),
          ),
        ],
      ),
      content: SizedBox(
        width: 460,
        height: 420,
        child: _filtered.isEmpty
            ? const Center(
                child: Text('No matching active employee',
                    style: TextStyle(color: kcLabelGrey)))
            : ListView.separated(
                itemCount: _filtered.length,
                separatorBuilder: (_, __) =>
                    Divider(height: 1, color: Colors.grey.shade200),
                itemBuilder: (context, i) {
                  final e = _filtered[i];
                  final taken = widget.alreadySelected.contains(e.empUnqId);
                  return ListTile(
                    dense: true,
                    enabled: !taken,
                    leading: CircleAvatar(
                      radius: 16,
                      backgroundColor: kcvoilet.withOpacity(0.12),
                      child: Text(
                        e.empName.isEmpty ? '?' : e.empName[0].toUpperCase(),
                        style: const TextStyle(
                            color: kcvoilet,
                            fontWeight: FontWeight.w700,
                            fontSize: 13),
                      ),
                    ),
                    title: Text(e.empName,
                        style: const TextStyle(
                            fontSize: 13.5, fontWeight: FontWeight.w600)),
                    subtitle: Text('Emp Code: ${e.empUnqId}',
                        style: const TextStyle(fontSize: 12)),
                    trailing: taken
                        ? const Icon(Icons.check_circle,
                            color: kcobservationgreen, size: 18)
                        : null,
                    onTap: taken ? null : () => Navigator.pop(context, e),
                  );
                },
              ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Close'),
        ),
      ],
    );
  }
}
