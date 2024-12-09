import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jsaw_limited/model/generateExcel_model.dart';

part 'generateExcel_state.freezed.dart';

@freezed
class GenerateExcelState with _$GenerateExcelState{

  const factory GenerateExcelState.loading (GenerateExcelModel generateExcel) = _Loading;
  const factory GenerateExcelState.content (GenerateExcelModel generateExcel) = _Content;
  const factory GenerateExcelState.success (GenerateExcelModel generateExcel, String? url) = _Success;
  const factory GenerateExcelState.failed (GenerateExcelModel generateExcel, String msg) = _Failed;

  factory GenerateExcelState.initial() => GenerateExcelState.content(GenerateExcelModel());

}