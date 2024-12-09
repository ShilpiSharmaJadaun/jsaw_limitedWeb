// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'userwise_table_export_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$UserWiseTableExportState {
  UserWiseTableExport get userWiseTableExport =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(UserWiseTableExport userWiseTableExport) loading,
    required TResult Function(UserWiseTableExport userWiseTableExport) content,
    required TResult Function(
            UserWiseTableExport userWiseTableExport, String? url)
        success,
    required TResult Function(
            UserWiseTableExport userWiseTableExport, String message)
        failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(UserWiseTableExport userWiseTableExport)? loading,
    TResult? Function(UserWiseTableExport userWiseTableExport)? content,
    TResult? Function(UserWiseTableExport userWiseTableExport, String? url)?
        success,
    TResult? Function(UserWiseTableExport userWiseTableExport, String message)?
        failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(UserWiseTableExport userWiseTableExport)? loading,
    TResult Function(UserWiseTableExport userWiseTableExport)? content,
    TResult Function(UserWiseTableExport userWiseTableExport, String? url)?
        success,
    TResult Function(UserWiseTableExport userWiseTableExport, String message)?
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
  $UserWiseTableExportStateCopyWith<UserWiseTableExportState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserWiseTableExportStateCopyWith<$Res> {
  factory $UserWiseTableExportStateCopyWith(UserWiseTableExportState value,
          $Res Function(UserWiseTableExportState) then) =
      _$UserWiseTableExportStateCopyWithImpl<$Res, UserWiseTableExportState>;
  @useResult
  $Res call({UserWiseTableExport userWiseTableExport});

  $UserWiseTableExportCopyWith<$Res> get userWiseTableExport;
}

