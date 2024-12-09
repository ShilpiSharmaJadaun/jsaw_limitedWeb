// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_password_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$UpdatePasswordState {
  UpdatePasswordModel get updatePassword => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(UpdatePasswordModel updatePassword) loading,
    required TResult Function(UpdatePasswordModel updatePassword) content,
    required TResult Function(
            UpdatePasswordModel updatePassword, String? message)
        success,
    required TResult Function(
            UpdatePasswordModel updatePassword, String message)
        failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(UpdatePasswordModel updatePassword)? loading,
    TResult? Function(UpdatePasswordModel updatePassword)? content,
    TResult? Function(UpdatePasswordModel updatePassword, String? message)?
        success,
    TResult? Function(UpdatePasswordModel updatePassword, String message)?
        failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(UpdatePasswordModel updatePassword)? loading,
    TResult Function(UpdatePasswordModel updatePassword)? content,
    TResult Function(UpdatePasswordModel updatePassword, String? message)?
        success,
    TResult Function(UpdatePasswordModel updatePassword, String message)?
        failed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_Content value) content,
    required TResult Function(_Success value) success,
    required TResult Function(_Failed value) failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Content value)? content,
    TResult? Function(_Success value)? success,
    TResult? Function(_Failed value)? failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Content value)? content,
    TResult Function(_Success value)? success,
    TResult Function(_Failed value)? failed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UpdatePasswordStateCopyWith<UpdatePasswordState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdatePasswordStateCopyWith<$Res> {
  factory $UpdatePasswordStateCopyWith(
          UpdatePasswordState value, $Res Function(UpdatePasswordState) then) =
      _$UpdatePasswordStateCopyWithImpl<$Res, UpdatePasswordState>;
  @useResult
  $Res call({UpdatePasswordModel updatePassword});

  $UpdatePasswordModelCopyWith<$Res> get updatePassword;
}

