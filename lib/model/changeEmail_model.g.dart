// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'changeEmail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChangeEmailModelImpl _$$ChangeEmailModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ChangeEmailModelImpl(
      status: json['status'] as String? ?? "",
      msg: json['msg'] as String? ?? "",
      model: (json['model'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$ChangeEmailModelImplToJson(
        _$ChangeEmailModelImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'msg': instance.msg,
      'model': instance.model,
    };
