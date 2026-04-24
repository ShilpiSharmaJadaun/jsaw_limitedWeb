import 'package:bloc/bloc.dart';
import 'package:jsaw_limited/service/employee_reporting_service.dart';
import 'package:jsaw_limited/service/incident_service.dart';
import 'package:jsaw_limited/state/employeeAppReporting_state.dart';
import 'package:jsaw_limited/state/employeeBasicDetail_state.dart';
import 'package:jsaw_limited/state/employeeShift_state.dart';
import '../error/api_error.dart';
import 'dart:html';

class EmployeeShiftBloc extends Cubit<EmployeeShiftState> {
  EmployeeShiftBloc(this.incidentService) : super(EmployeeShiftState.initial());

  late IncidentService incidentService;

  final employeeCode = window.localStorage['kEmployeeCode'] ?? "";

  Future<void> initState() async {
    emit(EmployeeShiftState.loading(state.employeeShift));
    try {
      final employeeShift = await incidentService.getEmployeeShift();
      emit(EmployeeShiftState.success(employeeShift));
    } on ApiError catch (error) {
      print(error);
      emit(EmployeeShiftState.failed(state.employeeShift, error.message));
    }
  }
}

