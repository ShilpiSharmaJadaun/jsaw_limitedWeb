import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:jsaw_limited/state/changeobservationimage_state.dart';
import '../service/observation_service.dart';
import '../error/api_error.dart';
import '../state/save_observation_state.dart';

class ChangeObservationImageBloc extends Cubit<ChangeObservationImageState> {
  ChangeObservationImageBloc(this.observationService) : super(ChangeObservationImageState.initial());

  final ObservationService observationService;

  Future<void> saveObservation(
      Uint8List fileBytes,
      String observationRaisedBy,
      ) async {
    emit(ChangeObservationImageState.loading(state.changeObservationImage));
    try {
      final msg = await observationService.changeObservationImage(fileBytes, observationRaisedBy);
      emit(ChangeObservationImageState.success(state.changeObservationImage, msg!));
    } on ApiError catch (error) {
      print(error);
      emit(ChangeObservationImageState.failed(state.changeObservationImage, error.message));
    } catch (e) {
      print(e);
      emit(ChangeObservationImageState.failed(state.changeObservationImage, e.toString()));
    }
  }
}
