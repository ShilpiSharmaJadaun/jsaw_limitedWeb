import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jsaw_limited/model/observationstatus_model.dart';

part 'observationStatus_state.freezed.dart';

@freezed
class ObservationStatusState with _$ObservationStatusState{

  const factory ObservationStatusState.loading (ObservationStatusModel observationStatus) = _Loading;
  const factory ObservationStatusState.content (ObservationStatusModel observationStatus) = _Content;
  const factory ObservationStatusState.success (ObservationStatusModel observationStatus) = _Success;
  const factory ObservationStatusState.failed (ObservationStatusModel observationStatus, String msg) = _Failed;

  factory ObservationStatusState.initial() => ObservationStatusState.content(ObservationStatusModel());

}