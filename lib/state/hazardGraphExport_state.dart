import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jsaw_limited/model/departmentgraphExport_model.dart';
import 'package:jsaw_limited/model/hazardGraphExport_model.dart';

part 'hazardGraphExport_state.freezed.dart';

@freezed
class HazardGraphExportState with _$HazardGraphExportState {
  const factory HazardGraphExportState.loading(HazardGraphExportModel hazardGraphExport) = _Loading;
  const factory HazardGraphExportState.content(HazardGraphExportModel hazardGraphExport) = _Content;
  const factory HazardGraphExportState.success(HazardGraphExportModel hazardGraphExport,String? url) = _Success;
  const factory HazardGraphExportState.failed(HazardGraphExportModel hazardGraphExport, String message) =
  _Failed;

  factory HazardGraphExportState.initial() => const HazardGraphExportState.content(HazardGraphExportModel());
}