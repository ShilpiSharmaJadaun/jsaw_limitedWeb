// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activeEmployeeLookup_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ActiveEmployeeLookupModelImpl _$$ActiveEmployeeLookupModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ActiveEmployeeLookupModelImpl(
      empUnqId: json['empUnqId'] as String? ?? "",
      empName: json['empName'] as String? ?? "",
      wrkGrp: json['wrkGrp'] as String? ?? "",
      deptCode: json['deptCode'] as String? ?? "",
      statCode: json['statCode'] as String? ?? "",
      statName: json['statName'] as String? ?? "",
      gradeCode: json['gradeCode'] as String? ?? "",
      gradeName: json['gradeName'] as String? ?? "",
      desgCode: json['desgCode'] as String? ?? "",
      desgName: json['desgName'] as String? ?? "",
    );

Map<String, dynamic> _$$ActiveEmployeeLookupModelImplToJson(
        _$ActiveEmployeeLookupModelImpl instance) =>
    <String, dynamic>{
      'empUnqId': instance.empUnqId,
      'empName': instance.empName,
      'wrkGrp': instance.wrkGrp,
      'deptCode': instance.deptCode,
      'statCode': instance.statCode,
      'statName': instance.statName,
      'gradeCode': instance.gradeCode,
      'gradeName': instance.gradeName,
      'desgCode': instance.desgCode,
      'desgName': instance.desgName,
    };
