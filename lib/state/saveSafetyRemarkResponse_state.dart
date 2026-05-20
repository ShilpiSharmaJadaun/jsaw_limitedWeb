import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jsaw_limited/model/saveMedicalResponse_model.dart';
import 'package:jsaw_limited/model/saveSafetyRemarkResponse_model.dart';
import 'package:jsaw_limited/model/update_observation_model.dart';

part 'saveSafetyRemarkResponse_state.freezed.dart';

@freezed
class SafetyRemarkResponseState with _$SafetyRemarkResponseState {
  const factory SafetyRemarkResponseState.loading(SafetyRemarkResponseModel saveSafetyRemarkResponse) = _Loading;
  const factory SafetyRemarkResponseState.content(SafetyRemarkResponseModel saveSafetyRemarkResponse) = _Content;
  const factory SafetyRemarkResponseState.success(SafetyRemarkResponseModel saveSafetyRemarkResponse, String? message) = _Success;
  const factory SafetyRemarkResponseState.failed(SafetyRemarkResponseModel saveSafetyRemarkResponse, String message) =
  _Failed;

  factory SafetyRemarkResponseState.initial() => SafetyRemarkResponseState.content(SafetyRemarkResponseModel());
}