import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jsaw_limited/model/allHod_model.dart';
import 'package:jsaw_limited/model/allIncidentList_model.dart';

part 'allIncidentList_state.freezed.dart';

@freezed
class AllIncidentListState with _$AllIncidentListState{

  const factory AllIncidentListState.loading (List<AllIncidentListModel> allIncidentList) = _Loading;
  const factory AllIncidentListState.content (List<AllIncidentListModel> allIncidentList) = _Content;
  const factory AllIncidentListState.success (List<AllIncidentListModel> allIncidentList) = _Success;
  const factory AllIncidentListState.failed (List<AllIncidentListModel> allIncidentList, String msg) = _Failed;

  factory AllIncidentListState.initial() => AllIncidentListState.content([]);

}