import 'package:freezed_annotation/freezed_annotation.dart';

part 'saveSafetyRemarkResponse_model.g.dart';
part 'saveSafetyRemarkResponse_model.freezed.dart';

@freezed
class SafetyRemarkResponseModel with _$SafetyRemarkResponseModel{
  const factory SafetyRemarkResponseModel({

    @Default("") String status,
    @Default("") String msg,

  }) = _SafetyRemarkResponseModel;

  factory SafetyRemarkResponseModel.fromJson(Map<String, dynamic> json) => _$SafetyRemarkResponseModelFromJson(json);
}