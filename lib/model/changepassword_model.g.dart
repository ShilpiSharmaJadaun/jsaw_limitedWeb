// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'changepassword_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChangepasswordModelImpl _$$ChangepasswordModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ChangepasswordModelImpl(
      status: json['status'] as String? ?? "",
      msg: json['msg'] as String? ?? "",
      model: (json['model'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$ChangepasswordModelImplToJson(
        _$ChangepasswordModelImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'msg': instance.msg,
      'model': instance.model,
    };
