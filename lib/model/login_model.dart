import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_model.g.dart';

@JsonSerializable(includeIfNull: false)
class LoginModel {
  late final String? empUnqId;
  late final String? empName;
  late final String? fatherName;
  late final int? active;
  late final String? desgCode;
  late final String? deptCode;
  late final String? unitCode;
  late final String? email;
  late final String? wrkGrp;
  late final String? statCode;
  late final int? emailMandatorySend;
  late final int? empPassStatus;
  late final String? empNewPass;
  late final String? employeesImages;
  late final String? gradeCode;
  late final int? hod;
  late final bool? admin;

  LoginModel({
    this.empUnqId,
    this.empName,
    this.fatherName,
    this.active,
    this.desgCode,
    this.deptCode,
    this.unitCode,
    this.email,
    this.wrkGrp,
    this.statCode,
    this.emailMandatorySend,
    this.empPassStatus,
    this.empNewPass,
    this.employeesImages,
    this.gradeCode,
    this.hod,
    this.admin,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) =>
      _$LoginModelFromJson(json);
  Map<String, dynamic> toJson() => _$LoginModelToJson(this);

  static LoginModel? fromJsonString(String jsonString) {
    Map<String, dynamic> json = jsonDecode(jsonString);
    return LoginModel.fromJson(json);
  }

  String toJsonString() {
    Map<String, dynamic> json = toJson();
    return jsonEncode(json);
  }
}
