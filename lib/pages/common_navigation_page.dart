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

  /// Swap the in-app content from anywhere (e.g. the header avatar).
  /// Set by the active navigation host so non-drawer widgets can navigate
  /// without pushing a separate route on top of the scaffold.
  static void Function(String title, Widget page)? showPage;

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
    CommonNavigationPage.showPage = (newTitle, newContent) {
      if (!mounted) return;
      _updateContent(newTitle, newContent, _getRouteFromTitle(newTitle));
    };
  }

  @override
  void dispose() {
    CommonNavigationPage.showPage = null;
    super.dispose();
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
      // Workspace
      case 'Dashboard':
        return '/dashboard';
      case 'Observation':
        return '/observation';
      case 'Graph':
        return '/graph';
      case 'All Incident':
        return '/all-incident';
      // Reporting
      case 'Raise Observation':
        return '/raise-observation';
      case 'Incident Tracking':
        return '/incident-tracking';
      case 'Medical Officer Response':
        return '/medical-officer-response';
      case 'Safety Remark Form':
        return '/safety-remark-form';
      case 'Investigation Form':
        return '/investigation-form';
      // Admin
      case 'Approval Queue':
        return '/approval-queue';
      case 'Close/Reopen Records':
        return '/close-reopen-records';
      case 'Priority Changes':
        return '/priority-changes';
      case 'Write Us':
        return '/write-us';
      // Account
      case 'Profile':
        return '/profile';
      case 'Change Pass / Email':
        return '/change-password';
      case 'Employee Reporting':
        return '/employee-reporting';
      default:
        // Fallback: derive route from title so new entries always get a slug
        // (lowercase, spaces / slashes → dashes) instead of all collapsing to
        // /dashboardPage.
        final slug = title
            .toLowerCase()
            .replaceAll(RegExp(r'[\s/]+'), '-')
            .replaceAll(RegExp(r'[^a-z0-9-]'), '');
        return '/$slug';
    }
  }
}
