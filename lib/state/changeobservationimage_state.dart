import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jsaw_limited/model/changeobservationimage_model.dart';
import 'package:jsaw_limited/model/save_observation_model.dart';

part 'changeobservationimage_state.freezed.dart';

@freezed
class ChangeObservationImageState with _$ChangeObservationImageState {
  const factory ChangeObservationImageState.loading(ChangeObservationImageModel changeObservationImage) = _Loading;
  const factory ChangeObservationImageState.content(ChangeObservationImageModel changeObservationImage) = _Content;
  const factory ChangeObservationImageState.success(ChangeObservationImageModel changeObservationImage, String msg) = _Success;
  const factory ChangeObservationImageState.failed(ChangeObservationImageModel changeObservationImage, String msg) =
  _Failed;

  factory ChangeObservationImageState.initial() => const ChangeObservationImageState.content(ChangeObservationImageModel());
}