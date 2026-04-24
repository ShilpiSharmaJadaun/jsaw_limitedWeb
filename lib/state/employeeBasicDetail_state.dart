import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jsaw_limited/model/employeeBasicDetail_model.dart';
import 'package:jsaw_limited/model/employeeResponsibility_model.dart';
import 'package:jsaw_limited/model/employeefromAppReporting_model.dart';

part 'employeeBasicDetail_state.freezed.dart';

@freezed
class EmployeeBasicDetailState with _$EmployeeBasicDetailState{

  const factory EmployeeBasicDetailState.loading (List<EmployeeBasicDetailModel> appReporting) = _Loading;
  const factory EmployeeBasicDetailState.content (List<EmployeeBasicDetailModel> appReporting) = _Content;
  const factory EmployeeBasicDetailState.success (List<EmployeeBasicDetailModel> appReporting) = _Success;
  const factory EmployeeBasicDetailState.failed (List<EmployeeBasicDetailModel> appReporting, String msg) = _Failed;

  factory EmployeeBasicDetailState.initial() => EmployeeBasicDetailState.content([]);

}