import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jsaw_limited/model/compliance_model.dart';
import 'package:jsaw_limited/model/update_observation_model.dart';

part 'compliance_state.freezed.dart';

@freezed
class ComplianceState with _$ComplianceState {
  const factory ComplianceState.loading(ComplianceModel complianceModel) = _Loading;
  const factory ComplianceState.content(ComplianceModel complianceModel) = _Content;
  const factory ComplianceState.success(ComplianceModel complianceModel, String? message) = _Success;
  const factory ComplianceState.failed(ComplianceModel complianceModel, String message) =
  _Failed;

  factory ComplianceState.initial() => ComplianceState.content(ComplianceModel());
}