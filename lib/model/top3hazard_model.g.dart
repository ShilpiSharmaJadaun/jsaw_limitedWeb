// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'top3hazard_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$Top3HazardModelImpl _$$Top3HazardModelImplFromJson(
        Map<String, dynamic> json) =>
    _$Top3HazardModelImpl(
      hazardCategory: json['hazardCategory'] as String? ?? "",
      count: (json['count'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$Top3HazardModelImplToJson(
        _$Top3HazardModelImpl instance) =>
    <String, dynamic>{
      'hazardCategory': instance.hazardCategory,
      'count': instance.count,
    };
