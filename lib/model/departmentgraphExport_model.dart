import 'package:freezed_annotation/freezed_annotation.dart';

part 'departmentgraphExport_model.g.dart';
part 'departmentgraphExport_model.freezed.dart';

@freezed
class DepartmentgraphExportModel with _$DepartmentgraphExportModel{
  const factory DepartmentgraphExportModel({
    @Default("") String url,
  }) = _DepartmentgraphExportModel;

  factory DepartmentgraphExportModel.fromJson(Map<String, dynamic> json) => _$DepartmentgraphExportModelFromJson(json);
}