// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:jsaw_limited/pages/register_observation_page.dart';
// import 'package:jsaw_limited/pages/test_dashboard.dart';
// import '../pages/dashboard.dart';
// import '../pages/edit_raised_observations_page.dart';
// import '../pages/feedback_page.dart';
// import '../pages/graph_page.dart';
// import '../pages/login.dart';
// import '../pages/observation.dart';
//
// class AppRoutes {
//   static GoRouter getRoutes() {
//     return GoRouter(
//       initialLocation: '/login',
//      // initialLocation: '/observation',
//       routes: [
//         GoRoute(
//           path: '/login',
//           builder: (context, state) => const LoginPage(),
//         ),
//         GoRoute(
//           path: '/dashboard',
//           builder: (context, state) => const DashboardPage(),
//         ),
//         GoRoute(
//           path: '/test_dashboard',
//           builder: (context, state) => const TestDashboardPage(),
//         ),
//         GoRoute(
//           path: '/observation',
//           builder: (context, state) => const ObservationPage(),
//         ),
//         GoRoute(
//           path: '/edit_observation',
//           builder: (context, state) {
//             final uri = state.uri;
//             final queryParams = uri.queryParameters;
//
//             if (queryParams['uniqueId'] == null ||
//                 queryParams['raisedBy'] == null ||
//                 queryParams['wrkGrp'] == null ||
//                 queryParams['deptCode'] == null ||
//                 queryParams['stateCode'] == null) {
//               return ErrorPage(error: Exception("Missing data for EditObservationPage"));
//             }
//
//             return EditObservationPage(
//               uniqueId: queryParams['uniqueId']!,
//               raisedBy: queryParams['raisedBy']!,
//               wrkGrp: queryParams['wrkGrp']!,
//               deptCode: queryParams['deptCode']!,
//               stateCode: queryParams['stateCode']!,
//             );
//           },
//         ),
//
//         GoRoute(
//           path: '/feedback',
//           builder: (context, state) => FeedbackPage(),
//         ),
//         GoRoute(
//           path: '/graph',
//           builder: (context, state) => GraphPage(),
//         ),
//         GoRoute(
//           path: '/register_observation_page',
//           builder: (context, state) => RegisterObservationPage(),
//         ),
//       ],
//       errorPageBuilder: (context, state) {
//         return MaterialPage(
//           key: state.pageKey,
//           child: Container(),
//         );
//       },
//     );
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:jsaw_limited/pages/approved_observation_page.dart';
import 'package:jsaw_limited/pages/change_password_page.dart';
import 'package:jsaw_limited/pages/compliance_page.dart';
import 'package:jsaw_limited/pages/dashboard.dart';
import 'package:jsaw_limited/pages/dashboardSelection.dart';
import 'package:jsaw_limited/pages/edit_raised_observations_page.dart';
import 'package:jsaw_limited/pages/employee_reporting_page.dart';
import 'package:jsaw_limited/pages/feedback_page.dart';
import 'package:jsaw_limited/pages/graph_page.dart';
import 'package:jsaw_limited/pages/incident_Reporting_page.dart';
import 'package:jsaw_limited/pages/medical_Officer_page.dart';
import 'package:jsaw_limited/pages/observation.dart';
import 'package:jsaw_limited/pages/priority_changes_page.dart';
import 'package:jsaw_limited/pages/register_observation_page.dart';
import 'package:jsaw_limited/pages/suggestion_page.dart';
import '../pages/login.dart';

class AppRoutes {
  static const loginPage = '/login_page';
  static const dashboardPage = '/dashboardPage';
  static const editObservationPage = '/editObservationPage';
  static const feedbackPage = '/feedbackPage';
  static const graphPage = '/graphPage';
  static const observationPage = '/observationPage';
  static const registerObservationPage = '/resgiaterObservationPage';
  static const suggestionPgae = '/suggestionPage';
  static const suggestionFeedbackPage = '/suggestionFeedbackPage';
  static const changePasswordPage = '/changePasswordPage';
  static const approvedObservationPage = '/approvedObservationPage';
  static const priorityChangesPage = '/priorityChangesPage';
  static const compliancePage = '/compliancePage';
  static const dashboardSelection = '/dashboardSelection';
  static const approveObservation = '/approveObservation';
  static const approveObservationDetail = '/approveObservationDetail';
  static const employeeReporetingPage = '/employeeReportingPage';
  static const incidentTrackingPage = '/indicentTrackingPage';
  // static const medicalOfficerPage = '/medicalOfficerPage';


  static Map<String, Widget Function(BuildContext)> getRoutes(BuildContext _) {
    return <String, Widget Function(BuildContext)>{
      loginPage: (_) => const LoginPage(),
      dashboardPage: (_) => const ExtraLargeDashboardPage(),
      //editObservationPage: (_) => EditObservationPage(uniqueId: uniqueId, raisedBy: raisedBy, wrkGrp: wrkGrp, deptCode: deptCode, stateCode: stateCode),
      feedbackPage: (_) => const FeedbackPage(),
      graphPage: (_) => const GraphPage(),
      observationPage: (_) => const ObservationPage(),
      registerObservationPage: (_) => const RegisterObservationPage(),
      suggestionPgae: (_) => SuggestionPage(),
      suggestionFeedbackPage: (_) => SuggestionFeedbackPage(),
      changePasswordPage: (_) => ChangePasswordPage(),
      approvedObservationPage: (_) => ApprovedObservationPage(),
      priorityChangesPage: (_) => PriorityChangesPage(),
      dashboardSelection: (_)=> DashboardselectionPage(),
      employeeReporetingPage: (_) => EmployeeReportingPage(),
       incidentTrackingPage: (_) => IncidentReportingPage(),
      // medicalOfficerPage: (_) => MedicalOfficerPage()
    };
  }
}