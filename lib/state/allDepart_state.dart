import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jsaw_limited/model/allDepartment_model.dart';

part 'allDepart_state.freezed.dart';

@freezed
class AllDepartState with _$AllDepartState{

  const factory AllDepartState.loading (List<AllDepartmentModel> allDepartModel) = _Loading;
  const factory AllDepartState.content (List<AllDepartmentModel> allDepartModel) = _Content;
  const factory AllDepartState.success (List<AllDepartmentModel> allDepartModel) = _Success;
  const factory AllDepartState.failed (List<AllDepartmentModel> allDepartModel, String msg) = _Failed;

  factory AllDepartState.initial() => AllDepartState.content([]);

}