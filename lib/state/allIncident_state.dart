import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jsaw_limited/model/allHod_model.dart';
import 'package:jsaw_limited/model/allIncident_model.dart';
import 'package:jsaw_limited/model/allMedicalOfficerList_model.dart';

part 'allIncident_state.freezed.dart';

@freezed
class AllIncidentState with _$AllIncidentState{

  const factory AllIncidentState.loading (List<AllIncidentModel> allIncident) = _Loading;
  const factory AllIncidentState.content (List<AllIncidentModel> allIncident) = _Content;
  const factory AllIncidentState.success (List<AllIncidentModel> allIncident) = _Success;
  const factory AllIncidentState.failed (List<AllIncidentModel> allIncident, String msg) = _Failed;

  factory AllIncidentState.initial() => AllIncidentState.content([]);

}