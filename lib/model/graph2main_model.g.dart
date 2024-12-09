// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'graph2main_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$Graph2MainModelImpl _$$Graph2MainModelImplFromJson(
        Map<String, dynamic> json) =>
    _$Graph2MainModelImpl(
      totalPages: (json['totalPages'] as num?)?.toInt() ?? 0,
      totalItems: (json['totalItems'] as num?)?.toInt() ?? 0,
      currentPage: (json['currentPage'] as num?)?.toInt() ?? 0,
      msg: json['msg'] as String? ?? '',
      sessionID: json['sessionID'] as String? ?? '',
      status: json['status'] as bool? ?? false,
      model: (json['model'] as List<dynamic>?)
              ?.map((e) => Graph2Model.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <Graph2Model>[],
    );

Map<String, dynamic> _$$Graph2MainModelImplToJson(
        _$Graph2MainModelImpl instance) =>
    <String, dynamic>{
      'totalPages': instance.totalPages,
      'totalItems': instance.totalItems,
      'currentPage': instance.currentPage,
      'msg': instance.msg,
      'sessionID': instance.sessionID,
      'status': instance.status,
      'model': instance.model,
    };
