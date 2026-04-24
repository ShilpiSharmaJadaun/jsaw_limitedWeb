import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jsaw_limited/model/saveIncidentReporting_model.dart';
import 'package:jsaw_limited/model/save_observation_model.dart';

part 'saveIncidentReport_state.freezed.dart';

@freezed
class SaveIncidentReportingState with _$SaveIncidentReportingState {
  const factory SaveIncidentReportingState.loading(SaveIncidentReportingModel saveIncident) = _Loading;
  const factory SaveIncidentReportingState.content(SaveIncidentReportingModel saveIncident) = _Content;
  const factory SaveIncidentReportingState.success(SaveIncidentReportingModel saveIncident, String msg) = _Success;
  const factory SaveIncidentReportingState.failed(SaveIncidentReportingModel saveIncident, String msg) =
  _Failed;

  factory SaveIncidentReportingState.initial() => const SaveIncidentReportingState.content(SaveIncidentReportingModel());
}