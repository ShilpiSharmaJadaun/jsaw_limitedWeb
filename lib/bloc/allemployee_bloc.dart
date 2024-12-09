import 'package:bloc/bloc.dart';
import 'package:jsaw_limited/service/employee_reporting_service.dart';
import 'package:jsaw_limited/state/allemployee_state.dart';
import '../error/api_error.dart';
import 'dart:html';

class AllEmployeeBloc extends Cubit<AllEmployeeState> {
  AllEmployeeBloc(this.employeeReportingService) : super(AllEmployeeState.initial());

  late EmployeeReportingService employeeReportingService;

  final employeeCode = window.localStorage['kEmployeeCode'] ?? "";

  Future<void> initState() async {
    emit(AllEmployeeState.loading(state.allemployee));
    try {
      final employeeResponsibility = await employeeReportingService.getAllEmployee();
      emit(AllEmployeeState.success(employeeResponsibility));
    } on ApiError catch (error) {
      print(error);
      emit(AllEmployeeState.failed(state.allemployee, error.message));
    }
  }
}

