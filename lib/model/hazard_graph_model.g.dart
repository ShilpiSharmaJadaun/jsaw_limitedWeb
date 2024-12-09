// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hazard_graph_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HazardGraphModelImpl _$$HazardGraphModelImplFromJson(
        Map<String, dynamic> json) =>
    _$HazardGraphModelImpl(
      hazardCategory: json['hazardCategory'] as String? ?? '',
      observationCount: (json['observationCount'] as num?)?.toInt() ?? 0,
      percentage: (json['percentage'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$HazardGraphModelImplToJson(
        _$HazardGraphModelImpl instance) =>
    <String, dynamic>{
      'hazardCategory': instance.hazardCategory,
      'observationCount': instance.observationCount,
      'percentage': instance.percentage,
    };
