import 'package:freezed_annotation/freezed_annotation.dart';

part 'changeEmail_model.g.dart';
part 'changeEmail_model.freezed.dart';

@freezed
class ChangeEmailModel with _$ChangeEmailModel{
  const factory ChangeEmailModel({
    @Default("") String status,
    @Default("") String msg,
    @Default(0) int model,
  }) = _ChangeEmailModel;

  factory ChangeEmailModel.fromJson(Map<String, dynamic> json) => _$ChangeEmailModelFromJson(json);
}