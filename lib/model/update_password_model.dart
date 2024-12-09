import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_password_model.g.dart';
part 'update_password_model.freezed.dart';

@freezed
class UpdatePasswordModel with _$UpdatePasswordModel{
  const factory UpdatePasswordModel({
    @Default("") String status,
    @Default("") String msg,
  }) = _UpdatePasswordModel;

  factory UpdatePasswordModel.fromJson(Map<String, dynamic> json) => _$UpdatePasswordModelFromJson(json);
}