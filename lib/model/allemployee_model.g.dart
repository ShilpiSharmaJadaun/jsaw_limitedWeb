// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'allemployee_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AllEmployeeModelImpl _$$AllEmployeeModelImplFromJson(
        Map<String, dynamic> json) =>
    _$AllEmployeeModelImpl(
      empUnqId: json['empUnqId'] as String? ?? "",
      empName: json['empName'] as String? ?? "",
      fatherName: json['fatherName'] as String? ?? "",
      active: (json['active'] as num?)?.toInt() ?? 0,
      desgCode: json['desgCode'] as String? ?? "",
      deptCode: json['deptCode'] as String? ?? "",
      unitCode: json['unitCode'] as String? ?? "",
      email: json['email'] as String? ?? "",
      wrkGrp: json['wrkGrp'] as String? ?? "",
      statCode: json['statCode'] as String? ?? "",
      emailMandatorySend: (json['emailMandatorySend'] as num?)?.toInt() ?? 0,
      empPassStatus: (json['empPassStatus'] as num?)?.toInt() ?? 0,
      empNewPass: json['empNewPass'] as String? ?? "",
      excludeEmp: (json['excludeEmp'] as num?)?.toInt() ?? 0,
      catCode: json['catCode'] as String? ?? "",
      gradeCode: json['gradeCode'] as String? ?? "",
      hod: (json['hod'] as num?)?.toInt() ?? 0,
      employeesImages: json['employeesImages'] as String? ?? "",
      employeeAuthorizationForPlantUnitHead:
          (json['employeeAuthorizationForPlantUnitHead'] as num?)?.toInt() ?? 0,
      admin: json['admin'] as bool? ?? false,
      hseteamAuthorization:
          (json['hseteamAuthorization'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$AllEmployeeModelImplToJson(
        _$AllEmployeeModelImpl instance) =>
    <String, dynamic>{
      'empUnqId': instance.empUnqId,
      'empName': instance.empName,
      'fatherName': instance.fatherName,
      'active': instance.active,
      'desgCode': instance.desgCode,
      'deptCode': instance.deptCode,
      'unitCode': instance.unitCode,
      'email': instance.email,
      'wrkGrp': instance.wrkGrp,
      'statCode': instance.statCode,
      'emailMandatorySend': instance.emailMandatorySend,
      'empPassStatus': instance.empPassStatus,
      'empNewPass': instance.empNewPass,
      'excludeEmp': instance.excludeEmp,
      'catCode': instance.catCode,
      'gradeCode': instance.gradeCode,
      'hod': instance.hod,
      'employeesImages': instance.employeesImages,
      'employeeAuthorizationForPlantUnitHead':
          instance.employeeAuthorizationForPlantUnitHead,
      'admin': instance.admin,
      'hseteamAuthorization': instance.hseteamAuthorization,
    };
