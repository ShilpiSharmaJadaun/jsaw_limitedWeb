import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jsaw_limited/model/raisedObservation_model.dart';

part 'raisedObservationState.freezed.dart';

@freezed
class RaisedObservationState with _$RaisedObservationState{

  const factory RaisedObservationState.loading (List<RaisedObservationModel> raisedObservation) = _Loading;
  const factory RaisedObservationState.content (List<RaisedObservationModel> raisedObservation) = _Content;
  const factory RaisedObservationState.success (List<RaisedObservationModel> raisedObservation) = _Success;
  const factory RaisedObservationState.failed (List<RaisedObservationModel> raisedObservation, String msg) = _Failed;

  factory RaisedObservationState.initial() => RaisedObservationState.content([]);

}