import 'package:freezed_annotation/freezed_annotation.dart';

part 'stationwise_graph_tableexport_model.g.dart';
part 'stationwise_graph_tableexport_model.freezed.dart';

@freezed
class StationWiseTableExportModel with _$StationWiseTableExportModel{
  const factory StationWiseTableExportModel({
    @Default("") String url,
  }) = _StationWiseTableExportModel;

  factory StationWiseTableExportModel.fromJson(Map<String, dynamic> json) => _$StationWiseTableExportModelFromJson(json);
}