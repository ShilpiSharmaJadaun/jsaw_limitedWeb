// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'allIncidentList_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AllIncidentListModelImpl _$$AllIncidentListModelImplFromJson(
        Map<String, dynamic> json) =>
    _$AllIncidentListModelImpl(
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
      contactNumber: json['contactNumber'] as String? ?? "",
      incidentType: json['incidentType'] as String? ?? "",
      workInjury: json['workInjury'] as String? ?? "",
      descpOfIncident: json['descpOfIncident'] as String? ?? "",
      firDateTime: json['firDateTime'] as String? ?? "",
      imageUrl: json['imageUrl'] as String? ?? "",
      raisedDate: json['raisedDate'] as String? ?? "",
    );

Map<String, dynamic> _$$AllIncidentListModelImplToJson(
        _$AllIncidentListModelImpl instance) =>
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
      'contactNumber': instance.contactNumber,
      'incidentType': instance.incidentType,
      'workInjury': instance.workInjury,
      'descpOfIncident': instance.descpOfIncident,
      'firDateTime': instance.firDateTime,
      'imageUrl': instance.imageUrl,
      'raisedDate': instance.raisedDate,
    };
