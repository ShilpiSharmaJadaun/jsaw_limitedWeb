// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'graph2_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$Graph2ModelImpl _$$Graph2ModelImplFromJson(Map<String, dynamic> json) =>
    _$Graph2ModelImpl(
      plantDept: json['plantDept'] as String? ?? '',
      plantDeptCode: json['plantDeptCode'] as String? ?? '',
      totalCount: json['totalCount'] as String? ?? '',
      stations: (json['stations'] as List<dynamic>?)
              ?.map(
                  (e) => Graph2StationModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <Graph2StationModel>[],
    );

Map<String, dynamic> _$$Graph2ModelImplToJson(_$Graph2ModelImpl instance) =>
    <String, dynamic>{
      'plantDept': instance.plantDept,
      'plantDeptCode': instance.plantDeptCode,
      'totalCount': instance.totalCount,
      'stations': instance.stations,
    };
