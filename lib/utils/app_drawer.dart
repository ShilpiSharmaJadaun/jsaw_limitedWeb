import 'package:flutter/material.dart';
import 'package:jsaw_limited/pages/allIncident_page.dart';
import 'package:jsaw_limited/pages/approve_reject_table_page.dart';
import 'package:jsaw_limited/pages/approved_observation_page.dart';
import 'package:jsaw_limited/pages/change_password_page.dart';
import 'package:jsaw_limited/pages/compliance_hod_page.dart';
import 'package:jsaw_limited/pages/compliance_incident_page.dart';
import 'package:jsaw_limited/pages/dashboardSelection.dart';
import 'package:jsaw_limited/pages/employee_reporting_page.dart';
import 'package:jsaw_limited/pages/graph_page.dart';
import 'package:jsaw_limited/pages/investigation_team_page.dart';
import 'package:jsaw_limited/pages/observation.dart';
import 'package:jsaw_limited/pages/priority_changes_page.dart';
import 'package:jsaw_limited/pages/profile_page.dart';
import 'package:jsaw_limited/pages/register_observation_page.dart';
import 'package:jsaw_limited/pages/safetyRemarkResponse_page.dart';
import 'package:jsaw_limited/pages/suggestion_page.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../pages/medicalOfficerResponse_page.dart';
import '../pages/incident_Reporting_page.dart';
import '../utils/app_color.dart';
import 'package:web/web.dart' as html;

class AppDrawer extends StatelessWidget {
  final Function(int, String, Widget) onSelectPage;

  static final ValueNotifier<int> _selectedIndexNotifier =
      ValueNotifier<int>(0);

  const AppDrawer({Key? key, required this.onSelectPage}) : super(key: key);

  // Palette — each item gets a distinctive accent so the drawer feels alive.
  static const _blue = Color(0xFF3B82F6);
  static const _purple = Color(0xFF8B5CF6);
  static const _indigo = Color(0xFF6366F1);
  static const _red = Color(0xFFEF4444);
  static const _green = Color(0xFF10B981);
  static const _amber = Color(0xFFF59E0B);
  static const _teal = Color(0xFF14B8A6);
  static const _orange = Color(0xFFFF7B2C);
  static const _cyan = Color(0xFF06B6D4);
  static const _fuchsia = Color(0xFFD946EF);
  static const _slate = Color(0xFF64748B);
  static const _pink = Color(0xFFEC4899);
  static const _grey = Color(0xFF94A3B8);

  // Section header tint
  Color _sectionColor(String section) {
    switch (section) {
      case 'Workspace':
        return _blue;
      case 'Reporting':
        return _orange;
      case 'Admin':
        return _purple;
      case 'Account':
        return _green;
      default:
        return _slate;
    }
  }

  IconData _sectionIcon(String section) {
    switch (section) {
      case 'Workspace':
        return Icons.workspaces_outline;
      case 'Reporting':
        return Icons.summarize_outlined;
      case 'Admin':
        return Icons.admin_panel_settings_outlined;
      case 'Account':
        return Icons.account_circle_outlined;
      default:
        return Icons.folder_outlined;
    }
  }

