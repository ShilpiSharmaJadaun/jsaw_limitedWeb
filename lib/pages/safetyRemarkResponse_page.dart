import 'package:flutter/material.dart';
import 'package:jsaw_limited/pages/allIncident_page.dart';
import 'package:jsaw_limited/pages/safetyRemarkList_page.dart';
import 'package:jsaw_limited/pages/safetyRemarkPendingApproval_page.dart';
import '../utils/app_color.dart';

class SafetyRemarkResponsePage extends StatefulWidget {
  const SafetyRemarkResponsePage({super.key});

  @override
  State<SafetyRemarkResponsePage> createState() =>
      _SafetyRemarkResponsePageState();
}

class _SafetyRemarkResponsePageState extends State<SafetyRemarkResponsePage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TabBar(
            isScrollable: false,
            controller: tabController,
            indicatorColor: kcvoilet,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorWeight: 3,
            labelColor: kcvoilet,
            unselectedLabelColor: kcLightGrey,
            labelStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                letterSpacing: 0.2),
            unselectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 13,
                letterSpacing: 0.2),
            dividerColor: kcVeryLightGrey,
            tabs: [
              _tab(Icons.pending_actions_outlined, 'Pending for Approval'),
              _tab(Icons.list_alt_outlined, 'Complete'),
              _tab(Icons.all_inbox, "All Incident")
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: const [
                SafetyRemarkPendingApprovalPage(),
                SafetyRemarkListPage(),
                AllIncidentPage()
              ],
            ),
          ),
        ],
      ),
    );
  }

  Tab _tab(IconData icon, String label) => Tab(
        icon: Icon(icon),
        child: Text(label,
            textAlign: TextAlign.center,
            softWrap: true,
            maxLines: 2,
            overflow: TextOverflow.ellipsis),
      );
}