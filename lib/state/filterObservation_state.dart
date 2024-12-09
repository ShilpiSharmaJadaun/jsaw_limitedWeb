import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jsaw_limited/model/filterObservation_model.dart';

part 'filterObservation_state.freezed.dart';

@freezed
class FilterObservationState with _$FilterObservationState{

  const factory FilterObservationState.loading (List<FilterObservationModel> filterObservation) = _Loading;
  const factory FilterObservationState.content (List<FilterObservationModel> filterObservation) = _Content;
  const factory FilterObservationState.success (List<FilterObservationModel> filterObservation) = _Success;
  const factory FilterObservationState.failed (List<FilterObservationModel> filterObservation, String msg) = _Failed;

  factory FilterObservationState.initial() => FilterObservationState.content([]);

}