import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jsaw_limited/model/stationwise_graph_export.dart';

part 'stationwise_graph_export_state.freezed.dart';

@freezed
class StationWiseGraphExportState with _$StationWiseGraphExportState {
  const factory StationWiseGraphExportState.loading(StationWiseGraphExportModel stationWiseExport) = _Loading;
  const factory StationWiseGraphExportState.content(StationWiseGraphExportModel stationWiseExport) = _Content;
  const factory StationWiseGraphExportState.success(StationWiseGraphExportModel stationWiseExport,String? url) = _Success;
  const factory StationWiseGraphExportState.failed(StationWiseGraphExportModel stationWiseExport, String message) =
  _Failed;

  factory StationWiseGraphExportState.initial() => const StationWiseGraphExportState.content(StationWiseGraphExportModel());
}