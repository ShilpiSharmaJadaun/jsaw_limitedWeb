import 'package:freezed_annotation/freezed_annotation.dart';

part 'generateExcel_model.g.dart';
part 'generateExcel_model.freezed.dart';

@freezed
class GenerateExcelModel with _$GenerateExcelModel{
  const factory GenerateExcelModel({

    @Default("") String url,

  }) = _GenerateExcelModel;

  factory GenerateExcelModel.fromJson(Map<String, dynamic> json) => _$GenerateExcelModelFromJson(json);
}