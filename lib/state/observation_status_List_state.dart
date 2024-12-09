import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jsaw_limited/model/observation_status_List_model.dart';
import 'package:jsaw_limited/model/observationstatus_model.dart';

part 'observation_status_List_state.freezed.dart';

@freezed
class ObservationStatusListState with _$ObservationStatusListState{

  const factory ObservationStatusListState.loading (List<ObservationStatusListModel> observationStatusListModel) = _Loading;
  const factory ObservationStatusListState.content (List<ObservationStatusListModel> observationStatusListModel) = _Content;
  const factory ObservationStatusListState.success (List<ObservationStatusListModel> observationStatusListModel) = _Success;
  const factory ObservationStatusListState.failed (List<ObservationStatusListModel> observationStatusListModel, String msg) = _Failed;

  factory ObservationStatusListState.initial() => ObservationStatusListState.content([]);

}