import 'package:freezed_annotation/freezed_annotation.dart';

part 'employeeBasicDetail_model.g.dart';
part 'employeeBasicDetail_model.freezed.dart';

@freezed
class EmployeeBasicDetailModel with _$EmployeeBasicDetailModel{
  const factory EmployeeBasicDetailModel({
    @Default("") String empCode,
    @Default("") String empName,
    @Default("") String statCode,
    @Default("") String statName,
    @Default("") String deptCode,
    @Default("") String deptName,
    @Default("") String gradeCode,
    @Default(0) int age,
    @Default("") String contCode,
    @Default("") String contName,
  }) = _EmployeeBasicDetailModel;

  factory EmployeeBasicDetailModel.fromJson(Map<String, dynamic> json) => _$EmployeeBasicDetailModelFromJson(json);
}