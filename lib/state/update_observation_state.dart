import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jsaw_limited/model/update_observation_model.dart';

part 'update_observation_state.freezed.dart';

@freezed
class UpdateObservationState with _$UpdateObservationState {
  const factory UpdateObservationState.loading(UpdateObservationModel updateObservation) = _Loading;
  const factory UpdateObservationState.content(UpdateObservationModel updateObservation) = _Content;
  const factory UpdateObservationState.success(UpdateObservationModel updateObservation, String? message) = _Success;
  const factory UpdateObservationState.failed(UpdateObservationModel updateObservation, String message) =
  _Failed;

  factory UpdateObservationState.initial() => UpdateObservationState.content(UpdateObservationModel());
}