import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jsaw_limited/model/userwise_table_export.dart';

part 'userwise_table_export_state.freezed.dart';

@freezed
class UserWiseTableExportState with _$UserWiseTableExportState {
  const factory UserWiseTableExportState.loading(UserWiseTableExport userWiseTableExport) = _Loading;
  const factory UserWiseTableExportState.content(UserWiseTableExport userWiseTableExport) = _Content;
  const factory UserWiseTableExportState.success(UserWiseTableExport userWiseTableExport,String? url) = _Success;
  const factory UserWiseTableExportState.failed(UserWiseTableExport userWiseTableExport, String message) =
  _Failed;

  factory UserWiseTableExportState.initial() => const UserWiseTableExportState.content(UserWiseTableExport());
}