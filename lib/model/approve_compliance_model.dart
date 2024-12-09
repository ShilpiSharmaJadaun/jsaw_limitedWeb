import 'package:freezed_annotation/freezed_annotation.dart';

part 'approve_compliance_model.g.dart';
part 'approve_compliance_model.freezed.dart';

@freezed
class ApproveComplianceModel with _$ApproveComplianceModel{
  const factory ApproveComplianceModel({

    @Default("") String uniqueIdentificationNumber,
    @Default(0) int id,
    @Default("") String observationRaisedBy,
    @Default("") String observationRaisedByEmpUnqId,
    @Default("") String plantDept,
    @Default("") String plantDeptCode,
    @Default("") String location,
    @Default("") String observationText,
    @Default("") String imageNumber,
    @Default("") String actionTaken,
    @Default("") String responsibility,
    @Default("") String responsibilityEnggCode,
    @Default("") String status,
    @Default("") String hazardCategory,
    @Default("") String remarks,
    @Default("") String imageCompliance,
    @Default("") String priorityStatusName,
    @Default("") String priorityStatusColour,
    @Default("") String raisedDate,
    @Default("") String responsibilityHODName,
    @Default("") String responsibilityHODEmpUnqID,
    @Default("") String wrkGrp,
    @Default("") String updatedByEmpId,
    @Default("") String updatedByEmpName,
    @Default("") String categoryName,
    @Default("") String correctiveMeasure,
    @Default("") String updatedDate,
    @Default("") String station_Code,
    @Default("") String stationName,

  }) = _ApproveComplianceModel;

  factory ApproveComplianceModel.fromJson(Map<String, dynamic> json) => _$ApproveComplianceModelFromJson(json);
}