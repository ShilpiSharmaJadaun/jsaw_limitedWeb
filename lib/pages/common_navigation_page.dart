import 'dart:html' as html;
import 'package:flutter/material.dart';
import '../utils/app_drawer.dart';
import '../utils/page_header.dart';

class CommonNavigationPage extends StatefulWidget {
  final String title;
  final Widget? initialChild;
  final Widget child;

  const CommonNavigationPage({
    Key? key,
    required this.title,
    this.initialChild,
    required this.child,
  }) : super(key: key);

  @override
  _CommonNavigationPageState createState() => _CommonNavigationPageState();
}

class _CommonNavigationPageState extends State<CommonNavigationPage> {
  late Widget content;
  late String title;

  @override
  void initState() {
    super.initState();
    title = widget.title;
    content = widget.initialChild ?? widget.child;
  }

  void _updateContent(String newTitle, Widget newContent, String newRoute) {
    setState(() {
      title = newTitle;
      content = newContent;
    });

    // Change the URL without reloading the page
    _updateUrl(newRoute);
  }

  void _updateUrl(String route) {
    // Use the browser's history API to change the URL without reloading
    html.window.history.pushState(null, title, '#$route');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          AppDrawer(
            onSelectPage: (index, newTitle, pageContent) {
              String newRoute = _getRouteFromTitle(newTitle);
              _updateContent(newTitle, pageContent, newRoute);
            },
          ),
          Expanded(
            child: Column(
              children: [
                PageHeader(title), // Update the title dynamically
                Expanded(
                  child: content,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getRouteFromTitle(String title) {
    switch (title) {
      case 'Dashboard':
        return '/dashboardSelection';
      case 'Observation':
        return '/observationPage';
      case 'Graph':
        return '/graphPage';
      case 'Raise Observation':
        return '/resgiaterObservationPage';
      case 'Approve Observation':
        return '/approvedObservationPage';
      case 'Suggestion':
        return '/suggestionFeedbackPage';
      case 'Priority Changes':
        return '/priorityChangesPage';
      case 'Edit Observation':
       return '/editObservationPage';
      case 'Approve Close/Reopen':
        return '/approveClose/ReopenPage';
      case 'Change Pass/ Email':
        return '/changepasswordPage';
      case 'Employee Reporting':
        return '/employeeReportingPage';
      case 'Approve Close/Reopen Table':
        return '/approveClose/ReopenPageTable';
        default:
        return '/dashboardPage';
    }
  }
}
