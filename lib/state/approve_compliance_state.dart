import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jsaw_limited/model/approve_compliance_model.dart';

part 'approve_compliance_state.freezed.dart';

@freezed
class ApproveComplianceState with _$ApproveComplianceState{

  const factory ApproveComplianceState.loading (List<ApproveComplianceModel> complianceModel) = _Loading;
  const factory ApproveComplianceState.content (List<ApproveComplianceModel> complianceModel) = _Content;
  const factory ApproveComplianceState.success (List<ApproveComplianceModel> complianceModel) = _Success;
  const factory ApproveComplianceState.failed (List<ApproveComplianceModel> complianceModel, String msg) = _Failed;

  factory ApproveComplianceState.initial() => ApproveComplianceState.content([]);

}