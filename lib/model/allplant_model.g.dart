// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'allplant_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AllPlantModelImpl _$$AllPlantModelImplFromJson(Map<String, dynamic> json) =>
    _$AllPlantModelImpl(
      deptCode: json['deptCode'] as String? ?? '',
      deptName: json['deptName'] as String? ?? '',
      unitCode: (json['unitCode'] as num?)?.toInt() ?? 0,
      workGroup: json['workGroup'] as String? ?? '',
      location: json['location'] as String? ?? '',
    );

Map<String, dynamic> _$$AllPlantModelImplToJson(_$AllPlantModelImpl instance) =>
    <String, dynamic>{
      'deptCode': instance.deptCode,
      'deptName': instance.deptName,
      'unitCode': instance.unitCode,
      'workGroup': instance.workGroup,
      'location': instance.location,
    };
