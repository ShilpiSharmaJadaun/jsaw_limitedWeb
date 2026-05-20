// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'downloadPdf_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$DownloadPdfState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(String uniqueId) loading,
    required TResult Function(String uniqueId, Uint8List bytes) success,
    required TResult Function(String uniqueId, String message) failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(String uniqueId)? loading,
    TResult? Function(String uniqueId, Uint8List bytes)? success,
    TResult? Function(String uniqueId, String message)? failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(String uniqueId)? loading,
    TResult Function(String uniqueId, Uint8List bytes)? success,
    TResult Function(String uniqueId, String message)? failed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Idle value) idle,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_Failed value) failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Idle value)? idle,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_Failed value)? failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Idle value)? idle,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_Failed value)? failed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DownloadPdfStateCopyWith<$Res> {
  factory $DownloadPdfStateCopyWith(
          DownloadPdfState value, $Res Function(DownloadPdfState) then) =
      _$DownloadPdfStateCopyWithImpl<$Res, DownloadPdfState>;
}

/// @nodoc
class _$DownloadPdfStateCopyWithImpl<$Res, $Val extends DownloadPdfState>
    implements $DownloadPdfStateCopyWith<$Res> {
  _$DownloadPdfStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$IdleImplCopyWith<$Res> {
  factory _$$IdleImplCopyWith(
          _$IdleImpl value, $Res Function(_$IdleImpl) then) =
      __$$IdleImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$IdleImplCopyWithImpl<$Res>
    extends _$DownloadPdfStateCopyWithImpl<$Res, _$IdleImpl>
    implements _$$IdleImplCopyWith<$Res> {
  __$$IdleImplCopyWithImpl(_$IdleImpl _value, $Res Function(_$IdleImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$IdleImpl implements _Idle {
  const _$IdleImpl();

  @override
  String toString() {
    return 'DownloadPdfState.idle()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$IdleImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(String uniqueId) loading,
    required TResult Function(String uniqueId, Uint8List bytes) success,
    required TResult Function(String uniqueId, String message) failed,
  }) {
    return idle();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(String uniqueId)? loading,
    TResult? Function(String uniqueId, Uint8List bytes)? success,
    TResult? Function(String uniqueId, String message)? failed,
  }) {
    return idle?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(String uniqueId)? loading,
    TResult Function(String uniqueId, Uint8List bytes)? success,
    TResult Function(String uniqueId, String message)? failed,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Idle value) idle,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_Failed value) failed,
  }) {
    return idle(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Idle value)? idle,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_Failed value)? failed,
  }) {
    return idle?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Idle value)? idle,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_Failed value)? failed,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle(this);
    }
    return orElse();
  }
}

abstract class _Idle implements DownloadPdfState {
  const factory _Idle() = _$IdleImpl;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String uniqueId});
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$DownloadPdfStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uniqueId = null,
  }) {
    return _then(_$LoadingImpl(
      null == uniqueId
          ? _value.uniqueId
          : uniqueId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl(this.uniqueId);

  @override
  final String uniqueId;

  @override
  String toString() {
    return 'DownloadPdfState.loading(uniqueId: $uniqueId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadingImpl &&
            (identical(other.uniqueId, uniqueId) ||
                other.uniqueId == uniqueId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, uniqueId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadingImplCopyWith<_$LoadingImpl> get copyWith =>
      __$$LoadingImplCopyWithImpl<_$LoadingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(String uniqueId) loading,
    required TResult Function(String uniqueId, Uint8List bytes) success,
    required TResult Function(String uniqueId, String message) failed,
  }) {
    return loading(uniqueId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(String uniqueId)? loading,
    TResult? Function(String uniqueId, Uint8List bytes)? success,
    TResult? Function(String uniqueId, String message)? failed,
  }) {
    return loading?.call(uniqueId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(String uniqueId)? loading,
    TResult Function(String uniqueId, Uint8List bytes)? success,
    TResult Function(String uniqueId, String message)? failed,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(uniqueId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Idle value) idle,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_Failed value) failed,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Idle value)? idle,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_Failed value)? failed,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Idle value)? idle,
    TResult Function(_Loading value)? loading,
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

abstract class _Loading implements DownloadPdfState {
  const factory _Loading(final String uniqueId) = _$LoadingImpl;

  String get uniqueId;
  @JsonKey(ignore: true)
  _$$LoadingImplCopyWith<_$LoadingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SuccessImplCopyWith<$Res> {
  factory _$$SuccessImplCopyWith(
          _$SuccessImpl value, $Res Function(_$SuccessImpl) then) =
      __$$SuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String uniqueId, Uint8List bytes});
}

