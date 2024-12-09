import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jsaw_limited/model/compliance_model.dart';

part 'complainceApproveReject_state.freezed.dart';

@freezed
class ComplainceApproveRejectState with _$ComplainceApproveRejectState {
  const factory ComplainceApproveRejectState.loading(ComplianceModel complianceModel) = _Loading;
  const factory ComplainceApproveRejectState.content(ComplianceModel complianceModel) = _Content;
  const factory ComplainceApproveRejectState.success(ComplianceModel complianceModel, String? message) = _Success;
  const factory ComplainceApproveRejectState.failed(ComplianceModel complianceModel, String message) =
  _Failed;

  factory ComplainceApproveRejectState.initial() => ComplainceApproveRejectState.content(ComplianceModel());
}