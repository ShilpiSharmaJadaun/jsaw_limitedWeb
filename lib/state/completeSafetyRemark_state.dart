import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jsaw_limited/model/allwork_group_model.dart';
import 'package:jsaw_limited/model/completeMedicalResponse_model.dart';
import 'package:jsaw_limited/model/completeSafetyRemark_model.dart';

part 'completeSafetyRemark_state.freezed.dart';

@freezed
class CompleteSafetyRemarkState with _$CompleteSafetyRemarkState{

  const factory CompleteSafetyRemarkState.loading (List<CompleteSafetyRemarkModel> copmleteSafetyRemak) = _Loading;
  const factory CompleteSafetyRemarkState.content (List<CompleteSafetyRemarkModel> copmleteSafetyRemak) = _Content;
  const factory CompleteSafetyRemarkState.success (List<CompleteSafetyRemarkModel> copmleteSafetyRemak) = _Success;
  const factory CompleteSafetyRemarkState.failed (List<CompleteSafetyRemarkModel> copmleteSafetyRemak, String msg) = _Failed;

  factory CompleteSafetyRemarkState.initial() => CompleteSafetyRemarkState.content([]);

}