/// @nodoc
class _$UpdatePasswordStateCopyWithImpl<$Res, $Val extends UpdatePasswordState>
    implements $UpdatePasswordStateCopyWith<$Res> {
  _$UpdatePasswordStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? updatePassword = null,
  }) {
    return _then(_value.copyWith(
      updatePassword: null == updatePassword
          ? _value.updatePassword
          : updatePassword // ignore: cast_nullable_to_non_nullable
              as UpdatePasswordModel,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UpdatePasswordModelCopyWith<$Res> get updatePassword {
    return $UpdatePasswordModelCopyWith<$Res>(_value.updatePassword, (value) {
      return _then(_value.copyWith(updatePassword: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res>
    implements $UpdatePasswordStateCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({UpdatePasswordModel updatePassword});

  @override
  $UpdatePasswordModelCopyWith<$Res> get updatePassword;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$UpdatePasswordStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? updatePassword = null,
  }) {
    return _then(_$LoadingImpl(
      null == updatePassword
          ? _value.updatePassword
          : updatePassword // ignore: cast_nullable_to_non_nullable
              as UpdatePasswordModel,
    ));
  }
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl(this.updatePassword);

  @override
  final UpdatePasswordModel updatePassword;

  @override
  String toString() {
    return 'UpdatePasswordState.loading(updatePassword: $updatePassword)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadingImpl &&
            (identical(other.updatePassword, updatePassword) ||
                other.updatePassword == updatePassword));
  }

  @override
  int get hashCode => Object.hash(runtimeType, updatePassword);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadingImplCopyWith<_$LoadingImpl> get copyWith =>
      __$$LoadingImplCopyWithImpl<_$LoadingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(UpdatePasswordModel updatePassword) loading,
    required TResult Function(UpdatePasswordModel updatePassword) content,
    required TResult Function(
            UpdatePasswordModel updatePassword, String? message)
        success,
    required TResult Function(
            UpdatePasswordModel updatePassword, String message)
        failed,
  }) {
    return loading(updatePassword);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(UpdatePasswordModel updatePassword)? loading,
    TResult? Function(UpdatePasswordModel updatePassword)? content,
    TResult? Function(UpdatePasswordModel updatePassword, String? message)?
        success,
    TResult? Function(UpdatePasswordModel updatePassword, String message)?
        failed,
  }) {
    return loading?.call(updatePassword);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(UpdatePasswordModel updatePassword)? loading,
    TResult Function(UpdatePasswordModel updatePassword)? content,
    TResult Function(UpdatePasswordModel updatePassword, String? message)?
        success,
    TResult Function(UpdatePasswordModel updatePassword, String message)?
        failed,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(updatePassword);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_Content value) content,
    required TResult Function(_Success value) success,
    required TResult Function(_Failed value) failed,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Content value)? content,
    TResult? Function(_Success value)? success,
    TResult? Function(_Failed value)? failed,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Content value)? content,
    TResult Function(_Success value)? success,
    TResult Function(_Failed value)? failed,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements UpdatePasswordState {
  const factory _Loading(final UpdatePasswordModel updatePassword) =
      _$LoadingImpl;

  @override
  UpdatePasswordModel get updatePassword;
  @override
  @JsonKey(ignore: true)
  _$$LoadingImplCopyWith<_$LoadingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ContentImplCopyWith<$Res>
    implements $UpdatePasswordStateCopyWith<$Res> {
  factory _$$ContentImplCopyWith(
          _$ContentImpl value, $Res Function(_$ContentImpl) then) =
      __$$ContentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({UpdatePasswordModel updatePassword});

  @override
  $UpdatePasswordModelCopyWith<$Res> get updatePassword;
}

/// @nodoc
class __$$ContentImplCopyWithImpl<$Res>
    extends _$UpdatePasswordStateCopyWithImpl<$Res, _$ContentImpl>
    implements _$$ContentImplCopyWith<$Res> {
  __$$ContentImplCopyWithImpl(
      _$ContentImpl _value, $Res Function(_$ContentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? updatePassword = null,
  }) {
    return _then(_$ContentImpl(
      null == updatePassword
          ? _value.updatePassword
          : updatePassword // ignore: cast_nullable_to_non_nullable
              as UpdatePasswordModel,
    ));
  }
}

/// @nodoc

class _$ContentImpl implements _Content {
  const _$ContentImpl(this.updatePassword);

  @override
  final UpdatePasswordModel updatePassword;

  @override
  String toString() {
    return 'UpdatePasswordState.content(updatePassword: $updatePassword)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContentImpl &&
            (identical(other.updatePassword, updatePassword) ||
                other.updatePassword == updatePassword));
  }

  @override
  int get hashCode => Object.hash(runtimeType, updatePassword);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ContentImplCopyWith<_$ContentImpl> get copyWith =>
      __$$ContentImplCopyWithImpl<_$ContentImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(UpdatePasswordModel updatePassword) loading,
    required TResult Function(UpdatePasswordModel updatePassword) content,
    required TResult Function(
            UpdatePasswordModel updatePassword, String? message)
        success,
    required TResult Function(
            UpdatePasswordModel updatePassword, String message)
        failed,
  }) {
    return content(updatePassword);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(UpdatePasswordModel updatePassword)? loading,
    TResult? Function(UpdatePasswordModel updatePassword)? content,
    TResult? Function(UpdatePasswordModel updatePassword, String? message)?
        success,
    TResult? Function(UpdatePasswordModel updatePassword, String message)?
        failed,
  }) {
    return content?.call(updatePassword);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(UpdatePasswordModel updatePassword)? loading,
    TResult Function(UpdatePasswordModel updatePassword)? content,
    TResult Function(UpdatePasswordModel updatePassword, String? message)?
        success,
    TResult Function(UpdatePasswordModel updatePassword, String message)?
        failed,
    required TResult orElse(),
  }) {
    if (content != null) {
      return content(updatePassword);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_Content value) content,
    required TResult Function(_Success value) success,
    required TResult Function(_Failed value) failed,
  }) {
    return content(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Content value)? content,
    TResult? Function(_Success value)? success,
    TResult? Function(_Failed value)? failed,
  }) {
    return content?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Content value)? content,
    TResult Function(_Success value)? success,
    TResult Function(_Failed value)? failed,
    required TResult orElse(),
  }) {
    if (content != null) {
      return content(this);
    }
    return orElse();
  }
}

abstract class _Content implements UpdatePasswordState {
  const factory _Content(final UpdatePasswordModel updatePassword) =
      _$ContentImpl;

