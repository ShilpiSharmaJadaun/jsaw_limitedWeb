import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jsaw_limited/model/changepassword_model.dart';

part 'changepassword_state.freezed.dart';

@freezed
class ChangepasswordState with _$ChangepasswordState {
  const factory ChangepasswordState.loading(ChangepasswordModel changePassword) = _Loading;
  const factory ChangepasswordState.content(ChangepasswordModel changePassword) = _Content;
  const factory ChangepasswordState.success(ChangepasswordModel changePassword, String? message) = _Success;
  const factory ChangepasswordState.failed(ChangepasswordModel changePassword, String message) =_Failed;

  factory ChangepasswordState.initial() => const ChangepasswordState.content(ChangepasswordModel());
}