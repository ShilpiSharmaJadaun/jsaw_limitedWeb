// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LocationModelImpl _$$LocationModelImplFromJson(Map<String, dynamic> json) =>
    _$LocationModelImpl(
      id: (json['id'] as num?)?.toInt() ?? 0,
      deptCode: json['deptCode'] as String? ?? "",
      deptName_Plant: json['deptName_Plant'] as String? ?? "",
      locations: json['locations'] as String? ?? "",
    );

Map<String, dynamic> _$$LocationModelImplToJson(_$LocationModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'deptCode': instance.deptCode,
      'deptName_Plant': instance.deptName_Plant,
      'locations': instance.locations,
    };
