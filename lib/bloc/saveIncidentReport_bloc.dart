import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:jsaw_limited/service/incident_service.dart';
import 'package:jsaw_limited/state/saveIncidentReport_state.dart';
import '../service/observation_service.dart';
import '../error/api_error.dart';
import '../state/save_observation_state.dart';

class SaveIncidentReportingBloc extends Cubit<SaveIncidentReportingState> {
  SaveIncidentReportingBloc(this.incidentService) : super(SaveIncidentReportingState.initial());

  final IncidentService incidentService;

  Future<void> saveObservation(
      Uint8List fileBytes,
      String incidentDateTime,
      String shift,
      String employeeCode,
      String employeeName,
      String age,
      String gender,
      String wrkGrp,
      String contractorName,
      String contCode,
      String plant,
      String plantCode,
      String deptName,
      String deptCode,
      String location,
      String responsibleShiftEngg,
      String responsibleHod,
      String contactNumber,
      String incidentType,
      String descpOfIncident,
      String responsibleHodCode,
      ) async {
    emit(SaveIncidentReportingState.loading(state.saveIncident));
    try {
      final msg = await incidentService.getSaveObservation(
        fileBytes,
        incidentDateTime,
        shift,
        employeeCode,
        employeeName,
        age,
        gender,
        wrkGrp,
         contractorName,
        contCode,
        plant, plantCode,
        deptName,
        deptCode,
        location,
        responsibleShiftEngg,
        responsibleHod,
        contactNumber,
        incidentType,
        descpOfIncident,
        responsibleHodCode,
      );
      emit(SaveIncidentReportingState.success(state.saveIncident, msg!));
    } on ApiError catch (error) {
      emit(SaveIncidentReportingState.failed(state.saveIncident, error.message));
    } catch (e) {
      print(e);
      emit(SaveIncidentReportingState.failed(state.saveIncident, e.toString()));
    }
  }
}
