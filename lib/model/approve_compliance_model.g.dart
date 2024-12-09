// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'approve_compliance_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ApproveComplianceModelImpl _$$ApproveComplianceModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ApproveComplianceModelImpl(
      uniqueIdentificationNumber:
          json['uniqueIdentificationNumber'] as String? ?? "",
      id: (json['id'] as num?)?.toInt() ?? 0,
      observationRaisedBy: json['observationRaisedBy'] as String? ?? "",
      observationRaisedByEmpUnqId:
          json['observationRaisedByEmpUnqId'] as String? ?? "",
      plantDept: json['plantDept'] as String? ?? "",
      plantDeptCode: json['plantDeptCode'] as String? ?? "",
      location: json['location'] as String? ?? "",
      observationText: json['observationText'] as String? ?? "",
      imageNumber: json['imageNumber'] as String? ?? "",
      actionTaken: json['actionTaken'] as String? ?? "",
      responsibility: json['responsibility'] as String? ?? "",
      responsibilityEnggCode: json['responsibilityEnggCode'] as String? ?? "",
      status: json['status'] as String? ?? "",
      hazardCategory: json['hazardCategory'] as String? ?? "",
      remarks: json['remarks'] as String? ?? "",
      imageCompliance: json['imageCompliance'] as String? ?? "",
      priorityStatusName: json['priorityStatusName'] as String? ?? "",
      priorityStatusColour: json['priorityStatusColour'] as String? ?? "",
      raisedDate: json['raisedDate'] as String? ?? "",
      responsibilityHODName: json['responsibilityHODName'] as String? ?? "",
      responsibilityHODEmpUnqID:
          json['responsibilityHODEmpUnqID'] as String? ?? "",
      wrkGrp: json['wrkGrp'] as String? ?? "",
      updatedByEmpId: json['updatedByEmpId'] as String? ?? "",
      updatedByEmpName: json['updatedByEmpName'] as String? ?? "",
      categoryName: json['categoryName'] as String? ?? "",
      correctiveMeasure: json['correctiveMeasure'] as String? ?? "",
      updatedDate: json['updatedDate'] as String? ?? "",
      station_Code: json['station_Code'] as String? ?? "",
      stationName: json['stationName'] as String? ?? "",
    );

Map<String, dynamic> _$$ApproveComplianceModelImplToJson(
        _$ApproveComplianceModelImpl instance) =>
    <String, dynamic>{
      'uniqueIdentificationNumber': instance.uniqueIdentificationNumber,
      'id': instance.id,
      'observationRaisedBy': instance.observationRaisedBy,
      'observationRaisedByEmpUnqId': instance.observationRaisedByEmpUnqId,
      'plantDept': instance.plantDept,
      'plantDeptCode': instance.plantDeptCode,
      'location': instance.location,
      'observationText': instance.observationText,
      'imageNumber': instance.imageNumber,
      'actionTaken': instance.actionTaken,
      'responsibility': instance.responsibility,
      'responsibilityEnggCode': instance.responsibilityEnggCode,
      'status': instance.status,
      'hazardCategory': instance.hazardCategory,
      'remarks': instance.remarks,
      'imageCompliance': instance.imageCompliance,
      'priorityStatusName': instance.priorityStatusName,
      'priorityStatusColour': instance.priorityStatusColour,
      'raisedDate': instance.raisedDate,
      'responsibilityHODName': instance.responsibilityHODName,
      'responsibilityHODEmpUnqID': instance.responsibilityHODEmpUnqID,
      'wrkGrp': instance.wrkGrp,
      'updatedByEmpId': instance.updatedByEmpId,
      'updatedByEmpName': instance.updatedByEmpName,
      'categoryName': instance.categoryName,
      'correctiveMeasure': instance.correctiveMeasure,
      'updatedDate': instance.updatedDate,
      'station_Code': instance.station_Code,
      'stationName': instance.stationName,
    };
