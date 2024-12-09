// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plantHead_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PlantHeadModelImpl _$$PlantHeadModelImplFromJson(Map<String, dynamic> json) =>
    _$PlantHeadModelImpl(
      plantCode: json['plantCode'] as String? ?? "",
      plantName: json['plantName'] as String? ?? "",
      empName: json['empName'] as String? ?? "",
      empUnqId: json['empUnqId'] as String? ?? "",
      empEmail: json['empEmail'] as String? ?? "",
    );

Map<String, dynamic> _$$PlantHeadModelImplToJson(
        _$PlantHeadModelImpl instance) =>
    <String, dynamic>{
      'plantCode': instance.plantCode,
      'plantName': instance.plantName,
      'empName': instance.empName,
      'empUnqId': instance.empUnqId,
      'empEmail': instance.empEmail,
    };
