// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deleteObservation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DeleteObservationModelImpl _$$DeleteObservationModelImplFromJson(
        Map<String, dynamic> json) =>
    _$DeleteObservationModelImpl(
      status: json['status'] as String? ?? "",
      msg: json['msg'] as String? ?? "",
      model: (json['model'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$DeleteObservationModelImplToJson(
        _$DeleteObservationModelImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'msg': instance.msg,
      'model': instance.model,
    };
