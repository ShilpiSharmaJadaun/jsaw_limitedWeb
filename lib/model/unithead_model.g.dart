// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unithead_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UnitHeadModelImpl _$$UnitHeadModelImplFromJson(Map<String, dynamic> json) =>
    _$UnitHeadModelImpl(
      unitPlantCode: json['unitPlantCode'] as String? ?? "",
      unitPlantName: json['unitPlantName'] as String? ?? "",
      unitEmpName: json['unitEmpName'] as String? ?? "",
      unitEmpUnqId: json['unitEmpUnqId'] as String? ?? "",
      unitEmpEmail: json['unitEmpEmail'] as String? ?? "",
    );

Map<String, dynamic> _$$UnitHeadModelImplToJson(_$UnitHeadModelImpl instance) =>
    <String, dynamic>{
      'unitPlantCode': instance.unitPlantCode,
      'unitPlantName': instance.unitPlantName,
      'unitEmpName': instance.unitEmpName,
      'unitEmpUnqId': instance.unitEmpUnqId,
      'unitEmpEmail': instance.unitEmpEmail,
    };
