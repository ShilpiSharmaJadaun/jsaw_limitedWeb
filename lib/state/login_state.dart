import 'package:freezed_annotation/freezed_annotation.dart';
import '../model/login_model.dart';

part 'login_state.freezed.dart';

@freezed
class LoginState with _$LoginState{
  const factory LoginState.loading(LoginModel loginModel) = _Loading;
  const factory LoginState.content(LoginModel loginModel) = _Content;
  const factory LoginState.success(LoginModel loginModel) = _Success;
  const factory LoginState.failed(LoginModel loginModel, String msg) = _failed;

  factory LoginState.initial() => LoginState.content(LoginModel());
}