/// @nodoc
class __$$SuccessImplCopyWithImpl<$Res>
    extends _$DownloadPdfStateCopyWithImpl<$Res, _$SuccessImpl>
    implements _$$SuccessImplCopyWith<$Res> {
  __$$SuccessImplCopyWithImpl(
      _$SuccessImpl _value, $Res Function(_$SuccessImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uniqueId = null,
    Object? bytes = null,
  }) {
    return _then(_$SuccessImpl(
      null == uniqueId
          ? _value.uniqueId
          : uniqueId // ignore: cast_nullable_to_non_nullable
              as String,
      null == bytes
          ? _value.bytes
          : bytes // ignore: cast_nullable_to_non_nullable
              as Uint8List,
    ));
  }
}

/// @nodoc

class _$SuccessImpl implements _Success {
  const _$SuccessImpl(this.uniqueId, this.bytes);

  @override
  final String uniqueId;
  @override
  final Uint8List bytes;

  @override
  String toString() {
    return 'DownloadPdfState.success(uniqueId: $uniqueId, bytes: $bytes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuccessImpl &&
            (identical(other.uniqueId, uniqueId) ||
                other.uniqueId == uniqueId) &&
            const DeepCollectionEquality().equals(other.bytes, bytes));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, uniqueId, const DeepCollectionEquality().hash(bytes));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      __$$SuccessImplCopyWithImpl<_$SuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(String uniqueId) loading,
    required TResult Function(String uniqueId, Uint8List bytes) success,
    required TResult Function(String uniqueId, String message) failed,
  }) {
    return success(uniqueId, bytes);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(String uniqueId)? loading,
    TResult? Function(String uniqueId, Uint8List bytes)? success,
    TResult? Function(String uniqueId, String message)? failed,
  }) {
    return success?.call(uniqueId, bytes);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(String uniqueId)? loading,
    TResult Function(String uniqueId, Uint8List bytes)? success,
    TResult Function(String uniqueId, String message)? failed,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(uniqueId, bytes);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Idle value) idle,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_Failed value) failed,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Idle value)? idle,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_Failed value)? failed,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Idle value)? idle,
    TResult Function(_Loading value)? loading,
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

abstract class _Success implements DownloadPdfState {
  const factory _Success(final String uniqueId, final Uint8List bytes) =
      _$SuccessImpl;

  String get uniqueId;
  Uint8List get bytes;
  @JsonKey(ignore: true)
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FailedImplCopyWith<$Res> {
  factory _$$FailedImplCopyWith(
          _$FailedImpl value, $Res Function(_$FailedImpl) then) =
      __$$FailedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String uniqueId, String message});
}

/// @nodoc
class __$$FailedImplCopyWithImpl<$Res>
    extends _$DownloadPdfStateCopyWithImpl<$Res, _$FailedImpl>
    implements _$$FailedImplCopyWith<$Res> {
  __$$FailedImplCopyWithImpl(
      _$FailedImpl _value, $Res Function(_$FailedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uniqueId = null,
    Object? message = null,
  }) {
    return _then(_$FailedImpl(
      null == uniqueId
          ? _value.uniqueId
          : uniqueId // ignore: cast_nullable_to_non_nullable
              as String,
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$FailedImpl implements _Failed {
  const _$FailedImpl(this.uniqueId, this.message);

  @override
  final String uniqueId;
  @override
  final String message;

  @override
  String toString() {
    return 'DownloadPdfState.failed(uniqueId: $uniqueId, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FailedImpl &&
            (identical(other.uniqueId, uniqueId) ||
                other.uniqueId == uniqueId) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, uniqueId, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FailedImplCopyWith<_$FailedImpl> get copyWith =>
      __$$FailedImplCopyWithImpl<_$FailedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(String uniqueId) loading,
    required TResult Function(String uniqueId, Uint8List bytes) success,
    required TResult Function(String uniqueId, String message) failed,
  }) {
    return failed(uniqueId, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(String uniqueId)? loading,
    TResult? Function(String uniqueId, Uint8List bytes)? success,
    TResult? Function(String uniqueId, String message)? failed,
  }) {
    return failed?.call(uniqueId, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(String uniqueId)? loading,
    TResult Function(String uniqueId, Uint8List bytes)? success,
    TResult Function(String uniqueId, String message)? failed,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed(uniqueId, message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Idle value) idle,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_Failed value) failed,
  }) {
    return failed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Idle value)? idle,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_Failed value)? failed,
  }) {
    return failed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Idle value)? idle,
    TResult Function(_Loading value)? loading,
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

abstract class _Failed implements DownloadPdfState {
  const factory _Failed(final String uniqueId, final String message) =
      _$FailedImpl;

  String get uniqueId;
  String get message;
  @JsonKey(ignore: true)
  _$$FailedImplCopyWith<_$FailedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
