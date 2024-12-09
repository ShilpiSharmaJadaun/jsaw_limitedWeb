import 'package:freezed_annotation/freezed_annotation.dart';

part 'stationwise_graphtable_model.g.dart';
part 'stationwise_graphtable_model.freezed.dart';

@freezed
class StationWiseGraphTableModel with _$StationWiseGraphTableModel{
  const factory StationWiseGraphTableModel({
    @Default("") String stationName,
    @Default(0) int totalRaised,
    @Default(0) int totalReceived,
  }) = _StationWiseGraphTableModel;

  factory StationWiseGraphTableModel.fromJson(Map<String, dynamic> json) => _$StationWiseGraphTableModelFromJson(json);
}