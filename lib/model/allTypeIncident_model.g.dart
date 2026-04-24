// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'allTypeIncident_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AllTypeIncidentModelImpl _$$AllTypeIncidentModelImplFromJson(
        Map<String, dynamic> json) =>
    _$AllTypeIncidentModelImpl(
      id: (json['id'] as num?)?.toInt() ?? 0,
      description: json['description'] as String? ?? "",
    );

Map<String, dynamic> _$$AllTypeIncidentModelImplToJson(
        _$AllTypeIncidentModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
    };
