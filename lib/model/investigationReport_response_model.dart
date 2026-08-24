import 'package:freezed_annotation/freezed_annotation.dart';

part 'investigationReport_response_model.g.dart';
part 'investigationReport_response_model.freezed.dart';

@freezed
class InvestigationReportResponse with _$InvestigationReportResponse {
  const factory InvestigationReportResponse({
    @Default(0) int id,
    @Default(0) int incidentReportId,
    @Default("") String incidentUniqueId,
    @Default("") String reportDate,
    @Default("") String associatedRiskImageUrl,
    @Default("") String lowQualityImageUrl,
    @Default("") String highQualityImageUrl,
    // Facts Leading to the Incident or Dangerous Occurrence (points 4 & 5)
    @Default("") String machineryDetails,
    @Default("") String activityBeforeIncident,
    @Default("") String raisedDate,
    @Default("") String updatedDate,
    @Default([]) List<InvestigationTeamItem> team,
    @Default([]) List<InvestigationRootCauseItem> rootCauses,
    @Default([]) List<InvestigationCapaItem> capa,
    // Root Cause – Inquired With (point 6)
    @Default([]) List<InvestigationInquiredWithItem> inquiredWith,
  }) = _InvestigationReportResponse;

  factory InvestigationReportResponse.fromJson(Map<String, dynamic> json) =>
      _$InvestigationReportResponseFromJson(json);
}

@freezed
class InvestigationTeamItem with _$InvestigationTeamItem {
  const factory InvestigationTeamItem({
    @Default(0) int id,
    @Default(0) int seq,
    @Default("") String empUnqId,
    @Default("") String empName,
  }) = _InvestigationTeamItem;

  factory InvestigationTeamItem.fromJson(Map<String, dynamic> json) =>
      _$InvestigationTeamItemFromJson(json);
}

@freezed
class InvestigationRootCauseItem with _$InvestigationRootCauseItem {
  const factory InvestigationRootCauseItem({
    @Default(0) int id,
    @Default(0) int seq,
    @Default("") String rootCauseText,
  }) = _InvestigationRootCauseItem;

  factory InvestigationRootCauseItem.fromJson(Map<String, dynamic> json) =>
      _$InvestigationRootCauseItemFromJson(json);
}

@freezed
class InvestigationCapaItem with _$InvestigationCapaItem {
  const factory InvestigationCapaItem({
    @Default(0) int id,
    @Default(0) int seq,
    @Default("") String capaText,
    @Default("") String respEmpCode,
    @Default("") String respEmpName,
    @Default("") String respDeptCode,
    @Default("") String targetDate,
  }) = _InvestigationCapaItem;

  factory InvestigationCapaItem.fromJson(Map<String, dynamic> json) =>
      _$InvestigationCapaItemFromJson(json);
}

/// Root Cause – Inquired With (point 6): an employee who was inquired /
/// interviewed while establishing the root cause. Names are snapshots.
@freezed
class InvestigationInquiredWithItem with _$InvestigationInquiredWithItem {
  const factory InvestigationInquiredWithItem({
    @Default(0) int id,
    @Default(0) int seq,
    @Default("") String empUnqId,
    @Default("") String empName,
    @Default("") String deptCode,
    @Default("") String statName,
    @Default("") String gradeName,
    @Default("") String desgName,
  }) = _InvestigationInquiredWithItem;

  factory InvestigationInquiredWithItem.fromJson(Map<String, dynamic> json) =>
      _$InvestigationInquiredWithItemFromJson(json);
}
