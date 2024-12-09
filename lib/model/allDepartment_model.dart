import 'package:freezed_annotation/freezed_annotation.dart';

part 'allDepartment_model.g.dart';
part 'allDepartment_model.freezed.dart';

@freezed
class AllDepartmentModel with _$AllDepartmentModel{
  const factory AllDepartmentModel({

    @Default("") String wrkGrp,
    @Default("") String deptCode,
    @Default("") String statCode,
    @Default("") String statName,

  }) = _AllDepartmentModel;

  factory AllDepartmentModel.fromJson(Map<String, dynamic> json) => _$AllDepartmentModelFromJson(json);
}