/// @nodoc
class _$UserWiseTableExportStateCopyWithImpl<$Res,
        $Val extends UserWiseTableExportState>
    implements $UserWiseTableExportStateCopyWith<$Res> {
  _$UserWiseTableExportStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userWiseTableExport = null,
  }) {
    return _then(_value.copyWith(
      userWiseTableExport: null == userWiseTableExport
          ? _value.userWiseTableExport
          : userWiseTableExport // ignore: cast_nullable_to_non_nullable
              as UserWiseTableExport,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserWiseTableExportCopyWith<$Res> get userWiseTableExport {
    return $UserWiseTableExportCopyWith<$Res>(_value.userWiseTableExport,
        (value) {
      return _then(_value.copyWith(userWiseTableExport: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res>
    implements $UserWiseTableExportStateCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({UserWiseTableExport userWiseTableExport});

  @override
  $UserWiseTableExportCopyWith<$Res> get userWiseTableExport;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$UserWiseTableExportStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userWiseTableExport = null,
  }) {
    return _then(_$LoadingImpl(
      null == userWiseTableExport
          ? _value.userWiseTableExport
          : userWiseTableExport // ignore: cast_nullable_to_non_nullable
              as UserWiseTableExport,
    ));
  }
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl(this.userWiseTableExport);

  @override
  final UserWiseTableExport userWiseTableExport;

  @override
  String toString() {
    return 'UserWiseTableExportState.loading(userWiseTableExport: $userWiseTableExport)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadingImpl &&
            (identical(other.userWiseTableExport, userWiseTableExport) ||
                other.userWiseTableExport == userWiseTableExport));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userWiseTableExport);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadingImplCopyWith<_$LoadingImpl> get copyWith =>
      __$$LoadingImplCopyWithImpl<_$LoadingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(UserWiseTableExport userWiseTableExport) loading,
    required TResult Function(UserWiseTableExport userWiseTableExport) content,
    required TResult Function(
            UserWiseTableExport userWiseTableExport, String? url)
        success,
    required TResult Function(
            UserWiseTableExport userWiseTableExport, String message)
        failed,
  }) {
    return loading(userWiseTableExport);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(UserWiseTableExport userWiseTableExport)? loading,
    TResult? Function(UserWiseTableExport userWiseTableExport)? content,
    TResult? Function(UserWiseTableExport userWiseTableExport, String? url)?
        success,
    TResult? Function(UserWiseTableExport userWiseTableExport, String message)?
        failed,
  }) {
    return loading?.call(userWiseTableExport);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(UserWiseTableExport userWiseTableExport)? loading,
    TResult Function(UserWiseTableExport userWiseTableExport)? content,
    TResult Function(UserWiseTableExport userWiseTableExport, String? url)?
        success,
    TResult Function(UserWiseTableExport userWiseTableExport, String message)?
        failed,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(userWiseTableExport);
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

abstract class _Loading implements UserWiseTableExportState {
  const factory _Loading(final UserWiseTableExport userWiseTableExport) =
      _$LoadingImpl;

  @override
  UserWiseTableExport get userWiseTableExport;
  @override
  @JsonKey(ignore: true)
  _$$LoadingImplCopyWith<_$LoadingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ContentImplCopyWith<$Res>
    implements $UserWiseTableExportStateCopyWith<$Res> {
  factory _$$ContentImplCopyWith(
          _$ContentImpl value, $Res Function(_$ContentImpl) then) =
      __$$ContentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({UserWiseTableExport userWiseTableExport});

  @override
  $UserWiseTableExportCopyWith<$Res> get userWiseTableExport;
}

/// @nodoc
class __$$ContentImplCopyWithImpl<$Res>
    extends _$UserWiseTableExportStateCopyWithImpl<$Res, _$ContentImpl>
    implements _$$ContentImplCopyWith<$Res> {
  __$$ContentImplCopyWithImpl(
      _$ContentImpl _value, $Res Function(_$ContentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userWiseTableExport = null,
  }) {
    return _then(_$ContentImpl(
      null == userWiseTableExport
          ? _value.userWiseTableExport
          : userWiseTableExport // ignore: cast_nullable_to_non_nullable
              as UserWiseTableExport,
    ));
  }
}

/// @nodoc

class _$ContentImpl implements _Content {
  const _$ContentImpl(this.userWiseTableExport);

  @override
  final UserWiseTableExport userWiseTableExport;

  @override
  String toString() {
    return 'UserWiseTableExportState.content(userWiseTableExport: $userWiseTableExport)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContentImpl &&
            (identical(other.userWiseTableExport, userWiseTableExport) ||
                other.userWiseTableExport == userWiseTableExport));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userWiseTableExport);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ContentImplCopyWith<_$ContentImpl> get copyWith =>
      __$$ContentImplCopyWithImpl<_$ContentImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(UserWiseTableExport userWiseTableExport) loading,
    required TResult Function(UserWiseTableExport userWiseTableExport) content,
    required TResult Function(
            UserWiseTableExport userWiseTableExport, String? url)
        success,
    required TResult Function(
            UserWiseTableExport userWiseTableExport, String message)
        failed,
  }) {
    return content(userWiseTableExport);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(UserWiseTableExport userWiseTableExport)? loading,
    TResult? Function(UserWiseTableExport userWiseTableExport)? content,
    TResult? Function(UserWiseTableExport userWiseTableExport, String? url)?
        success,
    TResult? Function(UserWiseTableExport userWiseTableExport, String message)?
        failed,
  }) {
    return content?.call(userWiseTableExport);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(UserWiseTableExport userWiseTableExport)? loading,
    TResult Function(UserWiseTableExport userWiseTableExport)? content,
    TResult Function(UserWiseTableExport userWiseTableExport, String? url)?
        success,
    TResult Function(UserWiseTableExport userWiseTableExport, String message)?
        failed,
    required TResult orElse(),
  }) {
    if (content != null) {
      return content(userWiseTableExport);
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

abstract class _Content implements UserWiseTableExportState {
  const factory _Content(final UserWiseTableExport userWiseTableExport) =
      _$ContentImpl;

  @override
  UserWiseTableExport get userWiseTableExport;
  @override
  @JsonKey(ignore: true)
  _$$ContentImplCopyWith<_$ContentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SuccessImplCopyWith<$Res>
    implements $UserWiseTableExportStateCopyWith<$Res> {
  factory _$$SuccessImplCopyWith(
          _$SuccessImpl value, $Res Function(_$SuccessImpl) then) =
      __$$SuccessImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({UserWiseTableExport userWiseTableExport, String? url});

  @override
  $UserWiseTableExportCopyWith<$Res> get userWiseTableExport;
}

/// @nodoc
class __$$SuccessImplCopyWithImpl<$Res>
    extends _$UserWiseTableExportStateCopyWithImpl<$Res, _$SuccessImpl>
    implements _$$SuccessImplCopyWith<$Res> {
  __$$SuccessImplCopyWithImpl(
      _$SuccessImpl _value, $Res Function(_$SuccessImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userWiseTableExport = null,
    Object? url = freezed,
  }) {
    return _then(_$SuccessImpl(
      null == userWiseTableExport
          ? _value.userWiseTableExport
          : userWiseTableExport // ignore: cast_nullable_to_non_nullable
              as UserWiseTableExport,
      freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$SuccessImpl implements _Success {
  const _$SuccessImpl(this.userWiseTableExport, this.url);

  @override
  final UserWiseTableExport userWiseTableExport;
  @override
  final String? url;

  @override
  String toString() {
    return 'UserWiseTableExportState.success(userWiseTableExport: $userWiseTableExport, url: $url)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuccessImpl &&
            (identical(other.userWiseTableExport, userWiseTableExport) ||
                other.userWiseTableExport == userWiseTableExport) &&
            (identical(other.url, url) || other.url == url));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userWiseTableExport, url);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      __$$SuccessImplCopyWithImpl<_$SuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(UserWiseTableExport userWiseTableExport) loading,
    required TResult Function(UserWiseTableExport userWiseTableExport) content,
    required TResult Function(
            UserWiseTableExport userWiseTableExport, String? url)
        success,
    required TResult Function(
            UserWiseTableExport userWiseTableExport, String message)
        failed,
  }) {
    return success(userWiseTableExport, url);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(UserWiseTableExport userWiseTableExport)? loading,
    TResult? Function(UserWiseTableExport userWiseTableExport)? content,
    TResult? Function(UserWiseTableExport userWiseTableExport, String? url)?
        success,
    TResult? Function(UserWiseTableExport userWiseTableExport, String message)?
        failed,
  }) {
    return success?.call(userWiseTableExport, url);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(UserWiseTableExport userWiseTableExport)? loading,
    TResult Function(UserWiseTableExport userWiseTableExport)? content,
    TResult Function(UserWiseTableExport userWiseTableExport, String? url)?
        success,
    TResult Function(UserWiseTableExport userWiseTableExport, String message)?
        failed,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(userWiseTableExport, url);
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

abstract class _Success implements UserWiseTableExportState {
  const factory _Success(
          final UserWiseTableExport userWiseTableExport, final String? url) =
      _$SuccessImpl;

  @override
  UserWiseTableExport get userWiseTableExport;
  String? get url;
  @override
  @JsonKey(ignore: true)
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FailedImplCopyWith<$Res>
    implements $UserWiseTableExportStateCopyWith<$Res> {
  factory _$$FailedImplCopyWith(
          _$FailedImpl value, $Res Function(_$FailedImpl) then) =
      __$$FailedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({UserWiseTableExport userWiseTableExport, String message});

  @override
  $UserWiseTableExportCopyWith<$Res> get userWiseTableExport;
}

/// @nodoc
class __$$FailedImplCopyWithImpl<$Res>
    extends _$UserWiseTableExportStateCopyWithImpl<$Res, _$FailedImpl>
    implements _$$FailedImplCopyWith<$Res> {
  __$$FailedImplCopyWithImpl(
      _$FailedImpl _value, $Res Function(_$FailedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userWiseTableExport = null,
    Object? message = null,
  }) {
    return _then(_$FailedImpl(
      null == userWiseTableExport
          ? _value.userWiseTableExport
          : userWiseTableExport // ignore: cast_nullable_to_non_nullable
              as UserWiseTableExport,
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$FailedImpl implements _Failed {
  const _$FailedImpl(this.userWiseTableExport, this.message);

  @override
  final UserWiseTableExport userWiseTableExport;
  @override
  final String message;

  @override
  String toString() {
    return 'UserWiseTableExportState.failed(userWiseTableExport: $userWiseTableExport, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FailedImpl &&
            (identical(other.userWiseTableExport, userWiseTableExport) ||
                other.userWiseTableExport == userWiseTableExport) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userWiseTableExport, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FailedImplCopyWith<_$FailedImpl> get copyWith =>
      __$$FailedImplCopyWithImpl<_$FailedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(UserWiseTableExport userWiseTableExport) loading,
    required TResult Function(UserWiseTableExport userWiseTableExport) content,
    required TResult Function(
            UserWiseTableExport userWiseTableExport, String? url)
        success,
    required TResult Function(
            UserWiseTableExport userWiseTableExport, String message)
        failed,
  }) {
    return failed(userWiseTableExport, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(UserWiseTableExport userWiseTableExport)? loading,
    TResult? Function(UserWiseTableExport userWiseTableExport)? content,
    TResult? Function(UserWiseTableExport userWiseTableExport, String? url)?
        success,
    TResult? Function(UserWiseTableExport userWiseTableExport, String message)?
        failed,
  }) {
    return failed?.call(userWiseTableExport, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(UserWiseTableExport userWiseTableExport)? loading,
    TResult Function(UserWiseTableExport userWiseTableExport)? content,
    TResult Function(UserWiseTableExport userWiseTableExport, String? url)?
        success,
    TResult Function(UserWiseTableExport userWiseTableExport, String message)?
        failed,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed(userWiseTableExport, message);
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

abstract class _Failed implements UserWiseTableExportState {
  const factory _Failed(
          final UserWiseTableExport userWiseTableExport, final String message) =
      _$FailedImpl;

  @override
  UserWiseTableExport get userWiseTableExport;
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$FailedImplCopyWith<_$FailedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
