import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jsaw_limited/model/allobservation_model.dart';

part 'allobservation_state.freezed.dart';

@freezed
class AllObservationState with _$AllObservationState{

  const factory AllObservationState.loading (List<AllObservationModel> divisionModel) = _Loading;
  const factory AllObservationState.content (List<AllObservationModel> divisionModel) = _Content;
  const factory AllObservationState.success (List<AllObservationModel> divisionModel) = _Success;
  const factory AllObservationState.failed (List<AllObservationModel> divisionModel, String msg) = _Failed;

  factory AllObservationState.initial() => AllObservationState.content([]);

}