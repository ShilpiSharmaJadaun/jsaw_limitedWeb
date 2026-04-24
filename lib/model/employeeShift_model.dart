import 'package:freezed_annotation/freezed_annotation.dart';

part 'employeeShift_model.g.dart';
part 'employeeShift_model.freezed.dart';

@freezed
class EmployeeShiftModel with _$EmployeeShiftModel{
  const factory EmployeeShiftModel({

    @Default("") String shiftCode,
    @Default(0) int shiftSeq,
    @Default("") String shiftDesc,


  }) = _EmployeeShiftModel;

  factory EmployeeShiftModel.fromJson(Map<String, dynamic> json) => _$EmployeeShiftModelFromJson(json);
}