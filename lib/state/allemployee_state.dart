import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jsaw_limited/model/allemployee_model.dart';

part 'allemployee_state.freezed.dart';

@freezed
class AllEmployeeState with _$AllEmployeeState{

  const factory AllEmployeeState.loading (List<AllEmployeeModel> allemployee) = _Loading;
  const factory AllEmployeeState.content (List<AllEmployeeModel> allemployee) = _Content;
  const factory AllEmployeeState.success (List<AllEmployeeModel> allemployee) = _Success;
  const factory AllEmployeeState.failed (List<AllEmployeeModel> allemployee, String msg) = _Failed;

  factory AllEmployeeState.initial() => AllEmployeeState.content([]);

}