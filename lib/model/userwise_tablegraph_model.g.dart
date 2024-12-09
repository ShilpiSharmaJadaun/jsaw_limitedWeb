// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userwise_tablegraph_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserWiseTableGraphModelImpl _$$UserWiseTableGraphModelImplFromJson(
        Map<String, dynamic> json) =>
    _$UserWiseTableGraphModelImpl(
      empUnqId: json['empUnqId'] as String? ?? "",
      empName: json['empName'] as String? ?? "",
      totalRaised: (json['totalRaised'] as num?)?.toInt() ?? 0,
      totalReceived: (json['totalReceived'] as num?)?.toInt() ?? 0,
      totalPendingRaised: (json['totalPendingRaised'] as num?)?.toInt() ?? 0,
      totalClosedRaised: (json['totalClosedRaised'] as num?)?.toInt() ?? 0,
      designationCode: json['designationCode'] as String? ?? "",
      designationName: json['designationName'] as String? ?? "",
      departmentName: json['departmentName'] as String? ?? "",
    );

Map<String, dynamic> _$$UserWiseTableGraphModelImplToJson(
        _$UserWiseTableGraphModelImpl instance) =>
    <String, dynamic>{
      'empUnqId': instance.empUnqId,
      'empName': instance.empName,
      'totalRaised': instance.totalRaised,
      'totalReceived': instance.totalReceived,
      'totalPendingRaised': instance.totalPendingRaised,
      'totalClosedRaised': instance.totalClosedRaised,
      'designationCode': instance.designationCode,
      'designationName': instance.designationName,
      'departmentName': instance.departmentName,
    };
