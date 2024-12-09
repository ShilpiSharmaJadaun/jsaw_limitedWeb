import 'package:freezed_annotation/freezed_annotation.dart';

part 'employeeResponsibility_model.g.dart';
part 'employeeResponsibility_model.freezed.dart';

@freezed
class EmployeeResponsibilityModel with _$EmployeeResponsibilityModel{
  const factory EmployeeResponsibilityModel({

    @Default("") String empUnqId,
    @Default("") String empName,
    @Default("") String fatherName,
    @Default(0) int active,
    @Default("") String gradeCode,
    @Default("") String deptCode,
    @Default("") String unitCode,
    @Default("") String email,
    @Default("") String wrkGrp,
    @Default("") String statCode,
    @Default("") String employeesImages,
    @Default(0) int hod,
    @Default(false) bool admin,

  }) = _EmployeeResponsibilityModel;

  factory EmployeeResponsibilityModel.fromJson(Map<String, dynamic> json) => _$EmployeeResponsibilityModelFromJson(json);
}