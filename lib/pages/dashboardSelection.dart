import 'package:flutter/cupertino.dart';
import 'package:jsaw_limited/pages/dashboard.dart';
import 'package:jsaw_limited/pages/largeDashboard.dart';

class DashboardselectionPage extends StatelessWidget {
  const DashboardselectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double screenWidth = constraints.maxWidth;
        double screenHeight = constraints.maxHeight;
print("Width X Height");
print("$screenWidth*$screenHeight");
        if (screenWidth >= 1400) {
          print("larger");
          // Render the layout for screens larger than or equal to 1600px
          return ExtraLargeDashboardPage();

        } else {
          print("smaller");
          // Render the layout for screens smaller than 1600px
          return LargeDashboardPage();
        }
      },
    );
  }
}


