import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jsaw_limited/model/changeEmail_model.dart';
import 'package:jsaw_limited/model/changepassword_model.dart';

part 'chnageEmail_state.freezed.dart';

@freezed
class ChangeEmailState with _$ChangeEmailState {
  const factory ChangeEmailState.loading(ChangeEmailModel changeEmail) = _Loading;
  const factory ChangeEmailState.content(ChangeEmailModel changeEmail) = _Content;
  const factory ChangeEmailState.success(ChangeEmailModel changeEmail, String? message) = _Success;
  const factory ChangeEmailState.failed(ChangeEmailModel changeEmail, String message) =_Failed;

  factory ChangeEmailState.initial() => const ChangeEmailState.content(ChangeEmailModel());
}