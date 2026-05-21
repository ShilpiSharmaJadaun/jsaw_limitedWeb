import 'package:flutter/material.dart';
import 'package:jsaw_limited/pages/allIncident_page.dart';
import 'package:jsaw_limited/pages/approve_reject_table_page.dart';
import 'package:jsaw_limited/pages/approved_observation_page.dart';
import 'package:jsaw_limited/pages/change_password_page.dart';
import 'package:jsaw_limited/pages/dashboardSelection.dart';
import 'package:jsaw_limited/pages/employee_reporting_page.dart';
import 'package:jsaw_limited/pages/graph_page.dart';
import 'package:jsaw_limited/pages/investigation_team_page.dart';
import 'package:jsaw_limited/pages/observation.dart';
import 'package:jsaw_limited/pages/priority_changes_page.dart';
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

  // Define a static ValueNotifier to track the selected index
  static final ValueNotifier<int> _selectedIndexNotifier = ValueNotifier<int>(0);

  const AppDrawer({Key? key, required this.onSelectPage}) : super(key: key);

  List<_DrawerEntry> _getEntries() {
    final khse = html.window.localStorage.getItem('khseCode') == '1';
    final reporting = html.window.localStorage.getItem('kreporting') == '1';

    return [
      const _DrawerEntry(
        section: 'Workspace',
        title: 'Dashboard',
        icon: Icons.dashboard_outlined,
        page: DashboardselectionPage(),
      ),
      const _DrawerEntry(
        section: 'Workspace',
        title: 'Observation',
        icon: Icons.visibility_outlined,
        page: ObservationPage(),
      ),
      const _DrawerEntry(
        section: 'Workspace',
        title: 'Graph',
        icon: Icons.bar_chart_outlined,
        page: GraphPage(),
      ),
      const _DrawerEntry(
        section: 'Workspace',
        title: 'All Incident',
        icon: Icons.visibility_outlined,
        page: AllIncidentPage(),
      ),
      const _DrawerEntry(
        section: 'Reporting',
        title: 'Raise Observation',
        icon: Icons.add_alert_outlined,
        page: RegisterObservationPage(),
      ),
      const _DrawerEntry(
        section: 'Reporting',
        title: 'Incident Tracking',
        icon: Icons.warning_amber_outlined,
        page: IncidentReportingPage(),
      ),
      const _DrawerEntry(
        section: 'Reporting',
        title: 'Medical Officer Response',
        icon: Icons.list_alt_outlined,
        page: MedicalOfficerResponsePage(),
      ),
      const _DrawerEntry(
        section: 'Reporting',
        title: 'Safety Remark Form',
        icon: Icons.health_and_safety_outlined,
        page: SafetyRemarkResponsePage(),
      ),
      const _DrawerEntry(
        section: 'Reporting',
        title: 'Investigation Form',
        icon: Icons.fact_check_outlined,
        page: InvestigationTeamPage(),
      ),
      if (khse)
        const _DrawerEntry(
          section: 'Admin',
          title: 'Approval Queue',
          icon: Icons.pending_actions_outlined,
          page: ApprovedObservationPage(),
        ),
      if (khse)
        const _DrawerEntry(
          section: 'Admin',
          title: 'Close/Reopen Records',
          icon: Icons.lock_reset_outlined,
          page: ApproveRejectTablePage(),
        ),
      if (khse)
        const _DrawerEntry(
          section: 'Admin',
          title: 'Priority Changes',
          icon: Icons.swap_vert_outlined,
          page: PriorityChangesPage(),
        ),
      if (khse)
        const _DrawerEntry(
          section: 'Admin',
          title: 'Write Us',
          icon: Icons.mail_outline,
          page: SuggestionFeedbackPage(),
        ),
      const _DrawerEntry(
        section: 'Account',
        title: 'Change Pass / Email',
        icon: Icons.lock_outline,
        page: ChangePasswordPage(),
      ),
      if (reporting)
        const _DrawerEntry(
          section: 'Account',
          title: 'Employee Reporting',
          icon: Icons.groups_outlined,
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
        mobile: 200,
        tablet: 220,
        desktop: 280,
      ),
      height: MediaQuery.of(context).size.height,
      child: Drawer(
        backgroundColor: kcWhite,
        elevation: 1,
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 8),
                children: _buildSectionedItems(context, entries),
              ),
            ),
            const Divider(color: kcVeryLightGrey, height: 1),
            _buildLogout(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 96,
      width: double.infinity,
      decoration: const BoxDecoration(color: kcVeryLightGrey),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Image.asset(
            "assets/images/jindal-saw-logo-removebg-preview.png",
            width: 36,
            height: 36,
          ),
          const SizedBox(width: 12),
          const Text(
            "JSAW",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: kcValueDark,
            ),
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
          widgets.add(const SizedBox(height: 4));
        }
        widgets.add(Padding(
          padding: const EdgeInsets.fromLTRB(20, 14, 16, 6),
          child: Text(
            entry.section.toUpperCase(),
            style: const TextStyle(
              color: kcLightGrey,
              fontSize: 11,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.8,
            ),
          ),
        ));
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
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          child: ListTile(
            dense: true,
            visualDensity: const VisualDensity(vertical: -1),
            title: Text(
              entry.title,
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                fontSize: getValueForScreenType<double>(
                  context: context,
                  mobile: 13,
                  tablet: 14,
                  desktop: 15,
                ),
              ),
            ),
            leading: Icon(entry.icon, size: 22),
            onTap: () {
              _selectedIndexNotifier.value = index;
              onSelectPage(index, entry.title, entry.page);
            },
            selected: isSelected,
            selectedTileColor: kcvoilet.withValues(alpha: 0.10),
            selectedColor: kcvoilet,
            hoverColor: kcvoilet.withValues(alpha: 0.05),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          ),
        );
      },
    );
  }

  Widget _buildLogout(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 16),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: () {
            // Clear session data and navigate to login page
            html.window.localStorage.clear();
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/login_page',
              (Route<dynamic> route) => false,
            );
          },
          icon: const Icon(Icons.logout, size: 18),
          label: const Text("Logout"),
          style: ElevatedButton.styleFrom(
            backgroundColor: kcRed,
            foregroundColor: kcWhite,
            elevation: 0,
            padding: const EdgeInsets.symmetric(vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
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
  final Widget page;
  const _DrawerEntry({
    required this.section,
    required this.title,
    required this.icon,
    required this.page,
  });
}
