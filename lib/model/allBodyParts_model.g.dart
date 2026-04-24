// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'allBodyParts_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AllBodyPartsModelImpl _$$AllBodyPartsModelImplFromJson(
        Map<String, dynamic> json) =>
    _$AllBodyPartsModelImpl(
      id: (json['id'] as num?)?.toInt() ?? 0,
      description: json['description'] as String? ?? "",
    );

Map<String, dynamic> _$$AllBodyPartsModelImplToJson(
        _$AllBodyPartsModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
    };
