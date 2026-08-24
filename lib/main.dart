import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jsaw_limited/bloc/allSafetyObservationRaisedbyManager_bloc.dart';
import 'package:jsaw_limited/bloc/hazardgraphExport_bloc.dart';
import 'package:jsaw_limited/model/filterObservation_model.dart';
import 'package:jsaw_limited/pages/allIncident_page.dart';
import 'package:jsaw_limited/pages/approve_reject_table_page.dart';
import 'package:jsaw_limited/pages/change_password_page.dart';
import 'package:jsaw_limited/pages/common_navigation_page.dart';
import 'package:jsaw_limited/pages/dashboardSelection.dart';
import 'package:jsaw_limited/pages/edit_raised_observations_page.dart';
import 'package:jsaw_limited/pages/employee_reporting_page.dart';
import 'package:jsaw_limited/pages/incident_Reporting_page.dart';
import 'package:jsaw_limited/pages/investigation_team_page.dart';
import 'package:jsaw_limited/pages/login.dart';
import 'package:jsaw_limited/pages/medicalOfficerResponse_page.dart';
import 'package:jsaw_limited/pages/observation.dart';
import 'package:jsaw_limited/pages/graph_page.dart';
import 'package:jsaw_limited/pages/priority_changes_page.dart';
import 'package:jsaw_limited/pages/profile_page.dart';
import 'package:jsaw_limited/pages/register_observation_page.dart';
import 'package:jsaw_limited/pages/approved_observation_page.dart';
import 'package:jsaw_limited/pages/developer_portal_page.dart';
import 'package:jsaw_limited/pages/safetyRemarkResponse_page.dart';
import 'package:jsaw_limited/pages/suggestion_page.dart';
import 'package:jsaw_limited/service/dashboard_service.dart';
import 'package:jsaw_limited/service/employee_reporting_service.dart';
import 'package:jsaw_limited/service/graph.dart';
import 'package:jsaw_limited/service/incident_service.dart';
import 'package:jsaw_limited/service/login_service.dart';
import 'package:jsaw_limited/service/observation_service.dart';
import 'package:jsaw_limited/service/password_service.dart';
import 'package:jsaw_limited/utils/app_color.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart' hide WidgetBuilder;
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:localstorage/localstorage.dart';
import 'package:web/web.dart' show window;
import 'bloc/allSafetyObservationByManagerGraph_bloc.dart';
import 'bloc/allSafetyObservationRaisedByManagerPieChart_bloc.dart';
import 'bloc/graph2_bloc.dart';
import 'routes/app_routes.dart';

final localStorage = LocalStorage('my_app');

final navigatorKey = GlobalKey<NavigatorState>();

class _RouteLogger extends NavigatorObserver {
  void _log(String action, Route<dynamic>? route, Route<dynamic>? previous) {
    final name = route?.settings.name ?? route?.runtimeType.toString() ?? 'unknown';
    final prev = previous?.settings.name ?? previous?.runtimeType.toString() ?? '-';
    debugPrint('[Route] $action  current: $name  previous: $prev');
  }

  @override
  void didPush(Route route, Route? previousRoute) => _log('push', route, previousRoute);

  @override
  void didPop(Route route, Route? previousRoute) => _log('pop', route, previousRoute);

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) => _log('replace', newRoute, oldRoute);

  @override
  void didRemove(Route route, Route? previousRoute) => _log('remove', route, previousRoute);
}

