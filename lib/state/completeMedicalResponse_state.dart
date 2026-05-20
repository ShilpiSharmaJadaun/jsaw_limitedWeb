import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jsaw_limited/model/allwork_group_model.dart';
import 'package:jsaw_limited/model/completeMedicalResponse_model.dart';

part 'completeMedicalResponse_state.freezed.dart';

@freezed
class CompleteMedicalResponseState with _$CompleteMedicalResponseState{

  const factory CompleteMedicalResponseState.loading (List<CompleteMedicalResponseModel> completeMedicalResponse) = _Loading;
  const factory CompleteMedicalResponseState.content (List<CompleteMedicalResponseModel> completeMedicalResponse) = _Content;
  const factory CompleteMedicalResponseState.success (List<CompleteMedicalResponseModel> completeMedicalResponse) = _Success;
  const factory CompleteMedicalResponseState.failed (List<CompleteMedicalResponseModel> completeMedicalResponse, String msg) = _Failed;

  factory CompleteMedicalResponseState.initial() => CompleteMedicalResponseState.content([]);

}