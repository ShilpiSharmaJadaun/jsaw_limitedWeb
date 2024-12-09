import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jsaw_limited/model/departmentgraphExport_model.dart';

part 'departmentgraphExport_state.freezed.dart';

@freezed
class DepartmentgraphExportState with _$DepartmentgraphExportState {
  const factory DepartmentgraphExportState.loading(DepartmentgraphExportModel departgraphExport) = _Loading;
  const factory DepartmentgraphExportState.content(DepartmentgraphExportModel departgraphExport) = _Content;
  const factory DepartmentgraphExportState.success(DepartmentgraphExportModel departgraphExport,String? url) = _Success;
  const factory DepartmentgraphExportState.failed(DepartmentgraphExportModel departgraphExport, String message) =
  _Failed;

  factory DepartmentgraphExportState.initial() => const DepartmentgraphExportState.content(DepartmentgraphExportModel());
}