  @override
  UpdatePasswordModel get updatePassword;
  @override
  @JsonKey(ignore: true)
  _$$ContentImplCopyWith<_$ContentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SuccessImplCopyWith<$Res>
    implements $UpdatePasswordStateCopyWith<$Res> {
  factory _$$SuccessImplCopyWith(
          _$SuccessImpl value, $Res Function(_$SuccessImpl) then) =
      __$$SuccessImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({UpdatePasswordModel updatePassword, String? message});

  @override
  $UpdatePasswordModelCopyWith<$Res> get updatePassword;
}

/// @nodoc
class __$$SuccessImplCopyWithImpl<$Res>
    extends _$UpdatePasswordStateCopyWithImpl<$Res, _$SuccessImpl>
    implements _$$SuccessImplCopyWith<$Res> {
  __$$SuccessImplCopyWithImpl(
      _$SuccessImpl _value, $Res Function(_$SuccessImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? updatePassword = null,
    Object? message = freezed,
  }) {
    return _then(_$SuccessImpl(
      null == updatePassword
          ? _value.updatePassword
          : updatePassword // ignore: cast_nullable_to_non_nullable
              as UpdatePasswordModel,
      freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$SuccessImpl implements _Success {
  const _$SuccessImpl(this.updatePassword, this.message);

  @override
  final UpdatePasswordModel updatePassword;
  @override
  final String? message;

  @override
  String toString() {
    return 'UpdatePasswordState.success(updatePassword: $updatePassword, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuccessImpl &&
            (identical(other.updatePassword, updatePassword) ||
                other.updatePassword == updatePassword) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, updatePassword, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      __$$SuccessImplCopyWithImpl<_$SuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(UpdatePasswordModel updatePassword) loading,
    required TResult Function(UpdatePasswordModel updatePassword) content,
    required TResult Function(
            UpdatePasswordModel updatePassword, String? message)
        success,
    required TResult Function(
            UpdatePasswordModel updatePassword, String message)
        failed,
  }) {
    return success(updatePassword, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(UpdatePasswordModel updatePassword)? loading,
    TResult? Function(UpdatePasswordModel updatePassword)? content,
    TResult? Function(UpdatePasswordModel updatePassword, String? message)?
        success,
    TResult? Function(UpdatePasswordModel updatePassword, String message)?
        failed,
  }) {
    return success?.call(updatePassword, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(UpdatePasswordModel updatePassword)? loading,
    TResult Function(UpdatePasswordModel updatePassword)? content,
    TResult Function(UpdatePasswordModel updatePassword, String? message)?
        success,
    TResult Function(UpdatePasswordModel updatePassword, String message)?
        failed,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(updatePassword, message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_Content value) content,
    required TResult Function(_Success value) success,
    required TResult Function(_Failed value) failed,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Content value)? content,
    TResult? Function(_Success value)? success,
    TResult? Function(_Failed value)? failed,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Content value)? content,
    TResult Function(_Success value)? success,
    TResult Function(_Failed value)? failed,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _Success implements UpdatePasswordState {
  const factory _Success(
          final UpdatePasswordModel updatePassword, final String? message) =
      _$SuccessImpl;

  @override
  UpdatePasswordModel get updatePassword;
  String? get message;
  @override
  @JsonKey(ignore: true)
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FailedImplCopyWith<$Res>
    implements $UpdatePasswordStateCopyWith<$Res> {
  factory _$$FailedImplCopyWith(
          _$FailedImpl value, $Res Function(_$FailedImpl) then) =
      __$$FailedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({UpdatePasswordModel updatePassword, String message});

  @override
  $UpdatePasswordModelCopyWith<$Res> get updatePassword;
}

/// @nodoc
class __$$FailedImplCopyWithImpl<$Res>
    extends _$UpdatePasswordStateCopyWithImpl<$Res, _$FailedImpl>
    implements _$$FailedImplCopyWith<$Res> {
  __$$FailedImplCopyWithImpl(
      _$FailedImpl _value, $Res Function(_$FailedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? updatePassword = null,
    Object? message = null,
  }) {
    return _then(_$FailedImpl(
      null == updatePassword
          ? _value.updatePassword
          : updatePassword // ignore: cast_nullable_to_non_nullable
              as UpdatePasswordModel,
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$FailedImpl implements _Failed {
  const _$FailedImpl(this.updatePassword, this.message);

  @override
  final UpdatePasswordModel updatePassword;
  @override
  final String message;

  @override
  String toString() {
    return 'UpdatePasswordState.failed(updatePassword: $updatePassword, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FailedImpl &&
            (identical(other.updatePassword, updatePassword) ||
                other.updatePassword == updatePassword) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, updatePassword, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FailedImplCopyWith<_$FailedImpl> get copyWith =>
      __$$FailedImplCopyWithImpl<_$FailedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(UpdatePasswordModel updatePassword) loading,
    required TResult Function(UpdatePasswordModel updatePassword) content,
    required TResult Function(
            UpdatePasswordModel updatePassword, String? message)
        success,
    required TResult Function(
            UpdatePasswordModel updatePassword, String message)
        failed,
  }) {
    return failed(updatePassword, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(UpdatePasswordModel updatePassword)? loading,
    TResult? Function(UpdatePasswordModel updatePassword)? content,
    TResult? Function(UpdatePasswordModel updatePassword, String? message)?
        success,
    TResult? Function(UpdatePasswordModel updatePassword, String message)?
        failed,
  }) {
    return failed?.call(updatePassword, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(UpdatePasswordModel updatePassword)? loading,
    TResult Function(UpdatePasswordModel updatePassword)? content,
    TResult Function(UpdatePasswordModel updatePassword, String? message)?
        success,
    TResult Function(UpdatePasswordModel updatePassword, String message)?
        failed,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed(updatePassword, message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_Content value) content,
    required TResult Function(_Success value) success,
    required TResult Function(_Failed value) failed,
  }) {
    return failed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Content value)? content,
    TResult? Function(_Success value)? success,
    TResult? Function(_Failed value)? failed,
  }) {
    return failed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Content value)? content,
    TResult Function(_Success value)? success,
    TResult Function(_Failed value)? failed,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed(this);
    }
    return orElse();
  }
}

abstract class _Failed implements UpdatePasswordState {
  const factory _Failed(
          final UpdatePasswordModel updatePassword, final String message) =
      _$FailedImpl;

  @override
  UpdatePasswordModel get updatePassword;
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$FailedImplCopyWith<_$FailedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
