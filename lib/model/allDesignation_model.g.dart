// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'allDesignation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AllDesignationModelImpl _$$AllDesignationModelImplFromJson(
        Map<String, dynamic> json) =>
    _$AllDesignationModelImpl(
      designation_code: json['designation_code'] as String? ?? "",
      designation_name: json['designation_name'] as String? ?? "",
      wrkGrp: json['wrkGrp'] as String? ?? "",
    );

Map<String, dynamic> _$$AllDesignationModelImplToJson(
        _$AllDesignationModelImpl instance) =>
    <String, dynamic>{
      'designation_code': instance.designation_code,
      'designation_name': instance.designation_name,
      'wrkGrp': instance.wrkGrp,
    };
