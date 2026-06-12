// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'safetyRemarkList_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SafetyRemarkListModelImpl _$$SafetyRemarkListModelImplFromJson(
        Map<String, dynamic> json) =>
    _$SafetyRemarkListModelImpl(
      id: (json['id'] as num?)?.toInt() ?? 0,
      incidentReportId: (json['incidentReportId'] as num?)?.toInt() ?? 0,
      incidentUniqueId: json['incidentUniqueId'] as String? ?? "",
      incidentDateTime: json['incidentDateTime'] as String? ?? "",
      shift: json['shift'] as String? ?? "",
      employeeCode: json['employeeCode'] as String? ?? "",
      employeeName: json['employeeName'] as String? ?? "",
      age: (json['age'] as num?)?.toInt() ?? 0,
      contractorName: json['contractorName'] as String? ?? "",
      contCode: json['contCode'] as String? ?? "",
      plant: json['plant'] as String? ?? "",
      plantCode: json['plantCode'] as String? ?? "",
      deptName: json['deptName'] as String? ?? "",
      deptCode: json['deptCode'] as String? ?? "",
      location: json['location'] as String? ?? "",
      responsibleShiftEngg: json['responsibleShiftEngg'] as String? ?? "",
      responsibleHod: json['responsibleHod'] as String? ?? "",
      contactNumber: json['contactNumber'] as String? ?? "",
      incidentType: json['incidentType'] as String? ?? "",
      workInjury: json['workInjury'] as String? ?? "",
      descpOfIncident: json['descpOfIncident'] as String? ?? "",
      firDateTime: json['firDateTime'] as String? ?? "",
      imageUrl: json['imageUrl'] as String? ?? "",
      typeOfInjury: json['typeOfInjury'] as String? ?? "",
      bodyPart: json['bodyPart'] as String? ?? "",
      natureOfInjury: json['natureOfInjury'] as String? ?? "",
      restUpto:
          json['restUpto'] == null ? 0 : _restUptoFromJson(json['restUpto']),
      fitForDutyFrom: json['fitForDutyFrom'] as String? ?? "",
      medicalOfficerRemarks: json['medicalOfficerRemarks'] as String? ?? "",
      medicalOfficerName: json['medicalOfficerName'] as String? ?? "",
      medicalOfficerCode: json['medicalOfficerCode'] as String? ?? "",
      raisedDate: json['raisedDate'] as String? ?? "",
      lowQualityImageUrl: json['lowQualityImageUrl'] as String? ?? "",
      highQualityImageUrl: json['highQualityImageUrl'] as String? ?? "",
    );

Map<String, dynamic> _$$SafetyRemarkListModelImplToJson(
        _$SafetyRemarkListModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'incidentReportId': instance.incidentReportId,
      'incidentUniqueId': instance.incidentUniqueId,
      'incidentDateTime': instance.incidentDateTime,
      'shift': instance.shift,
      'employeeCode': instance.employeeCode,
      'employeeName': instance.employeeName,
      'age': instance.age,
      'contractorName': instance.contractorName,
      'contCode': instance.contCode,
      'plant': instance.plant,
      'plantCode': instance.plantCode,
      'deptName': instance.deptName,
      'deptCode': instance.deptCode,
      'location': instance.location,
      'responsibleShiftEngg': instance.responsibleShiftEngg,
      'responsibleHod': instance.responsibleHod,
      'contactNumber': instance.contactNumber,
      'incidentType': instance.incidentType,
      'workInjury': instance.workInjury,
      'descpOfIncident': instance.descpOfIncident,
      'firDateTime': instance.firDateTime,
      'imageUrl': instance.imageUrl,
      'typeOfInjury': instance.typeOfInjury,
      'bodyPart': instance.bodyPart,
      'natureOfInjury': instance.natureOfInjury,
      'restUpto': instance.restUpto,
      'fitForDutyFrom': instance.fitForDutyFrom,
      'medicalOfficerRemarks': instance.medicalOfficerRemarks,
      'medicalOfficerName': instance.medicalOfficerName,
      'medicalOfficerCode': instance.medicalOfficerCode,
      'raisedDate': instance.raisedDate,
      'lowQualityImageUrl': instance.lowQualityImageUrl,
      'highQualityImageUrl': instance.highQualityImageUrl,
    };
