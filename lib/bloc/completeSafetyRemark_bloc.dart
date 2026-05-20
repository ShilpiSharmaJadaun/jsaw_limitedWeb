import 'package:bloc/bloc.dart';
import 'package:jsaw_limited/service/employee_reporting_service.dart';
import 'package:jsaw_limited/service/incident_service.dart';
import 'package:jsaw_limited/state/completeMedicalResponse_state.dart';
import 'package:jsaw_limited/state/completeSafetyRemark_state.dart';
import 'package:jsaw_limited/state/employeeAppReporting_state.dart';
import '../error/api_error.dart';
import 'dart:html';

class CompleteSafetyRemarkbloc extends Cubit<CompleteSafetyRemarkState> {
  CompleteSafetyRemarkbloc(this.incidentService) : super(CompleteSafetyRemarkState.initial());

  late IncidentService incidentService;

  final employeeCode = window.localStorage['kEmployeeCode'] ?? "";

  Future<void> initState() async {
    emit(CompleteSafetyRemarkState.loading(state.copmleteSafetyRemak));
    try {
      final employeeResponsibility = await incidentService.getCompleteSafetyRemark();
      emit(CompleteSafetyRemarkState.success(employeeResponsibility));
    } on ApiError catch (error) {
      print(error);
      emit(CompleteSafetyRemarkState.failed(state.copmleteSafetyRemak, error.message));
    }
  }
}

