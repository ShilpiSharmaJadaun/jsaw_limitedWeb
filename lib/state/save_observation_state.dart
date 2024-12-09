import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jsaw_limited/model/save_observation_model.dart';

part 'save_observation_state.freezed.dart';

@freezed
class SaveObservationState with _$SaveObservationState {
  const factory SaveObservationState.loading(SaveObservationModel saveObservation) = _Loading;
  const factory SaveObservationState.content(SaveObservationModel saveObservation) = _Content;
  const factory SaveObservationState.success(SaveObservationModel saveObservation, String msg) = _Success;
  const factory SaveObservationState.failed(SaveObservationModel saveObservation, String msg) =
  _Failed;

  factory SaveObservationState.initial() => const SaveObservationState.content(SaveObservationModel());
}