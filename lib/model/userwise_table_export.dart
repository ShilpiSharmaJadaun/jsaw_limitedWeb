import 'package:freezed_annotation/freezed_annotation.dart';

part 'userwise_table_export.g.dart';
part 'userwise_table_export.freezed.dart';

@freezed
class UserWiseTableExport with _$UserWiseTableExport{
  const factory UserWiseTableExport({
    @Default("") String url,
  }) = _UserWiseTableExport;

  factory UserWiseTableExport.fromJson(Map<String, dynamic> json) => _$UserWiseTableExportFromJson(json);
}