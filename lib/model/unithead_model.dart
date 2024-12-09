import 'package:freezed_annotation/freezed_annotation.dart';

part 'unithead_model.g.dart';
part 'unithead_model.freezed.dart';

@freezed
class UnitHeadModel with _$UnitHeadModel{
  const factory UnitHeadModel({

    @Default("") String unitPlantCode,
    @Default("") String unitPlantName,
    @Default("") String unitEmpName,
    @Default("") String unitEmpUnqId,
    @Default("") String unitEmpEmail,

  }) = _UnitHeadModel;

  factory UnitHeadModel.fromJson(Map<String, dynamic> json) => _$UnitHeadModelFromJson(json);
}