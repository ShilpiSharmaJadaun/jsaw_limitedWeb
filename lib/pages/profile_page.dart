import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web/web.dart' show window;

import '../model/allemployee_model.dart';
import '../service/employee_reporting_service.dart';
import '../service/graph.dart';
import '../service/observation_service.dart';
import '../utils/app_color.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  AllEmployeeModel? _emp;
  bool _enriching = false;
  String? _enrichError;

  // deptCode -> plant/dept name (from department/getAllDepartment)
  Map<String, String> _deptToPlantName = {};
  // statCode -> station/dept name (from stations/getAllStationByDeptCode)
  Map<String, String> _statToDeptName = {};
  // designation/grade code -> designation name (from observation/getAllDesignation)
  Map<String, String> _desgToName = {};
  // designation name resolved by the login API (from the Designations table)
  String _loginDesignationName = '';

  @override
  void initState() {
    super.initState();
    _emp = _buildFromLocalStorage();
    _loginDesignationName =
        window.localStorage.getItem('kDesignationName') ?? '';
    _enrichFromApi();
    _loadLookups();
  }

  Future<void> _loadLookups() async {
    try {
      // Designation/grade name lookup (keyed by both designation_code and
      // wrkGrp-grade code so either of the employee's codes can resolve).
      final graphService = Provider.of<GraphService>(context, listen: false);
      final designations = await graphService.getAllDesignation();
      if (mounted) {
        setState(() {
          _desgToName = {
            for (final d in designations)
              if (d.designation_code.isNotEmpty)
                d.designation_code: d.designation_name,
          };
        });
      }
    } catch (_) {
      // Non-fatal: fall back to the code.
    }
    try {
      final obsService =
          Provider.of<ObservationService>(context, listen: false);
      final plants = await obsService.getAllPlant();
      if (mounted) {
        setState(() {
          _deptToPlantName = {
            for (final p in plants)
              if (p.deptCode.isNotEmpty) p.deptCode: p.deptName,
          };
        });
      }
      final deptCode = _emp?.deptCode ?? '';
      if (deptCode.isNotEmpty) {
        final stations = await obsService.getDepartment(deptCode);
        if (mounted) {
          setState(() {
            _statToDeptName = {
              for (final s in stations)
                if (s.statCode.isNotEmpty) s.statCode: s.statName,
            };
          });
        }
      }
    } catch (_) {
      // Non-fatal: fall back to codes
    }
  }

  AllEmployeeModel? _buildFromLocalStorage() {
    final ls = window.localStorage;
    final empCode = ls.getItem('kEmployeeCode') ?? '';
    if (empCode.isEmpty) return null;
    return AllEmployeeModel(
      empUnqId: empCode,
      empName: ls.getItem('kEmployeename') ?? '',
      email: ls.getItem('kUserEmail') ?? '',
      deptCode: ls.getItem('kdeptCode') ?? '',
      desgCode: ls.getItem('kDesgnCode') ?? '',
      statCode: ls.getItem('kstatCode') ?? '',
      gradeCode: ls.getItem('kGradeCode') ?? '',
      empPassStatus: int.tryParse(ls.getItem('kEmployeePassStatus') ?? '') ?? 0,
      hseteamAuthorization:
          int.tryParse(ls.getItem('khseCode') ?? '') ?? 0,
      employeeAuthorizationForPlantUnitHead:
          int.tryParse(ls.getItem('kempAuthPlantHead') ?? '') ?? 0,
    );
  }

  Future<void> _enrichFromApi() async {
    setState(() {
      _enriching = true;
      _enrichError = null;
    });
    try {
      final service =
          Provider.of<EmployeeReportingService>(context, listen: false);
      final employees = await service.getAllEmployee();
      final empCode = window.localStorage.getItem('kEmployeeCode') ?? '';
      AllEmployeeModel? full;
      for (final e in employees) {
        if (e.empUnqId == empCode) {
          full = e;
          break;
        }
      }
      if (!mounted) return;
      setState(() {
        if (full != null) _emp = full;
        _enriching = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _enriching = false;
        _enrichError = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [kcDashboardBg1, kcDashboardBg2],
        ),
      ),
      child: _emp == null
          ? _buildError(_enrichError ??
              'Could not load your profile. Please log in again.')
          : Column(
              children: [
                if (_enriching)
                  const LinearProgressIndicator(
                    minHeight: 2,
                    backgroundColor: kcVeryLightGrey,
                    valueColor: AlwaysStoppedAnimation<Color>(kcvoilet),
                  ),
                Expanded(child: _buildProfile(_emp!)),
              ],
            ),
    );
  }

  Widget _buildError(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, color: kcRed, size: 48),
            const SizedBox(height: 12),
            Text(message,
                textAlign: TextAlign.center,
                style: const TextStyle(color: kcValueDark, fontSize: 15)),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _enrichFromApi,
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
              style: ElevatedButton.styleFrom(
                backgroundColor: navyBlue,
                foregroundColor: kcWhite,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfile(AllEmployeeModel emp) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 880),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _headerCard(emp),
              const SizedBox(height: 16),
              _sectionCard(
                title: 'Employment',
                icon: Icons.work_outline,
                iconColor: kcInfoResponsibility,
                rows: [
                  _Row(Icons.badge_outlined, 'Employee Code', emp.empUnqId,
                      kcStatBlue),
                  _Row(
                      Icons.assignment_ind_outlined,
                      'Designation',
                      _loginDesignationName.isNotEmpty
                          ? _loginDesignationName
                          : (_desgToName[emp.desgCode] ??
                              _desgToName[emp.gradeCode] ??
                              emp.desgCode),
                      kcInfoResponsibility),
                  _Row(Icons.business_outlined, 'Plant',
                      _deptToPlantName[emp.deptCode] ?? emp.deptCode,
                      kcInfoPlant),
                  _Row(Icons.location_city_outlined, 'Department',
                      _statToDeptName[emp.statCode] ?? emp.statCode,
                      kcInfoLocation),
                  _Row(Icons.groups_outlined, 'Work Group', emp.wrkGrp,
                      kcStatPurple),
                ],
              ),
              const SizedBox(height: 16),
              _sectionCard(
                title: 'Contact & Personal',
                icon: Icons.person_outline,
                iconColor: kcInfoDate,
                rows: [
                  _Row(Icons.email_outlined, 'Email', emp.email, kcInfoDate),
                  _Row(Icons.escalator_warning_outlined, "Father's Name",
                      emp.fatherName, kcmegenta),
                ],
              ),
              const SizedBox(height: 16),
              _sectionCard(
                title: 'Roles & Permissions',
                icon: Icons.shield_outlined,
                iconColor: kcStatGreen,
                rows: [
                  _Row(Icons.health_and_safety_outlined, 'HSE TEAM',
                      emp.hseteamAuthorization == 1 ? 'Yes' : 'No',
                      kcInfoFir),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _headerCard(AllEmployeeModel emp) {
    final initials = _initials(emp.empName);
    final hasImage = emp.employeesImages.isNotEmpty;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [navyBlue, kcvoilet],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 44,
            backgroundColor: kcWhite,
            backgroundImage:
                hasImage ? NetworkImage(emp.employeesImages) : null,
            child: hasImage
                ? null
                : Text(
                    initials,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: navyBlue,
                    ),
                  ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  emp.empName.isEmpty ? '—' : emp.empName,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: kcWhite,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Code: ${emp.empUnqId}',
                  style: const TextStyle(
                      fontSize: 14, color: cream, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 4),
                if (emp.email.isNotEmpty)
                  Text(
                    emp.email,
                    style: const TextStyle(fontSize: 13, color: kcWhite),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionCard({
    required String title,
    required IconData icon,
    required Color iconColor,
    required List<_Row> rows,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: kcWhite,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: iconColor.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: iconColor, size: 18),
                ),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: kcValueDark,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: kcVeryLightGrey),
          Padding(
            padding: const EdgeInsets.all(12),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final twoCols = constraints.maxWidth > 600;
                if (twoCols) {
                  return Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: rows
                        .map((r) => SizedBox(
                              width: (constraints.maxWidth - 12) / 2 - 4,
                              child: _detailTile(r),
                            ))
                        .toList(),
                  );
                }
                return Column(
                  children: rows
                      .map((r) => Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: _detailTile(r),
                          ))
                      .toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _detailTile(_Row row) {
    final value = row.value.isEmpty ? '—' : row.value;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: kcDashboardBg1,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: row.color.withOpacity(0.25)),
        boxShadow: [
          BoxShadow(
            color: row.color.withOpacity(0.06),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: row.color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(row.icon, size: 18, color: row.color),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  row.label,
                  style: const TextStyle(
                    fontSize: 12,
                    color: kcLabelGrey,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    color: kcValueDark,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _initials(String name) {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty || parts.first.isEmpty) return '?';
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
    return (parts.first.substring(0, 1) + parts.last.substring(0, 1))
        .toUpperCase();
  }
}

class _Row {
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  const _Row(this.icon, this.label, this.value, this.color);
}
