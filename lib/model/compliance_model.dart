import 'package:freezed_annotation/freezed_annotation.dart';

part 'compliance_model.g.dart';
part 'compliance_model.freezed.dart';

@freezed
class ComplianceModel with _$ComplianceModel{
  const factory ComplianceModel({
    @Default("") String status,
    @Default("") String msg,
  }) = _ComplianceModel;

  factory ComplianceModel.fromJson(Map<String, dynamic> json) => _$ComplianceModelFromJson(json);
}