import 'package:bloc/bloc.dart';
import 'package:jsaw_limited/service/employee_reporting_service.dart';
import 'package:jsaw_limited/state/employeeAppReporting_state.dart';
import '../error/api_error.dart';
import 'dart:html';

class EmployeeFromAppReportingBloc extends Cubit<EmployeeFromAppReportingState> {
  EmployeeFromAppReportingBloc(this.employeeReportingService) : super(EmployeeFromAppReportingState.initial());

  late EmployeeReportingService employeeReportingService;

  final employeeCode = window.localStorage['kEmployeeCode'] ?? "";

  Future<void> initState() async {
    emit(EmployeeFromAppReportingState.loading(state.appReporting));
    try {
      final employeeResponsibility = await employeeReportingService.getAllEmployeeReporting();
      emit(EmployeeFromAppReportingState.success(employeeResponsibility));
    } on ApiError catch (error) {
      print(error);
      emit(EmployeeFromAppReportingState.failed(state.appReporting, error.message));
    }
  }
}

