// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employeeBasicDetail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EmployeeBasicDetailModelImpl _$$EmployeeBasicDetailModelImplFromJson(
        Map<String, dynamic> json) =>
    _$EmployeeBasicDetailModelImpl(
      empCode: json['empCode'] as String? ?? "",
      empName: json['empName'] as String? ?? "",
      statCode: json['statCode'] as String? ?? "",
      statName: json['statName'] as String? ?? "",
      deptCode: json['deptCode'] as String? ?? "",
      deptName: json['deptName'] as String? ?? "",
      gradeCode: json['gradeCode'] as String? ?? "",
      age: (json['age'] as num?)?.toInt() ?? 0,
      contCode: json['contCode'] as String? ?? "",
      contName: json['contName'] as String? ?? "",
      wrkGrp: json['wrkGrp'] as String? ?? "",
    );

Map<String, dynamic> _$$EmployeeBasicDetailModelImplToJson(
        _$EmployeeBasicDetailModelImpl instance) =>
    <String, dynamic>{
      'empCode': instance.empCode,
      'empName': instance.empName,
      'statCode': instance.statCode,
      'statName': instance.statName,
      'deptCode': instance.deptCode,
      'deptName': instance.deptName,
      'gradeCode': instance.gradeCode,
      'age': instance.age,
      'contCode': instance.contCode,
      'contName': instance.contName,
      'wrkGrp': instance.wrkGrp,
    };
