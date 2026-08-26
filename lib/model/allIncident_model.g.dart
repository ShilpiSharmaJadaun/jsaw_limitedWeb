// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'allIncident_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AllIncidentModelImpl _$$AllIncidentModelImplFromJson(
        Map<String, dynamic> json) =>
    _$AllIncidentModelImpl(
      id: (json['id'] as num?)?.toInt() ?? 0,
      uniqueId: json['uniqueId'] as String? ?? "",
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
      raisedByEmpCode: json['raisedByEmpCode'] as String? ?? "",
      raisedByEmpName: json['raisedByEmpName'] as String? ?? "",
      status: json['status'] as String? ?? "",
      investigationStatus: json['investigationStatus'] as String? ?? "",
      contactNumber: json['contactNumber'] as String? ?? "",
      incidentType: json['incidentType'] as String? ?? "",
      workInjury: json['workInjury'] as String? ?? "",
      descpOfIncident: json['descpOfIncident'] as String? ?? "",
      firDateTime: json['firDateTime'] as String? ?? "",
      imageUrl: json['imageUrl'] as String? ?? "",
      raisedDate: json['raisedDate'] as String? ?? "",
      updatedDate: json['updatedDate'] as String? ?? "",
      medicalOfficerTypeOfInjury:
          json['medicalOfficerTypeOfInjury'] as String? ?? "",
      bodyPart: json['bodyPart'] as String? ?? "",
      natureOfInjury: json['natureOfInjury'] as String? ?? "",
      restUpto: json['restUpto'] as String? ?? "",
      fitForDutyFrom: json['fitForDutyFrom'] as String? ?? "",
      medicalOfficerRemarks: json['medicalOfficerRemarks'] as String? ?? "",
      medicalOfficerResponseDate:
          json['medicalOfficerResponseDate'] as String? ?? "",
      medicalOfficerUpdatedDate:
          json['medicalOfficerUpdatedDate'] as String? ?? "",
      safetyTypeOfInjury: json['safetyTypeOfInjury'] as String? ?? "",
      safetyRemarks: json['safetyRemarks'] as String? ?? "",
      safetyResponseDate: json['safetyResponseDate'] as String? ?? "",
      safetyUpdatedDate: json['safetyUpdatedDate'] as String? ?? "",
      lowQualityImageUrl: json['lowQualityImageUrl'] as String? ?? "",
      highQualityImageUrl: json['highQualityImageUrl'] as String? ?? "",
    );

Map<String, dynamic> _$$AllIncidentModelImplToJson(
        _$AllIncidentModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uniqueId': instance.uniqueId,
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
      'raisedByEmpCode': instance.raisedByEmpCode,
      'raisedByEmpName': instance.raisedByEmpName,
      'status': instance.status,
      'investigationStatus': instance.investigationStatus,
      'contactNumber': instance.contactNumber,
      'incidentType': instance.incidentType,
      'workInjury': instance.workInjury,
      'descpOfIncident': instance.descpOfIncident,
      'firDateTime': instance.firDateTime,
      'imageUrl': instance.imageUrl,
      'raisedDate': instance.raisedDate,
      'updatedDate': instance.updatedDate,
      'medicalOfficerTypeOfInjury': instance.medicalOfficerTypeOfInjury,
      'bodyPart': instance.bodyPart,
      'natureOfInjury': instance.natureOfInjury,
      'restUpto': instance.restUpto,
      'fitForDutyFrom': instance.fitForDutyFrom,
      'medicalOfficerRemarks': instance.medicalOfficerRemarks,
      'medicalOfficerResponseDate': instance.medicalOfficerResponseDate,
      'medicalOfficerUpdatedDate': instance.medicalOfficerUpdatedDate,
      'safetyTypeOfInjury': instance.safetyTypeOfInjury,
      'safetyRemarks': instance.safetyRemarks,
      'safetyResponseDate': instance.safetyResponseDate,
      'safetyUpdatedDate': instance.safetyUpdatedDate,
      'lowQualityImageUrl': instance.lowQualityImageUrl,
      'highQualityImageUrl': instance.highQualityImageUrl,
    };
