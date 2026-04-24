import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jsaw_limited/model/allHod_model.dart';
import 'package:jsaw_limited/model/allNatureInjury_model.dart';
import 'package:jsaw_limited/model/allTypeIncident_model.dart';

part 'allTypeIncident_state.freezed.dart';

@freezed
class AllTypeIncidentState with _$AllTypeIncidentState{

  const factory AllTypeIncidentState.loading (List<AllTypeIncidentModel> allTypeIncident) = _Loading;
  const factory AllTypeIncidentState.content (List<AllTypeIncidentModel> allTypeIncident) = _Content;
  const factory AllTypeIncidentState.success (List<AllTypeIncidentModel> allTypeIncident) = _Success;
  const factory AllTypeIncidentState.failed (List<AllTypeIncidentModel> allTypeIncident, String msg) = _Failed;

  factory AllTypeIncidentState.initial() => AllTypeIncidentState.content([]);

}