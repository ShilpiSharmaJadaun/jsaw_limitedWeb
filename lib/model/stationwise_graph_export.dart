import 'package:freezed_annotation/freezed_annotation.dart';

part 'stationwise_graph_export.g.dart';
part 'stationwise_graph_export.freezed.dart';

@freezed
class StationWiseGraphExportModel with _$StationWiseGraphExportModel{
  const factory StationWiseGraphExportModel({
    @Default("") String url,
  }) = _StationWiseGraphExportModel;

  factory StationWiseGraphExportModel.fromJson(Map<String, dynamic> json) => _$StationWiseGraphExportModelFromJson(json);
}