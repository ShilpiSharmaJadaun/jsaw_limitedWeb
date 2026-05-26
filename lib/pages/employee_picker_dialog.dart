import 'package:flutter/material.dart';

import '../model/allemployee_model.dart';

/// Reusable employee picker. Shows a searchable list of employees.
/// Returns the picked [AllEmployeeModel] via Navigator.pop, or null on cancel.
class EmployeePickerDialog extends StatefulWidget {
  final List<AllEmployeeModel> employees;
  final bool searchByCodeAndNameOnly;
  const EmployeePickerDialog({
    super.key,
    required this.employees,
    this.searchByCodeAndNameOnly = false,
  });

  @override
  State<EmployeePickerDialog> createState() => _EmployeePickerDialogState();
}

class _EmployeePickerDialogState extends State<EmployeePickerDialog> {
  late List<AllEmployeeModel> _filtered;
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filtered = widget.employees;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearch(String q) {
    final query = q.trim().toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filtered = widget.employees;
      } else {
        _filtered = widget.employees.where((e) {
          if (e.empUnqId.toLowerCase().contains(query) ||
              e.empName.toLowerCase().contains(query)) {
            return true;
          }
          if (widget.searchByCodeAndNameOnly) return false;
          return e.gradeCode.toLowerCase().contains(query) ||
              e.wrkGrp.toLowerCase().contains(query);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: SizedBox(
        width: 480,
        height: 520,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Select Employee',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _searchController,
                autofocus: true,
                onChanged: _onSearch,
                decoration: InputDecoration(
                  isDense: true,
                  hintText: widget.searchByCodeAndNameOnly
                      ? 'Search by code or name'
                      : 'Search by code, name, grade or wrkgrp',
                  prefixIcon: const Icon(Icons.search, size: 18),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6)),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: _filtered.isEmpty
                  ? const Center(child: Text('No matches'))
                  : ListView.builder(
                      itemCount: _filtered.length,
                      itemBuilder: (context, i) {
                        final e = _filtered[i];
                        return ListTile(
                          dense: true,
                          title: Text('${e.empUnqId} — ${e.empName}',
                              style: const TextStyle(fontSize: 13)),
                          subtitle: Text(
                            'Grade: ${e.gradeCode.isEmpty ? "—" : e.gradeCode}'
                            '   •   WrkGrp: ${e.wrkGrp.isEmpty ? "—" : e.wrkGrp}',
                            style: const TextStyle(fontSize: 11),
                          ),
                          onTap: () => Navigator.of(context).pop(e),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
