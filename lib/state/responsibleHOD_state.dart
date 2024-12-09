import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jsaw_limited/model/employeeResponsibility_model.dart';

part 'responsibleHOD_state.freezed.dart';

@freezed
class ResponsibleHODState with _$ResponsibleHODState{

  const factory ResponsibleHODState.loading (List<EmployeeResponsibilityModel> responsibility) = _Loading;
  const factory ResponsibleHODState.content (List<EmployeeResponsibilityModel> responsibility) = _Content;
  const factory ResponsibleHODState.success (List<EmployeeResponsibilityModel> responsibility) = _Success;
  const factory ResponsibleHODState.failed (List<EmployeeResponsibilityModel> responsibility, String msg) = _Failed;

  factory ResponsibleHODState.initial() => ResponsibleHODState.content([]);

}