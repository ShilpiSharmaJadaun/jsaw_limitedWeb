import 'package:freezed_annotation/freezed_annotation.dart';

part 'updateHod_model.g.dart';
part 'updateHod_model.freezed.dart';

@freezed
class UpdateHodModel with _$UpdateHodModel{
  const factory UpdateHodModel({
    @Default("") String status,
    @Default("") String message,
  }) = _UpdateHodModel;

  factory UpdateHodModel.fromJson(Map<String, dynamic> json) => _$UpdateHodModelFromJson(json);
}