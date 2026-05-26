// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'allobservation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AllObservationModelImpl _$$AllObservationModelImplFromJson(
        Map<String, dynamic> json) =>
    _$AllObservationModelImpl(
      observationRaisedBy: json['observationRaisedBy'] as String? ?? "",
      uniqueIdentificationNumber:
          json['uniqueIdentificationNumber'] as String? ?? "",
      observationRaisedByEmpUnqId:
          json['observationRaisedByEmpUnqId'] as String? ?? "",
      plantDept: json['plantDept'] as String? ?? "",
      location: json['location'] as String? ?? "",
      observationText: json['observationText'] as String? ?? "",
      imageNumber: json['imageNumber'] as String? ?? "",
      category: json['category'] as String? ?? "",
      actionTaken: json['actionTaken'] as String? ?? "",
      responsibility: json['responsibility'] as String? ?? "",
      status: json['status'] as String? ?? "",
      hazardCategory: json['hazardCategory'] as String? ?? "",
      department: json['department'] as String? ?? "",
      deptCode: json['deptCode'] as String? ?? "",
      remarks: json['remarks'] as String? ?? "",
      priorityStatusName: json['priorityStatusName'] as String? ?? "",
      priorityStatusColour: json['priorityStatusColour'] as String? ?? "",
      raisedDate: json['raisedDate'] as String? ?? "",
      responsibilityHODName: json['responsibilityHODName'] as String? ?? "",
      responsibilityHODEmpUnqID:
          json['responsibilityHODEmpUnqID'] as String? ?? "",
      wrkGrp: json['wrkGrp'] as String? ?? "",
      fileURL: json['fileURL'] as String? ?? "",
      stationName: json['stationName'] as String? ?? "",
      station_Code: json['station_Code'] as String? ?? "",
      lowQualityImageUrl: json['lowQualityImageUrl'] as String? ?? "",
      highQualityImageUrl: json['highQualityImageUrl'] as String? ?? "",
    );

Map<String, dynamic> _$$AllObservationModelImplToJson(
        _$AllObservationModelImpl instance) =>
    <String, dynamic>{
      'observationRaisedBy': instance.observationRaisedBy,
      'uniqueIdentificationNumber': instance.uniqueIdentificationNumber,
      'observationRaisedByEmpUnqId': instance.observationRaisedByEmpUnqId,
      'plantDept': instance.plantDept,
      'location': instance.location,
      'observationText': instance.observationText,
      'imageNumber': instance.imageNumber,
      'category': instance.category,
      'actionTaken': instance.actionTaken,
      'responsibility': instance.responsibility,
      'status': instance.status,
      'hazardCategory': instance.hazardCategory,
      'department': instance.department,
      'deptCode': instance.deptCode,
      'remarks': instance.remarks,
      'priorityStatusName': instance.priorityStatusName,
      'priorityStatusColour': instance.priorityStatusColour,
      'raisedDate': instance.raisedDate,
      'responsibilityHODName': instance.responsibilityHODName,
      'responsibilityHODEmpUnqID': instance.responsibilityHODEmpUnqID,
      'wrkGrp': instance.wrkGrp,
      'fileURL': instance.fileURL,
      'stationName': instance.stationName,
      'station_Code': instance.station_Code,
      'lowQualityImageUrl': instance.lowQualityImageUrl,
      'highQualityImageUrl': instance.highQualityImageUrl,
    };
