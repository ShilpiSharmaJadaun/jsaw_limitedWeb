// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'changeobservationimage_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChangeObservationImageModelImpl _$$ChangeObservationImageModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ChangeObservationImageModelImpl(
      status: json['status'] as String? ?? "",
      msg: json['msg'] as String? ?? "",
      url: json['url'] as String? ?? "",
    );

Map<String, dynamic> _$$ChangeObservationImageModelImplToJson(
        _$ChangeObservationImageModelImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'msg': instance.msg,
      'url': instance.url,
    };
