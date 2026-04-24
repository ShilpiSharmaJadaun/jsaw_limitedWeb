import 'package:freezed_annotation/freezed_annotation.dart';

part 'saveIncidentReporting_model.g.dart';
part 'saveIncidentReporting_model.freezed.dart';

@freezed
class SaveIncidentReportingModel with _$SaveIncidentReportingModel{
  const factory SaveIncidentReportingModel({

    @Default("") String status,
    @Default("") String error,
    @Default("") String path,

  }) = _SaveIncidentReportingModel;

  factory SaveIncidentReportingModel.fromJson(Map<String, dynamic> json) => _$SaveIncidentReportingModelFromJson(json);
}