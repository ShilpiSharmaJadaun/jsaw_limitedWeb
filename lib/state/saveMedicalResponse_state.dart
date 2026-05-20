import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jsaw_limited/model/saveMedicalResponse_model.dart';
import 'package:jsaw_limited/model/update_observation_model.dart';

part 'saveMedicalResponse_state.freezed.dart';

@freezed
class SaveMedicalResponseState with _$SaveMedicalResponseState {
  const factory SaveMedicalResponseState.loading(SaveMedicalResponseModel saveMedicalResponse) = _Loading;
  const factory SaveMedicalResponseState.content(SaveMedicalResponseModel saveMedicalResponse) = _Content;
  const factory SaveMedicalResponseState.success(SaveMedicalResponseModel saveMedicalResponse, String? message) = _Success;
  const factory SaveMedicalResponseState.failed(SaveMedicalResponseModel saveMedicalResponse, String message) =
  _Failed;

  factory SaveMedicalResponseState.initial() => SaveMedicalResponseState.content(SaveMedicalResponseModel());
}