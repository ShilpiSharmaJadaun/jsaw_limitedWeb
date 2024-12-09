import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jsaw_limited/model/deleteHOD_model.dart';

part 'deleteHOD_state.freezed.dart';

@freezed
class DeleteHODState with _$DeleteHODState {
  const factory DeleteHODState.loading(DeleteHODModel deleteHOD) = _Loading;
  const factory DeleteHODState.content(DeleteHODModel deleteHOD) = _Content;
  const factory DeleteHODState.success(DeleteHODModel deleteHOD, String? message) = _Success;
  const factory DeleteHODState.failed(DeleteHODModel deleteHOD, String message) =_Failed;

  factory DeleteHODState.initial() => const DeleteHODState.content(DeleteHODModel());
}