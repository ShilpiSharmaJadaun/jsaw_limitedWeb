import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jsaw_limited/model/update_password_model.dart';


part 'update_password_state.freezed.dart';

@freezed
class UpdatePasswordState with _$UpdatePasswordState {
  const factory UpdatePasswordState.loading(UpdatePasswordModel updatePassword) = _Loading;
  const factory UpdatePasswordState.content(UpdatePasswordModel updatePassword) = _Content;
  const factory UpdatePasswordState.success(UpdatePasswordModel updatePassword, String? message) = _Success;
  const factory UpdatePasswordState.failed(UpdatePasswordModel updatePassword, String message) =_Failed;

  factory UpdatePasswordState.initial() => const UpdatePasswordState.content(UpdatePasswordModel());
}