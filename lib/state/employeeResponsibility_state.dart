import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jsaw_limited/model/employeeResponsibility_model.dart';

part 'employeeResponsibility_state.freezed.dart';

@freezed
class EmployeeResponsibilityState with _$EmployeeResponsibilityState{

  const factory EmployeeResponsibilityState.loading (List<EmployeeResponsibilityModel> responsibility) = _Loading;
  const factory EmployeeResponsibilityState.content (List<EmployeeResponsibilityModel> responsibility) = _Content;
  const factory EmployeeResponsibilityState.success (List<EmployeeResponsibilityModel> responsibility) = _Success;
  const factory EmployeeResponsibilityState.failed (List<EmployeeResponsibilityModel> responsibility, String msg) = _Failed;

  factory EmployeeResponsibilityState.initial() => EmployeeResponsibilityState.content([]);

}