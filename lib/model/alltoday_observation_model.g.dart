// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alltoday_observation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AllTodayObservationModelImpl _$$AllTodayObservationModelImplFromJson(
        Map<String, dynamic> json) =>
    _$AllTodayObservationModelImpl(
      id: (json['id'] as num?)?.toInt() ?? 0,
      observationRaisedBy: json['observationRaisedBy'] as String? ?? "",
      observationRaisedByEmpUnqId:
          json['observationRaisedByEmpUnqId'] as String? ?? "",
      uniqueIdentificationNumber:
          json['uniqueIdentificationNumber'] as String? ?? "",
      plantDept: json['plantDept'] as String? ?? "",
      plantDeptCode: json['plantDeptCode'] as String? ?? "",
      location: json['location'] as String? ?? "",
      observationText: json['observationText'] as String? ?? "",
      imageNumber: json['imageNumber'] as String? ?? "",
      actionTaken: json['actionTaken'] as String? ?? "",
      responsibility: json['responsibility'] as String? ?? "",
      status: json['status'] as String? ?? "",
      hazardCategory: json['hazardCategory'] as String? ?? "",
      stationName: json['stationName'] as String? ?? "",
      remarks: json['remarks'] as String? ?? "",
      imageCompliance: json['imageCompliance'] as String? ?? "",
      priorityStatusName: json['priorityStatusName'] as String? ?? "",
      priorityStatusColour: json['priorityStatusColour'] as String? ?? "",
      raisedDate: json['raisedDate'] as String? ?? "",
      responsibilityHODName: json['responsibilityHODName'] as String? ?? "",
      responsibilityHODEmpUnqID:
          json['responsibilityHODEmpUnqID'] as String? ?? "",
      stationCode: json['stationCode'] as String? ?? "",
      lowQualityImageUrl: json['lowQualityImageUrl'] as String? ?? "",
      highQualityImageUrl: json['highQualityImageUrl'] as String? ?? "",
    );

Map<String, dynamic> _$$AllTodayObservationModelImplToJson(
        _$AllTodayObservationModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'observationRaisedBy': instance.observationRaisedBy,
      'observationRaisedByEmpUnqId': instance.observationRaisedByEmpUnqId,
      'uniqueIdentificationNumber': instance.uniqueIdentificationNumber,
      'plantDept': instance.plantDept,
      'plantDeptCode': instance.plantDeptCode,
      'location': instance.location,
      'observationText': instance.observationText,
      'imageNumber': instance.imageNumber,
      'actionTaken': instance.actionTaken,
      'responsibility': instance.responsibility,
      'status': instance.status,
      'hazardCategory': instance.hazardCategory,
      'stationName': instance.stationName,
      'remarks': instance.remarks,
      'imageCompliance': instance.imageCompliance,
      'priorityStatusName': instance.priorityStatusName,
      'priorityStatusColour': instance.priorityStatusColour,
      'raisedDate': instance.raisedDate,
      'responsibilityHODName': instance.responsibilityHODName,
      'responsibilityHODEmpUnqID': instance.responsibilityHODEmpUnqID,
      'stationCode': instance.stationCode,
      'lowQualityImageUrl': instance.lowQualityImageUrl,
      'highQualityImageUrl': instance.highQualityImageUrl,
    };
