import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jsaw_limited/model/allHod_model.dart';
import 'package:jsaw_limited/model/allMedicalOfficerList_model.dart';
import 'package:jsaw_limited/model/safetyRemarkList_model.dart';

part 'safetyRemarkList_state.freezed.dart';

@freezed
class SafetyRemarkListState with _$SafetyRemarkListState{

  const factory SafetyRemarkListState.loading (List<SafetyRemarkListModel> safetyRemarkListModel) = _Loading;
  const factory SafetyRemarkListState.content (List<SafetyRemarkListModel> safetyRemarkListModel) = _Content;
  const factory SafetyRemarkListState.success (List<SafetyRemarkListModel> safetyRemarkListModel) = _Success;
  const factory SafetyRemarkListState.failed (List<SafetyRemarkListModel> safetyRemarkListModel, String msg) = _Failed;

  factory SafetyRemarkListState.initial() => SafetyRemarkListState.content([]);

}