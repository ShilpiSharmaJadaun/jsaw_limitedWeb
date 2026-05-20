import 'package:bloc/bloc.dart';
import 'package:jsaw_limited/service/employee_reporting_service.dart';
import 'package:jsaw_limited/service/incident_service.dart';
import 'package:jsaw_limited/state/completeMedicalResponse_state.dart';
import 'package:jsaw_limited/state/employeeAppReporting_state.dart';
import '../error/api_error.dart';
import 'dart:html';

class CompleteMedicalResponseBloc extends Cubit<CompleteMedicalResponseState> {
  CompleteMedicalResponseBloc(this.incidentService) : super(CompleteMedicalResponseState.initial());

  late IncidentService incidentService;

  final employeeCode = window.localStorage['kEmployeeCode'] ?? "";

  Future<void> initState() async {
    emit(CompleteMedicalResponseState.loading(state.completeMedicalResponse));
    try {
      final employeeResponsibility = await incidentService.getCompleteMedicalResponse();
      emit(CompleteMedicalResponseState.success(employeeResponsibility));
    } on ApiError catch (error) {
      print(error);
      emit(CompleteMedicalResponseState.failed(state.completeMedicalResponse, error.message));
    }
  }
}

