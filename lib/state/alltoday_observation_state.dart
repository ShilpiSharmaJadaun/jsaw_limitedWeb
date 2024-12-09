import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jsaw_limited/model/alltoday_observation_model.dart';

part 'alltoday_observation_state.freezed.dart';

@freezed
class AllTodayObservationState with _$AllTodayObservationState{

  const factory AllTodayObservationState.loading (List<AllTodayObservationModel> allTodayObservation) = _Loading;
  const factory AllTodayObservationState.content (List<AllTodayObservationModel> allTodayObservation) = _Content;
  const factory AllTodayObservationState.success (List<AllTodayObservationModel> allTodayObservation) = _Success;
  const factory AllTodayObservationState.failed (List<AllTodayObservationModel> allTodayObservation, String msg) = _Failed;

  factory AllTodayObservationState.initial() => AllTodayObservationState.content([]);

}