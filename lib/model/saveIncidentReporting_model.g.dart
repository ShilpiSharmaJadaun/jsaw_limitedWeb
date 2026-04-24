// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saveIncidentReporting_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SaveIncidentReportingModelImpl _$$SaveIncidentReportingModelImplFromJson(
        Map<String, dynamic> json) =>
    _$SaveIncidentReportingModelImpl(
      status: json['status'] as String? ?? "",
      error: json['error'] as String? ?? "",
      path: json['path'] as String? ?? "",
    );

Map<String, dynamic> _$$SaveIncidentReportingModelImplToJson(
        _$SaveIncidentReportingModelImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'error': instance.error,
      'path': instance.path,
    };
