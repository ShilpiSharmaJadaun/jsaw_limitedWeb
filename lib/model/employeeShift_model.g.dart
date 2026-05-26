// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employeeShift_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EmployeeShiftModelImpl _$$EmployeeShiftModelImplFromJson(
        Map<String, dynamic> json) =>
    _$EmployeeShiftModelImpl(
      shiftCode: json['shiftCode'] as String? ?? "",
      shiftSeq: (json['shiftSeq'] as num?)?.toInt() ?? 0,
      shiftDesc: json['shiftDesc'] as String? ?? "",
      shiftStart: json['shiftStart'] as String? ?? "",
      shiftEnd: json['shiftEnd'] as String? ?? "",
    );

Map<String, dynamic> _$$EmployeeShiftModelImplToJson(
        _$EmployeeShiftModelImpl instance) =>
    <String, dynamic>{
      'shiftCode': instance.shiftCode,
      'shiftSeq': instance.shiftSeq,
      'shiftDesc': instance.shiftDesc,
      'shiftStart': instance.shiftStart,
      'shiftEnd': instance.shiftEnd,
    };
