import 'package:flutter/material.dart';
import 'package:jsaw_limited/pages/approve_reject_table_page.dart';
import 'package:jsaw_limited/pages/approved_observation_page.dart';
import 'package:jsaw_limited/pages/change_password_page.dart';
import 'package:jsaw_limited/pages/dashboardSelection.dart';
import 'package:jsaw_limited/pages/employee_reporting_page.dart';
import 'package:jsaw_limited/pages/graph_page.dart';
import 'package:jsaw_limited/pages/observation.dart';
import 'package:jsaw_limited/pages/priority_changes_page.dart';
import 'package:jsaw_limited/pages/register_observation_page.dart';
import 'package:jsaw_limited/pages/suggestion_page.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../utils/app_color.dart';
import 'dart:html' as html;

class AppDrawer extends StatelessWidget {
  final Function(int, String, Widget) onSelectPage;

  // Define a static ValueNotifier to track the selected index
  static final ValueNotifier<int> _selectedIndexNotifier = ValueNotifier<int>(0);

  const AppDrawer({Key? key, required this.onSelectPage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getValueForScreenType<double>(
        context: context,
        mobile: 150,
        tablet: 180,
        desktop: 280,
      ),
      height: MediaQuery.of(context).size.height,
      child: Drawer(
        backgroundColor: kcWhite,
        child: ListView(
          children: [
            SizedBox(
              width: 40,
              height: 80,
              child: DrawerHeader(
                decoration: const BoxDecoration(
                  color: kcVeryLightGrey,
                ),
                child: Row(
                  children: [
                    Image.asset(
                      "assets/images/jindal-saw-logo-removebg-preview.png",
                      scale: 0.5,
                    ),
                    const Text(
                      "JSAW",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ListView.builder(
              itemCount: _getDrawerTitles().length,
              itemBuilder: (_, index) {
                return _buildDrawerItem(
                  index: index,
                  title: _getDrawerTitles()[index],
                  imagePath: _getDrawerImages()[index],
                  content: _getDrawerContent()[index],
                );
              },
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  // Clear session data and navigate to login page
                  html.window.localStorage.clear();
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/login_page',
                        (Route<dynamic> route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kcRed,
                ),
                child: const Text(
                  "Logout",
                  style: TextStyle(color: kcWhite),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<String> _getDrawerTitles() {
    final drawerTitles = [
      'Dashboard',
      'Observation',
      'Graph',
      'Raise Observation',
    ];

    if (html.window.localStorage['khseCode'] == '1') {
      drawerTitles.add('Approve Close/Reopen');
    }
    if (html.window.localStorage['khseCode'] == '1') {
      drawerTitles.add('Approve Close/Reopen Table');
    }
    if (html.window.localStorage['khseCode'] == '1') {
      drawerTitles.add('Priority Changes');
    }
    if (html.window.localStorage['khseCode'] == '1') {
      drawerTitles.add('Write Us');
    }
    drawerTitles.add('Change Pass/ Email');
    if (html.window.localStorage['kreporting'] == '1') {
      drawerTitles.add('Employee Reporting');
    }


    return drawerTitles;
  }

  List<String> _getDrawerImages() {
    final drawerImages = [
      'assets/images/dashboard.png',
      'assets/images/observation.png',
      'assets/images/graph.png',
      'assets/images/raise_observation.png',

    ];

    if  (html.window.localStorage['khseCode'] == '1') {
      drawerImages.add('assets/images/approved.png');
    }
    if (html.window.localStorage['khseCode'] == '1') {
      drawerImages.add('assets/images/approved.png');
    }
    if (html.window.localStorage['khseCode'] == '1') {
      drawerImages.add('assets/images/approved.png');
    }

    if (html.window.localStorage['khseCode'] == '1') {
      drawerImages.add('assets/images/writeUs.png');
    }

    drawerImages.add('assets/images/changepassword.png');

    if (html.window.localStorage['kreporting'] == '1') {
      drawerImages.add('assets/images/employee-report.png');
    }


    return drawerImages;
  }

  List<Widget> _getDrawerContent() {
    final drawerContent = [
      const DashboardselectionPage(),
      const ObservationPage(),
      const GraphPage(),
      const RegisterObservationPage(),
    ];

    if (html.window.localStorage['khseCode'] == '1') {
      drawerContent.add(const ApprovedObservationPage());
    }
    if (html.window.localStorage['khseCode'] == '1') {
      drawerContent.add(const ApproveRejectTablePage());
    }
    if (html.window.localStorage['khseCode'] == '1') {
      drawerContent.add(const PriorityChangesPage());
    }

    if (html.window.localStorage['khseCode'] == '1') {
      drawerContent.add(const SuggestionFeedbackPage());
    }

    drawerContent.add(const ChangePasswordPage());
    if (html.window.localStorage['kreporting'] == '1') {
      drawerContent.add(const EmployeeReportingPage());
    }
    return drawerContent;
  }

  Widget _buildDrawerItem({
    required int index,
    required String title,
    required String imagePath,
    required Widget content,
  }) {
    return ValueListenableBuilder<int>(
      valueListenable: _selectedIndexNotifier,
      builder: (context, selectedIndex, child) {
        return ListTile(
          title: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              color: kcMediumGrey,
              fontSize: getValueForScreenType<double>(
                context: context,
                mobile: 14,
                tablet: 16,
                desktop: 18,
              ),
            ),
          ),
          leading: Image.asset(imagePath, height: 30),
          onTap: () {
            // Update the selected index
            _selectedIndexNotifier.value = index;
            // Call the callback to update the content in the main page
            onSelectPage(index, title, content);
          },
          selected: selectedIndex == index,
          selectedTileColor: lightBlue,
          selectedColor: kcOrange,
        );
      },
    );
  }
}
