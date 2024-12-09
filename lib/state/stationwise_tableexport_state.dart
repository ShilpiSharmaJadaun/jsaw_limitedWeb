import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jsaw_limited/model/stationwise_graph_tableexport_model.dart';

part 'stationwise_tableexport_state.freezed.dart';



@freezed
class StationWiseTableExportState with _$StationWiseTableExportState {
  const factory StationWiseTableExportState.loading(StationWiseTableExportModel stationwiseTable) = _Loading;
  const factory StationWiseTableExportState.content(StationWiseTableExportModel stationwiseTable) = _Content;
  const factory StationWiseTableExportState.success(StationWiseTableExportModel stationwiseTable, String? url) = _Success;
  const factory StationWiseTableExportState.failed(StationWiseTableExportModel stationwiseTable, String message) =
  _Failed;

  factory StationWiseTableExportState.initial() => StationWiseTableExportState.content(StationWiseTableExportModel());
}