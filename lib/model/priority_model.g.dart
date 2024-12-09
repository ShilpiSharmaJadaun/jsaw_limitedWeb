// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'priority_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PriorityModelImpl _$$PriorityModelImplFromJson(Map<String, dynamic> json) =>
    _$PriorityModelImpl(
      id: (json['id'] as num?)?.toInt() ?? 0,
      priorityStatusName: json['priorityStatusName'] as String? ?? "",
      priorityStatusColour: json['priorityStatusColour'] as String? ?? "",
      priorityStatusDeadline: json['priorityStatusDeadline'] as String? ?? "",
    );

Map<String, dynamic> _$$PriorityModelImplToJson(_$PriorityModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'priorityStatusName': instance.priorityStatusName,
      'priorityStatusColour': instance.priorityStatusColour,
      'priorityStatusDeadline': instance.priorityStatusDeadline,
    };
