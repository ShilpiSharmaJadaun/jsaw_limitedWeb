// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginModel _$LoginModelFromJson(Map<String, dynamic> json) => LoginModel(
      empUnqId: json['empUnqId'] as String?,
      empName: json['empName'] as String?,
      fatherName: json['fatherName'] as String?,
      active: (json['active'] as num?)?.toInt(),
      desgCode: json['desgCode'] as String?,
      designationName: json['designationName'] as String?,
      deptCode: json['deptCode'] as String?,
      unitCode: json['unitCode'] as String?,
      email: json['email'] as String?,
      wrkGrp: json['wrkGrp'] as String?,
      statCode: json['statCode'] as String?,
      emailMandatorySend: (json['emailMandatorySend'] as num?)?.toInt(),
      empPassStatus: (json['empPassStatus'] as num?)?.toInt(),
      empNewPass: json['empNewPass'] as String?,
      employeesImages: json['employeesImages'] as String?,
      gradeCode: json['gradeCode'] as String?,
      hod: (json['hod'] as num?)?.toInt(),
      admin: json['admin'] as bool?,
      token: json['token'] as String?,
    );

Map<String, dynamic> _$LoginModelToJson(LoginModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('empUnqId', instance.empUnqId);
  writeNotNull('empName', instance.empName);
  writeNotNull('fatherName', instance.fatherName);
  writeNotNull('active', instance.active);
  writeNotNull('desgCode', instance.desgCode);
  writeNotNull('designationName', instance.designationName);
  writeNotNull('deptCode', instance.deptCode);
  writeNotNull('unitCode', instance.unitCode);
  writeNotNull('email', instance.email);
  writeNotNull('wrkGrp', instance.wrkGrp);
  writeNotNull('statCode', instance.statCode);
  writeNotNull('emailMandatorySend', instance.emailMandatorySend);
  writeNotNull('empPassStatus', instance.empPassStatus);
  writeNotNull('empNewPass', instance.empNewPass);
  writeNotNull('employeesImages', instance.employeesImages);
  writeNotNull('gradeCode', instance.gradeCode);
  writeNotNull('hod', instance.hod);
  writeNotNull('admin', instance.admin);
  writeNotNull('token', instance.token);
  return val;
}
