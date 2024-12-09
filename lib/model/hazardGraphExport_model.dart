import 'package:freezed_annotation/freezed_annotation.dart';

part 'hazardGraphExport_model.g.dart';
part 'hazardGraphExport_model.freezed.dart';

@freezed
class HazardGraphExportModel with _$HazardGraphExportModel{
  const factory HazardGraphExportModel({
    @Default("") String url,
  }) = _HazardGraphExportModel;

  factory HazardGraphExportModel.fromJson(Map<String, dynamic> json) => _$HazardGraphExportModelFromJson(json);
}