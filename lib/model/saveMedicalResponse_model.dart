import 'package:freezed_annotation/freezed_annotation.dart';

part 'saveMedicalResponse_model.g.dart';
part 'saveMedicalResponse_model.freezed.dart';

@freezed
class SaveMedicalResponseModel with _$SaveMedicalResponseModel{
  const factory SaveMedicalResponseModel({

    @Default("") String status,
    @Default("") String msg,

  }) = _SaveMedicalResponseModel;

  factory SaveMedicalResponseModel.fromJson(Map<String, dynamic> json) => _$SaveMedicalResponseModelFromJson(json);
}