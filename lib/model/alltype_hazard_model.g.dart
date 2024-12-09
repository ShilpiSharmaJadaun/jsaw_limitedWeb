// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alltype_hazard_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AllTypeHazardModelImpl _$$AllTypeHazardModelImplFromJson(
        Map<String, dynamic> json) =>
    _$AllTypeHazardModelImpl(
      id: (json['id'] as num?)?.toInt() ?? 0,
      categoryName: json['categoryName'] as String? ?? "",
    );

Map<String, dynamic> _$$AllTypeHazardModelImplToJson(
        _$AllTypeHazardModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'categoryName': instance.categoryName,
    };