final _routeLogger = _RouteLogger();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setUrlStrategy(const HashUrlStrategy());


  // Wait for LocalStorage to be ready
  await localStorage.ready;

  // Initialize GraphService outside MultiProvider
  final graphService = GraphService();


  final myApp = MultiProvider(
    providers: [
      Provider<LoginService>(create: (_) => LoginService()),
      Provider<ObservationService>(create: (_) => ObservationService()),
      Provider<DashboardService>(create: (_) => DashboardService()),
      Provider<GraphService>(create: (_) => GraphService()),
      Provider<PasswordService>(create: (_) => PasswordService()),
      Provider<SafetyRaisedByManagerPieChartBloc>(create: (_) => SafetyRaisedByManagerPieChartBloc(graphService)),
      Provider<SafetyByManagerBloc>(create: (_) => SafetyByManagerBloc(graphService)),
      Provider<SafetyRaisedByManagerBloc>(create: (_) => SafetyRaisedByManagerBloc(graphService)),
      Provider<HazardGraphExportBloc>(create: (_) => HazardGraphExportBloc(graphService)),
      Provider<Graph2Bloc>(create: (_) => Graph2Bloc(graphService)),
      Provider<EmployeeReportingService>(create: (_) => EmployeeReportingService()),
      Provider<IncidentService>(create: (_) => IncidentService())

    ],
    child: const MyApp(),
  );

  runApp(myApp);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveApp(
      preferDesktop: true,
      builder: (context) {
        return MaterialApp(
          navigatorKey: navigatorKey,
          navigatorObservers: [_routeLogger],
         // scrollBehavior: const MaterialScrollBehavior().copyWith(scrollbars: true, physics: ScrollPhysics(parent: AlwaysScrollableScrollPhysics())),
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: backgroundGrey,
            textTheme: GoogleFonts.quicksandTextTheme(),
            appBarTheme: AppBarTheme(
              centerTitle: true,
              elevation: 8,
              titleTextStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 3.screenWidth,
              ),
            ),
          ),
          initialRoute: AppRoutes.loginPage,
          onGenerateRoute: (settings) {
            final pages = <String, WidgetBuilder>{
              // Drawer slugs — these mirror _getRouteFromTitle in
              // common_navigation_page.dart so browser refresh on any of
              // them restores the correct inner page.
              '/dashboard': (context) => const CommonNavigationPage(
                title: 'Dashboard',
                child: DashboardselectionPage(),
              ),
              '/observation': (context) => const CommonNavigationPage(
                title: 'Observation',
                child: ObservationPage(),
              ),
              '/graph': (context) => const CommonNavigationPage(
                title: 'Graph',
                child: GraphPage(),
              ),
              '/all-incident': (context) => const CommonNavigationPage(
                title: 'All Incident',
                child: AllIncidentPage(),
              ),
              '/raise-observation': (context) => const CommonNavigationPage(
                title: 'Raise Observation',
                child: RegisterObservationPage(),
              ),
              '/incident-tracking': (context) => const CommonNavigationPage(
                title: 'Incident Reporting',
                child: IncidentReportingPage(),
              ),
              '/medical-officer-response': (context) => const CommonNavigationPage(
                title: 'Medical Assessment',
                child: MedicalOfficerResponsePage(),
              ),
              '/safety-remark-form': (context) => const CommonNavigationPage(
                title: 'Safety Observation',
                child: SafetyRemarkResponsePage(),
              ),
              '/investigation-form': (context) => const CommonNavigationPage(
                title: 'Investigation Details',
                child: InvestigationTeamPage(),
              ),
              '/approval-queue': (context) => const CommonNavigationPage(
                title: 'Approval Queue',
                child: ApprovedObservationPage(),
              ),
              '/close-reopen-records': (context) => const CommonNavigationPage(
                title: 'Close/Reopen Records',
                child: ApproveRejectTablePage(),
              ),
              '/priority-changes': (context) => const CommonNavigationPage(
                title: 'Priority Changes',
                child: PriorityChangesPage(),
              ),
              '/write-us': (context) => const CommonNavigationPage(
                title: 'Write Us',
                child: SuggestionFeedbackPage(),
              ),
              '/profile': (context) => const CommonNavigationPage(
                title: 'Profile',
                child: ProfilePage(),
              ),
              '/change-password': (context) => const CommonNavigationPage(
                title: 'Change Pass / Email',
                child: ChangePasswordPage(),
              ),
              '/employee-reporting': (context) => const CommonNavigationPage(
                title: 'Employee Reporting',
                child: EmployeeReportingPage(),
              ),

              // Legacy route names — kept so existing Navigator.pushNamed
              // calls continue to work.
              '/dashboardSelection': (context) => const CommonNavigationPage(
                title: 'Dashboard',
                child: DashboardselectionPage(),
              ),
              '/observationPage': (context) => const CommonNavigationPage(
                title: 'Observation',
                child: ObservationPage(),
              ),
              '/graphPage': (context) => const CommonNavigationPage(
                title: 'Graph',
                child: GraphPage(),
              ),
              '/resgiaterObservationPage': (context) => const CommonNavigationPage(
                title: 'Raise Observation',
                child: RegisterObservationPage(),
              ),
              '/approvedObservationPage': (context) => const CommonNavigationPage(
                title: 'Approve Observation',
                child: ApprovedObservationPage(),
              ),
              '/approveClose/ReopenPageTable': (context) => const CommonNavigationPage(
                title: 'Approve Observation',
                child: ApproveRejectTablePage(),
              ),
              '/priorityChangesPage': (context) => const CommonNavigationPage(
                title: 'Priority Changes',
                child: PriorityChangesPage(),
              ),
              '/suggestionFeedbackPage': (context) => const CommonNavigationPage(
                title: 'Suggestions',
                child: SuggestionFeedbackPage(),
              ),
              '/editObservationPage': (context) => CommonNavigationPage(
                title: 'Suggestions',
                child: EditRaisedObservationsPage(filterObservationModel: const FilterObservationModel()),
              ),
              '/approveClose/ReopenPage': (context) => const CommonNavigationPage(
                title: 'Approve Close/Reopen',
                child: ApprovedObservationPage(),
              ),
              '/changepasswordPage': (context) => const CommonNavigationPage(
                title: 'Change Pass/ Email',
                child: ChangePasswordPage(),
              ),
              '/employeeReportingPage': (context) => const CommonNavigationPage(
                title: 'Employee Reporting',
                child: EmployeeReportingPage(),
              ),
              AppRoutes.loginPage: (context) => const LoginPage(),
              '/developer-portal': (context) => const DeveloperPortalPage(),
            };

            final token = window.localStorage.getItem('kAuthToken');
            final builder = pages[settings.name];

            // Developer portal bypasses normal company auth
            if (settings.name == '/developer-portal' && builder != null) {
              return MaterialPageRoute(builder: builder, settings: settings);
            }

            if (builder == null) {
              return MaterialPageRoute(
                builder: (_) => (token == null || token.isEmpty)
                    ? const LoginPage()
                    : const CommonNavigationPage(
                        title: 'Dashboard',
                        child: DashboardselectionPage(),
                      ),
                settings: RouteSettings(
                  name: (token == null || token.isEmpty)
                      ? AppRoutes.loginPage
                      : '/dashboardSelection',
                ),
              );
            }

            if (settings.name == AppRoutes.loginPage) {
              return MaterialPageRoute(builder: builder, settings: settings);
            }

            if (token == null || token.isEmpty) {
              return MaterialPageRoute(
                builder: (_) => const LoginPage(),
                settings: const RouteSettings(name: AppRoutes.loginPage),
              );
            }

            return MaterialPageRoute(builder: builder, settings: settings);
          },
          onUnknownRoute: (settings) => MaterialPageRoute(
            builder: (_) => const LoginPage(),
            settings: const RouteSettings(name: AppRoutes.loginPage),
          ),

        );
      },
    );
  }
}
