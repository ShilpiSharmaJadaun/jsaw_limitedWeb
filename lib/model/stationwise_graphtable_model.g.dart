// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stationwise_graphtable_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StationWiseGraphTableModelImpl _$$StationWiseGraphTableModelImplFromJson(
        Map<String, dynamic> json) =>
    _$StationWiseGraphTableModelImpl(
      stationName: json['stationName'] as String? ?? "",
      totalRaised: (json['totalRaised'] as num?)?.toInt() ?? 0,
      totalReceived: (json['totalReceived'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$StationWiseGraphTableModelImplToJson(
        _$StationWiseGraphTableModelImpl instance) =>
    <String, dynamic>{
      'stationName': instance.stationName,
      'totalRaised': instance.totalRaised,
      'totalReceived': instance.totalReceived,
    };
