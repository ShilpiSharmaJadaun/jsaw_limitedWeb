// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'observation_status_List_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ObservationStatusListModelImpl _$$ObservationStatusListModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ObservationStatusListModelImpl(
      percentage: (json['percentage'] as num?)?.toDouble() ?? 0.0,
      count: (json['count'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? "",
    );

Map<String, dynamic> _$$ObservationStatusListModelImplToJson(
        _$ObservationStatusListModelImpl instance) =>
    <String, dynamic>{
      'percentage': instance.percentage,
      'count': instance.count,
      'name': instance.name,
    };
