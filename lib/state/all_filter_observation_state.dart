import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jsaw_limited/model/all_filter_observation_model.dart';

part 'all_filter_observation_state.freezed.dart';

@freezed
class AllFilterObservationState with _$AllFilterObservationState{

  const factory AllFilterObservationState.loading (AllFilterObservationModel filterObservation) = _Loading;
  const factory AllFilterObservationState.content (AllFilterObservationModel filterObservation) = _Content;
  const factory AllFilterObservationState.success (AllFilterObservationModel filterObservation) = _Success;
  const factory AllFilterObservationState.failed (AllFilterObservationModel filterObservation, String msg) = _Failed;

  factory AllFilterObservationState.initial() => AllFilterObservationState.content(AllFilterObservationModel());

}