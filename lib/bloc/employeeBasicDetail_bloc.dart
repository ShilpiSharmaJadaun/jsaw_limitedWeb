import 'package:bloc/bloc.dart';
import 'package:jsaw_limited/service/employee_reporting_service.dart';
import 'package:jsaw_limited/service/incident_service.dart';
import 'package:jsaw_limited/state/employeeAppReporting_state.dart';
import 'package:jsaw_limited/state/employeeBasicDetail_state.dart';
import '../error/api_error.dart';
import 'dart:html';

class EmployeeBasicDetailBloc extends Cubit<EmployeeBasicDetailState> {
  EmployeeBasicDetailBloc(this.incidentService) : super(EmployeeBasicDetailState.initial());

  late IncidentService incidentService;

  final employeeCode = window.localStorage['kEmployeeCode'] ?? "";

  Future<void> initState() async {
    emit(EmployeeBasicDetailState.loading(state.appReporting));
    try {
      final employeeResponsibility = await incidentService.getEmployeeBasicDetail();
      emit(EmployeeBasicDetailState.success(employeeResponsibility));
    } on ApiError catch (error) {
      print(error);
      emit(EmployeeBasicDetailState.failed(state.appReporting, error.message));
    }
  }
}