  List<_DrawerEntry> _getEntries() {
    final khse = html.window.localStorage.getItem('khseCode') == '1';
    final reporting = html.window.localStorage.getItem('kreporting') == '1';

    return [
      const _DrawerEntry(
        section: 'Workspace',
        title: 'Dashboard',
        icon: Icons.dashboard_outlined,
        color: _blue,
        page: DashboardselectionPage(),
      ),
      const _DrawerEntry(
        section: 'Workspace',
        title: 'Observation',
        icon: Icons.visibility_outlined,
        color: _purple,
        page: ObservationPage(),
      ),
      const _DrawerEntry(
        section: 'Workspace',
        title: 'Graph',
        icon: Icons.insights_outlined,
        color: _indigo,
        page: GraphPage(),
      ),
      const _DrawerEntry(
        section: 'Workspace',
        title: 'All Incident',
        icon: Icons.report_problem_outlined,
        color: _red,
        page: AllIncidentPage(),
      ),
      const _DrawerEntry(
        section: 'Reporting',
        title: 'Raise Observation',
        icon: Icons.add_alert_outlined,
        color: _green,
        page: RegisterObservationPage(),
      ),
      const _DrawerEntry(
        section: 'Reporting',
        title: 'Incident Tracking',
        icon: Icons.warning_amber_outlined,
        color: _amber,
        page: IncidentReportingPage(),
      ),
      const _DrawerEntry(
        section: 'Reporting',
        title: 'Medical Officer Response',
        icon: Icons.medical_services_outlined,
        color: _teal,
        page: MedicalOfficerResponsePage(),
      ),
      const _DrawerEntry(
        section: 'Reporting',
        title: 'Safety Remark Form',
        icon: Icons.health_and_safety_outlined,
        color: _orange,
        page: SafetyRemarkResponsePage(),
      ),
      const _DrawerEntry(
        section: 'Reporting',
        title: 'Investigation Form',
        icon: Icons.fact_check_outlined,
        color: _cyan,
        page: InvestigationTeamPage(),
      ),
      const _DrawerEntry(
        section: 'Reporting',
        title: 'Compliance Incident',
        icon: Icons.verified_user_outlined,
        color: _fuchsia,
        page: ComplianceIncidentPage(),
      ),
      const _DrawerEntry(
        section: 'Reporting',
        title: 'Compliance Review',
        icon: Icons.rate_review_outlined,
        color: _indigo,
        page: ComplianceHodPage(),
      ),
      if (khse)
        const _DrawerEntry(
          section: 'Admin',
          title: 'Approval Queue',
          icon: Icons.pending_actions_outlined,
          color: _fuchsia,
          page: ApprovedObservationPage(),
        ),
      if (khse)
        const _DrawerEntry(
          section: 'Admin',
          title: 'Close/Reopen Records',
          icon: Icons.lock_reset_outlined,
          color: _slate,
          page: ApproveRejectTablePage(),
        ),
      if (khse)
        const _DrawerEntry(
          section: 'Admin',
          title: 'Priority Changes',
          icon: Icons.flag_outlined,
          color: _pink,
          page: PriorityChangesPage(),
        ),
      // Write Us drawer entry hidden.
      // if (khse)
      //   const _DrawerEntry(
      //     section: 'Admin',
      //     title: 'Write Us',
      //     icon: Icons.forum_outlined,
      //     color: _orange,
      //     page: SuggestionFeedbackPage(),
      //   ),
      const _DrawerEntry(
        section: 'Account',
        title: 'Profile',
        icon: Icons.person_outline,
        color: _blue,
        page: ProfilePage(),
      ),
      const _DrawerEntry(
        section: 'Account',
        title: 'Change Pass / Email',
        icon: Icons.lock_outline,
        color: _grey,
        page: ChangePasswordPage(),
      ),
      if (reporting)
        const _DrawerEntry(
          section: 'Account',
          title: 'Employee Reporting',
          icon: Icons.groups_outlined,
          color: _green,
          page: EmployeeReportingPage(),
        ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final entries = _getEntries();
    return SizedBox(
      width: getValueForScreenType<double>(
        context: context,
        mobile: 220,
        tablet: 240,
        desktop: 290,
      ),
      height: MediaQuery.of(context).size.height,
      child: Drawer(
        backgroundColor: const Color(0xFFFAFAFC),
        elevation: 2,
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 10),
                children: _buildSectionedItems(context, entries),
              ),
            ),
            _buildLogout(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
        color: kcWhite,
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade200, width: 1),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: kcWhite,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.shade200, width: 1),
            ),
            child: Image.asset(
              "assets/images/jindal-saw-logo-removebg-preview.png",
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "JSAW",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: navyBlue,
                  letterSpacing: 1.4,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                "Safety Portal",
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: kcLabelGrey,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> _buildSectionedItems(
      BuildContext context, List<_DrawerEntry> entries) {
    final widgets = <Widget>[];
    String? currentSection;
    for (var i = 0; i < entries.length; i++) {
      final entry = entries[i];
      if (entry.section != currentSection) {
        if (currentSection != null) {
          widgets.add(const SizedBox(height: 6));
        }
        widgets.add(_buildSectionHeader(entry.section));
        currentSection = entry.section;
      }
      widgets.add(_buildDrawerItem(
        context: context,
        index: i,
        entry: entry,
      ));
    }
    return widgets;
  }

  Widget _buildSectionHeader(String section) {
    final color = _sectionColor(section);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 6),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(_sectionIcon(section), color: color, size: 13),
          ),
          const SizedBox(width: 8),
          Text(
            section.toUpperCase(),
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.9,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Container(
              height: 1.2,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [color.withOpacity(0.30), Colors.transparent],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required BuildContext context,
    required int index,
    required _DrawerEntry entry,
  }) {
    return ValueListenableBuilder<int>(
      valueListenable: _selectedIndexNotifier,
      builder: (context, selectedIndex, child) {
        final isSelected = selectedIndex == index;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: isSelected
                  ? LinearGradient(
                      colors: [
                        entry.color.withOpacity(0.18),
                        entry.color.withOpacity(0.04),
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    )
                  : null,
              border: Border.all(
                color: isSelected
                    ? entry.color.withOpacity(0.45)
                    : Colors.transparent,
                width: 1,
              ),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  _selectedIndexNotifier.value = index;
                  onSelectPage(index, entry.title, entry.page);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 9),
                  child: Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? entry.color
                              : entry.color.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: entry.color.withOpacity(0.35),
                                    blurRadius: 8,
                                    offset: const Offset(0, 3),
                                  ),
                                ]
                              : null,
                        ),
                        child: Icon(
                          entry.icon,
                          size: 18,
                          color: isSelected ? kcWhite : entry.color,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          entry.title,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: isSelected
                                ? FontWeight.w800
                                : FontWeight.w600,
                            fontSize: getValueForScreenType<double>(
                              context: context,
                              mobile: 13,
                              tablet: 13,
                              desktop: 14,
                            ),
                            color:
                                isSelected ? entry.color : kcValueDark,
                            letterSpacing: 0.2,
                          ),
                        ),
                      ),
                      if (isSelected)
                        Icon(Icons.chevron_right,
                            size: 18, color: entry.color),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLogout(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 16),
      child: SizedBox(
        width: double.infinity,
        height: 46,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: const LinearGradient(
              colors: [Color(0xFFEF4444), Color(0xFFDC2626)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFEF4444).withOpacity(0.32),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ElevatedButton.icon(
            onPressed: () {
              html.window.localStorage.clear();
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/login_page',
                (Route<dynamic> route) => false,
              );
            },
            icon: const Icon(Icons.logout, size: 18, color: kcWhite),
            label: const Text(
              "Logout",
              style: TextStyle(
                color: kcWhite,
                fontWeight: FontWeight.w800,
                fontSize: 14,
                letterSpacing: 0.4,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
        ),
      ),
    );
  }
}

class _DrawerEntry {
  final String section;
  final String title;
  final IconData icon;
  final Color color;
  final Widget page;
  const _DrawerEntry({
    required this.section,
    required this.title,
    required this.icon,
    required this.color,
    required this.page,
  });
}
