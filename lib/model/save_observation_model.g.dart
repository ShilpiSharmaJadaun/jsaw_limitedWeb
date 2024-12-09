// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_observation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SaveObservationModelImpl _$$SaveObservationModelImplFromJson(
        Map<String, dynamic> json) =>
    _$SaveObservationModelImpl(
      timestamp: json['timestamp'] as String? ?? "",
      status: json['status'] as String? ?? "",
      error: json['error'] as String? ?? "",
      path: json['path'] as String? ?? "",
    );

Map<String, dynamic> _$$SaveObservationModelImplToJson(
        _$SaveObservationModelImpl instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp,
      'status': instance.status,
      'error': instance.error,
      'path': instance.path,
    };
