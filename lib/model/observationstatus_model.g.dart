// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'observationstatus_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ObservationStatusModelImpl _$$ObservationStatusModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ObservationStatusModelImpl(
      closed: (json['closed'] as num?)?.toInt() ?? 0,
      pending: (json['pending'] as num?)?.toInt() ?? 0,
      inProgress: (json['inProgress'] as num?)?.toInt() ?? 0,
      alls: (json['alls'] as num?)?.toInt() ?? 0,
      compliance: (json['compliance'] as num?)?.toInt() ?? 0,
      closedPercentage: (json['closedPercentage'] as num?)?.toDouble() ?? 0.0,
      pendingPercentage: (json['pendingPercentage'] as num?)?.toDouble() ?? 0.0,
      inProgressPercentage:
          (json['inProgressPercentage'] as num?)?.toDouble() ?? 0.0,
      compliancePercentage:
          (json['compliancePercentage'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$$ObservationStatusModelImplToJson(
        _$ObservationStatusModelImpl instance) =>
    <String, dynamic>{
      'closed': instance.closed,
      'pending': instance.pending,
      'inProgress': instance.inProgress,
      'alls': instance.alls,
      'compliance': instance.compliance,
      'closedPercentage': instance.closedPercentage,
      'pendingPercentage': instance.pendingPercentage,
      'inProgressPercentage': instance.inProgressPercentage,
      'compliancePercentage': instance.compliancePercentage,
    };
