// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employeeResponsibility_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EmployeeResponsibilityModelImpl _$$EmployeeResponsibilityModelImplFromJson(
        Map<String, dynamic> json) =>
    _$EmployeeResponsibilityModelImpl(
      empUnqId: json['empUnqId'] as String? ?? "",
      empName: json['empName'] as String? ?? "",
      fatherName: json['fatherName'] as String? ?? "",
      active: (json['active'] as num?)?.toInt() ?? 0,
      gradeCode: json['gradeCode'] as String? ?? "",
      deptCode: json['deptCode'] as String? ?? "",
      unitCode: json['unitCode'] as String? ?? "",
      email: json['email'] as String? ?? "",
      wrkGrp: json['wrkGrp'] as String? ?? "",
      statCode: json['statCode'] as String? ?? "",
      employeesImages: json['employeesImages'] as String? ?? "",
      hod: (json['hod'] as num?)?.toInt() ?? 0,
      admin: json['admin'] as bool? ?? false,
    );

Map<String, dynamic> _$$EmployeeResponsibilityModelImplToJson(
        _$EmployeeResponsibilityModelImpl instance) =>
    <String, dynamic>{
      'empUnqId': instance.empUnqId,
      'empName': instance.empName,
      'fatherName': instance.fatherName,
      'active': instance.active,
      'gradeCode': instance.gradeCode,
      'deptCode': instance.deptCode,
      'unitCode': instance.unitCode,
      'email': instance.email,
      'wrkGrp': instance.wrkGrp,
      'statCode': instance.statCode,
      'employeesImages': instance.employeesImages,
      'hod': instance.hod,
      'admin': instance.admin,
    };
