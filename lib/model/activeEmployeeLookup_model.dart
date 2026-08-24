import 'package:freezed_annotation/freezed_annotation.dart';

part 'activeEmployeeLookup_model.g.dart';
part 'activeEmployeeLookup_model.freezed.dart';

/// One ACTIVE employee with station / grade / designation names already
/// resolved by the backend (`employees/getActiveEmployeeLookup`).
/// Used by pickers that must show only active employees and auto-populate
/// their details (Investigation "Root Cause – Inquired With", point 6).
@freezed
class ActiveEmployeeLookupModel with _$ActiveEmployeeLookupModel {
  const factory ActiveEmployeeLookupModel({
    @Default("") String empUnqId,
    @Default("") String empName,
    @Default("") String wrkGrp,
    @Default("") String deptCode,
    @Default("") String statCode,
    @Default("") String statName,
    @Default("") String gradeCode,
    @Default("") String gradeName,
    @Default("") String desgCode,
    @Default("") String desgName,
  }) = _ActiveEmployeeLookupModel;

  factory ActiveEmployeeLookupModel.fromJson(Map<String, dynamic> json) =>
      _$ActiveEmployeeLookupModelFromJson(json);
}
