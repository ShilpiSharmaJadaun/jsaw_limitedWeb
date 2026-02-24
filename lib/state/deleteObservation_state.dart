import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jsaw_limited/model/changeEmail_model.dart';
import 'package:jsaw_limited/model/changepassword_model.dart';
import 'package:jsaw_limited/model/deleteObservation_model.dart';

part 'deleteObservation_state.freezed.dart';

@freezed
class DeleteObservationState with _$DeleteObservationState {
  const factory DeleteObservationState.loading(DeleteObservationModel deleteObservation) = _Loading;
  const factory DeleteObservationState.content(DeleteObservationModel deleteObservation) = _Content;
  const factory DeleteObservationState.success(DeleteObservationModel deleteObservation, String? message) = _Success;
  const factory DeleteObservationState.failed(DeleteObservationModel deleteObservation, String message) =_Failed;

  factory DeleteObservationState.initial() => const DeleteObservationState.content(DeleteObservationModel());
}