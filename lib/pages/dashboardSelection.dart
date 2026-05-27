import 'package:flutter/widgets.dart';
import 'package:jsaw_limited/pages/largeDashboard.dart';

/// The redesigned [LargeDashboardPage] is responsive (collapses to a single
/// column on narrow screens, splits into 7/5 columns when wide), so we use
/// it for every size now.
class DashboardselectionPage extends StatelessWidget {
  const DashboardselectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const LargeDashboardPage();
  }
}
