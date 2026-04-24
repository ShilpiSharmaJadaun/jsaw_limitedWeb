import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jsaw_limited/model/employeeBasicDetail_model.dart';
import 'package:jsaw_limited/model/employeeResponsibility_model.dart';
import 'package:jsaw_limited/model/employeeShift_model.dart';
import 'package:jsaw_limited/model/employeefromAppReporting_model.dart';

part 'employeeShift_state.freezed.dart';

@freezed
class EmployeeShiftState with _$EmployeeShiftState{

  const factory EmployeeShiftState.loading (List<EmployeeShiftModel> employeeShift) = _Loading;
  const factory EmployeeShiftState.content (List<EmployeeShiftModel> employeeShift) = _Content;
  const factory EmployeeShiftState.success (List<EmployeeShiftModel> employeeShift) = _Success;
  const factory EmployeeShiftState.failed (List<EmployeeShiftModel> employeeShift, String msg) = _Failed;

  factory EmployeeShiftState.initial() => EmployeeShiftState.content([]);

}