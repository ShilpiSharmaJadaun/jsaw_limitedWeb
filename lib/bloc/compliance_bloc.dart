import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:jsaw_limited/state/compliance_state.dart';
import '../service/observation_service.dart';
import '../error/api_error.dart';
import '../state/save_observation_state.dart';

class ComplianceBloc extends Cubit<ComplianceState> {
  ComplianceBloc(this.observationService) : super(ComplianceState.initial());

  final ObservationService observationService;

  Future<void> saveObservation(
      Uint8List fileBytes,
      String uniqueIdentificationNumber,
      String observationText,
      String actionTaken,
      String status,
      String remarks,
      String updatedByEmpId,
      String updatedByEmpName,
      String updatedByEmail,
      String raisedByEmpID,
      ) async {
    emit(ComplianceState.loading(state.complianceModel));
    try {
      final msg = await observationService.getCompliance(fileBytes, uniqueIdentificationNumber, observationText, actionTaken,
          status, remarks, updatedByEmpId, updatedByEmpName, updatedByEmail, raisedByEmpID);
      emit(ComplianceState.success(state.complianceModel, msg!));
    } on ApiError catch (error) {
      print(error);
      emit(ComplianceState.failed(state.complianceModel, error.message));
    } catch (e) {
      print(e);
      emit(ComplianceState.failed(state.complianceModel, e.toString()));
    }
  }
}
