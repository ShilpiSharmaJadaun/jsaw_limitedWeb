import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import '../service/observation_service.dart';
import '../error/api_error.dart';
import '../state/save_observation_state.dart';

class SaveObservationBloc extends Cubit<SaveObservationState> {
  SaveObservationBloc(this.observationService) : super(SaveObservationState.initial());

  final ObservationService observationService;

  Future<void> saveObservation(
      Uint8List fileBytes,
      String observationRaisedBy,
      String observationRaisedByEmpUnqId,
      String plantDeptName,
      String plantDeptCode,
      String locationName,
      String observationPoint,
      String responsibilityEnggName,
      String responsibilityEnggCode,
      String responsibilityHODName,
      String responsibilityHODEmpUnqID,
      String stationName,
      String stationCode,
      String priorityStatusName,
      String remarks,
      String hazardCategoryName,
      String status,
      String wrkGrp,
      String priorityStatusColor,
      String updatedByEmpId,
      String updatedByEmpName,
      String categoryName,
      String correctiveMeasure, String plantHead,
      String plantHeadName,
      String plantHeadEmail,
      String observationOccurrenceTime,
      String unitPlantCode,
      String unitPlantName,
      String unitEmpName,
      String unitEmpUnqId,
      String unitEmpEmail,
      String rootCause
      ) async {
    emit(SaveObservationState.loading(state.saveObservation));
    try {
      final msg = await observationService.getSaveObservation(
        fileBytes,
        observationRaisedBy,
        observationRaisedByEmpUnqId,
        plantDeptName,
        plantDeptCode,
        locationName,
        observationPoint,
        responsibilityEnggName,
        responsibilityEnggCode,
        responsibilityHODName,
        responsibilityHODEmpUnqID,
        stationName,
        stationCode,
        priorityStatusName,
        remarks,
        hazardCategoryName,
        status,
        wrkGrp,
          priorityStatusColor,
          updatedByEmpId,
          updatedByEmpName,
          categoryName,
          correctiveMeasure,
        plantHead,
        plantHeadName,
        plantHeadEmail,
          observationOccurrenceTime,
          unitPlantCode,
          unitPlantName,
          unitEmpName,
          unitEmpUnqId,
          unitEmpEmail,
        rootCause,
      );
      emit(SaveObservationState.success(state.saveObservation, msg!));
    } on ApiError catch (error) {
      emit(SaveObservationState.failed(state.saveObservation, error.message));
    } catch (e) {
      print(e);
      emit(SaveObservationState.failed(state.saveObservation, e.toString()));
    }
  }
}
