import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jsaw_limited/model/employeeResponsibility_model.dart';
import 'package:jsaw_limited/model/employeefromAppReporting_model.dart';

part 'employeeAppReporting_state.freezed.dart';

@freezed
class EmployeeFromAppReportingState with _$EmployeeFromAppReportingState{

  const factory EmployeeFromAppReportingState.loading (List<EmployeeFromAppReportingModel> appReporting) = _Loading;
  const factory EmployeeFromAppReportingState.content (List<EmployeeFromAppReportingModel> appReporting) = _Content;
  const factory EmployeeFromAppReportingState.success (List<EmployeeFromAppReportingModel> appReporting) = _Success;
  const factory EmployeeFromAppReportingState.failed (List<EmployeeFromAppReportingModel> appReporting, String msg) = _Failed;

  factory EmployeeFromAppReportingState.initial() => EmployeeFromAppReportingState.content([]);

}