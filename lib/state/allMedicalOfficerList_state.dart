import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jsaw_limited/model/allHod_model.dart';
import 'package:jsaw_limited/model/allMedicalOfficerList_model.dart';

part 'allMedicalOfficerList_state.freezed.dart';

@freezed
class AllMedicalOfficerListState with _$AllMedicalOfficerListState{

  const factory AllMedicalOfficerListState.loading (List<AllMedicalOfficerListModel> allMedicalOfficerList) = _Loading;
  const factory AllMedicalOfficerListState.content (List<AllMedicalOfficerListModel> allMedicalOfficerList) = _Content;
  const factory AllMedicalOfficerListState.success (List<AllMedicalOfficerListModel> allMedicalOfficerList) = _Success;
  const factory AllMedicalOfficerListState.failed (List<AllMedicalOfficerListModel> allMedicalOfficerList, String msg) = _Failed;

  factory AllMedicalOfficerListState.initial() => AllMedicalOfficerListState.content([]);

}