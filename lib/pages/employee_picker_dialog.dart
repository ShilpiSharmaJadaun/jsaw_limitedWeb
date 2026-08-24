import 'package:flutter/material.dart';

import '../model/allemployee_model.dart';
import '../utils/employee_picker.dart';

/// Reusable employee picker. Shows a searchable list of employees.
/// Returns the picked [AllEmployeeModel] via Navigator.pop, or null on cancel.
///
/// UI is the shared [EmployeePickerSheet] (same look as the
/// "Root Cause – Inquired With" picker); data and return value are unchanged.
class EmployeePickerDialog extends StatelessWidget {
  final List<AllEmployeeModel> employees;
  final bool searchByCodeAndNameOnly;
  const EmployeePickerDialog({
    super.key,
    required this.employees,
    this.searchByCodeAndNameOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return EmployeePickerSheet<AllEmployeeModel>(
      items: employees,
      name: (e) => e.empName,
      code: (e) => e.empUnqId,
      title: 'Select Employee',
      subtitle: (e) =>
          'Grade: ${e.gradeCode.isEmpty ? "—" : e.gradeCode}'
          '   •   WrkGrp: ${e.wrkGrp.isEmpty ? "—" : e.wrkGrp}',
      extraSearch:
          searchByCodeAndNameOnly ? null : (e) => '${e.gradeCode} ${e.wrkGrp}',
    );
  }
}
