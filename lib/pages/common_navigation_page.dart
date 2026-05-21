import 'package:web/web.dart' as html;
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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Below this width the drawer becomes an overlay opened via menu button.
  static const double _drawerBreakpoint = 900;

  @override
  void initState() {
    super.initState();
    title = widget.title;
    content = widget.initialChild ?? widget.child;
  }

  void _updateContent(
    String newTitle,
    Widget newContent,
    String newRoute, {
    bool closeOverlayDrawer = false,
  }) {
    setState(() {
      title = newTitle;
      content = newContent;
    });
    _updateUrl(newRoute);
    if (closeOverlayDrawer) {
      _scaffoldKey.currentState?.closeDrawer();
    }
  }

  void _updateUrl(String route) {
    // Use the browser's history API to change the URL without reloading
    html.window.history.pushState(null, title, '#$route');
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= _drawerBreakpoint;

        final appDrawer = AppDrawer(
          onSelectPage: (index, newTitle, pageContent) {
            final newRoute = _getRouteFromTitle(newTitle);
            _updateContent(
              newTitle,
              pageContent,
              newRoute,
              closeOverlayDrawer: !isWide,
            );
          },
        );

        return Scaffold(
          key: _scaffoldKey,
          drawer: isWide ? null : appDrawer,
          body: Row(
            children: [
              if (isWide) appDrawer,
              Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        if (!isWide)
                          Builder(
                            builder: (innerContext) => IconButton(
                              icon: const Icon(Icons.menu, color: Colors.black87),
                              tooltip: "Open menu",
                              onPressed: () =>
                                  Scaffold.of(innerContext).openDrawer(),
                            ),
                          ),
                        Expanded(child: PageHeader(title)),
                      ],
                    ),
                    Expanded(child: content),
                  ],
                ),
              ),
            ],
          ),
        );
      },
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
