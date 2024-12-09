import 'package:freezed_annotation/freezed_annotation.dart';

part 'allemployee_model.g.dart';
part 'allemployee_model.freezed.dart';

@freezed
class AllEmployeeModel with _$AllEmployeeModel{
  const factory AllEmployeeModel({

    @Default("") String empUnqId,
    @Default("") String empName,
    @Default("") String fatherName,
    @Default(0) int active,
    @Default("") String desgCode,
    @Default("") String deptCode,
    @Default("") String unitCode,
    @Default("") String email,
    @Default("") String wrkGrp,
    @Default("") String statCode,
    @Default(0) int emailMandatorySend,
    @Default(0) int empPassStatus,
    @Default("") String empNewPass,
    @Default(0) int excludeEmp,
    @Default("") String catCode,
    @Default("") String gradeCode,
    @Default(0) int hod,
    @Default("") String employeesImages,
    @Default(0) int employeeAuthorizationForPlantUnitHead,
    @Default(false) bool admin,
    @Default(0) int hseteamAuthorization,

  }) = _AllEmployeeModel;

  factory AllEmployeeModel.fromJson(Map<String, dynamic> json) => _$AllEmployeeModelFromJson(json);
}