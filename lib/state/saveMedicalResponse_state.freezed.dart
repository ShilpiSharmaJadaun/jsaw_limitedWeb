// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'saveMedicalResponse_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SaveMedicalResponseState {
  SaveMedicalResponseModel get saveMedicalResponse =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(SaveMedicalResponseModel saveMedicalResponse)
        loading,
    required TResult Function(SaveMedicalResponseModel saveMedicalResponse)
        content,
    required TResult Function(
            SaveMedicalResponseModel saveMedicalResponse, String? message)
        success,
    required TResult Function(
            SaveMedicalResponseModel saveMedicalResponse, String message)
        failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(SaveMedicalResponseModel saveMedicalResponse)? loading,
    TResult? Function(SaveMedicalResponseModel saveMedicalResponse)? content,
    TResult? Function(
            SaveMedicalResponseModel saveMedicalResponse, String? message)?
        success,
    TResult? Function(
            SaveMedicalResponseModel saveMedicalResponse, String message)?
        failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(SaveMedicalResponseModel saveMedicalResponse)? loading,
    TResult Function(SaveMedicalResponseModel saveMedicalResponse)? content,
    TResult Function(
            SaveMedicalResponseModel saveMedicalResponse, String? message)?
        success,
    TResult Function(
            SaveMedicalResponseModel saveMedicalResponse, String message)?
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
  $SaveMedicalResponseStateCopyWith<SaveMedicalResponseState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SaveMedicalResponseStateCopyWith<$Res> {
  factory $SaveMedicalResponseStateCopyWith(SaveMedicalResponseState value,
          $Res Function(SaveMedicalResponseState) then) =
      _$SaveMedicalResponseStateCopyWithImpl<$Res, SaveMedicalResponseState>;
  @useResult
  $Res call({SaveMedicalResponseModel saveMedicalResponse});

  $SaveMedicalResponseModelCopyWith<$Res> get saveMedicalResponse;
}

/// @nodoc
class _$SaveMedicalResponseStateCopyWithImpl<$Res,
        $Val extends SaveMedicalResponseState>
    implements $SaveMedicalResponseStateCopyWith<$Res> {
  _$SaveMedicalResponseStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? saveMedicalResponse = null,
  }) {
    return _then(_value.copyWith(
      saveMedicalResponse: null == saveMedicalResponse
          ? _value.saveMedicalResponse
          : saveMedicalResponse // ignore: cast_nullable_to_non_nullable
              as SaveMedicalResponseModel,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $SaveMedicalResponseModelCopyWith<$Res> get saveMedicalResponse {
    return $SaveMedicalResponseModelCopyWith<$Res>(_value.saveMedicalResponse,
        (value) {
      return _then(_value.copyWith(saveMedicalResponse: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res>
    implements $SaveMedicalResponseStateCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({SaveMedicalResponseModel saveMedicalResponse});

  @override
  $SaveMedicalResponseModelCopyWith<$Res> get saveMedicalResponse;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$SaveMedicalResponseStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? saveMedicalResponse = null,
  }) {
    return _then(_$LoadingImpl(
      null == saveMedicalResponse
          ? _value.saveMedicalResponse
          : saveMedicalResponse // ignore: cast_nullable_to_non_nullable
              as SaveMedicalResponseModel,
    ));
  }
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl(this.saveMedicalResponse);

  @override
  final SaveMedicalResponseModel saveMedicalResponse;

  @override
  String toString() {
    return 'SaveMedicalResponseState.loading(saveMedicalResponse: $saveMedicalResponse)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadingImpl &&
            (identical(other.saveMedicalResponse, saveMedicalResponse) ||
                other.saveMedicalResponse == saveMedicalResponse));
  }

  @override
  int get hashCode => Object.hash(runtimeType, saveMedicalResponse);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadingImplCopyWith<_$LoadingImpl> get copyWith =>
      __$$LoadingImplCopyWithImpl<_$LoadingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(SaveMedicalResponseModel saveMedicalResponse)
        loading,
    required TResult Function(SaveMedicalResponseModel saveMedicalResponse)
        content,
    required TResult Function(
            SaveMedicalResponseModel saveMedicalResponse, String? message)
        success,
    required TResult Function(
            SaveMedicalResponseModel saveMedicalResponse, String message)
        failed,
  }) {
    return loading(saveMedicalResponse);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(SaveMedicalResponseModel saveMedicalResponse)? loading,
    TResult? Function(SaveMedicalResponseModel saveMedicalResponse)? content,
    TResult? Function(
            SaveMedicalResponseModel saveMedicalResponse, String? message)?
        success,
    TResult? Function(
            SaveMedicalResponseModel saveMedicalResponse, String message)?
        failed,
  }) {
    return loading?.call(saveMedicalResponse);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(SaveMedicalResponseModel saveMedicalResponse)? loading,
    TResult Function(SaveMedicalResponseModel saveMedicalResponse)? content,
    TResult Function(
            SaveMedicalResponseModel saveMedicalResponse, String? message)?
        success,
    TResult Function(
            SaveMedicalResponseModel saveMedicalResponse, String message)?
        failed,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(saveMedicalResponse);
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

abstract class _Loading implements SaveMedicalResponseState {
  const factory _Loading(final SaveMedicalResponseModel saveMedicalResponse) =
      _$LoadingImpl;

  @override
  SaveMedicalResponseModel get saveMedicalResponse;
  @override
  @JsonKey(ignore: true)
  _$$LoadingImplCopyWith<_$LoadingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ContentImplCopyWith<$Res>
    implements $SaveMedicalResponseStateCopyWith<$Res> {
  factory _$$ContentImplCopyWith(
          _$ContentImpl value, $Res Function(_$ContentImpl) then) =
      __$$ContentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({SaveMedicalResponseModel saveMedicalResponse});

  @override
  $SaveMedicalResponseModelCopyWith<$Res> get saveMedicalResponse;
}

/// @nodoc
class __$$ContentImplCopyWithImpl<$Res>
    extends _$SaveMedicalResponseStateCopyWithImpl<$Res, _$ContentImpl>
    implements _$$ContentImplCopyWith<$Res> {
  __$$ContentImplCopyWithImpl(
      _$ContentImpl _value, $Res Function(_$ContentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? saveMedicalResponse = null,
  }) {
    return _then(_$ContentImpl(
      null == saveMedicalResponse
          ? _value.saveMedicalResponse
          : saveMedicalResponse // ignore: cast_nullable_to_non_nullable
              as SaveMedicalResponseModel,
    ));
  }
}

/// @nodoc

class _$ContentImpl implements _Content {
  const _$ContentImpl(this.saveMedicalResponse);

  @override
  final SaveMedicalResponseModel saveMedicalResponse;

  @override
  String toString() {
    return 'SaveMedicalResponseState.content(saveMedicalResponse: $saveMedicalResponse)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContentImpl &&
            (identical(other.saveMedicalResponse, saveMedicalResponse) ||
                other.saveMedicalResponse == saveMedicalResponse));
  }

  @override
  int get hashCode => Object.hash(runtimeType, saveMedicalResponse);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ContentImplCopyWith<_$ContentImpl> get copyWith =>
      __$$ContentImplCopyWithImpl<_$ContentImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(SaveMedicalResponseModel saveMedicalResponse)
        loading,
    required TResult Function(SaveMedicalResponseModel saveMedicalResponse)
        content,
    required TResult Function(
            SaveMedicalResponseModel saveMedicalResponse, String? message)
        success,
    required TResult Function(
            SaveMedicalResponseModel saveMedicalResponse, String message)
        failed,
  }) {
    return content(saveMedicalResponse);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(SaveMedicalResponseModel saveMedicalResponse)? loading,
    TResult? Function(SaveMedicalResponseModel saveMedicalResponse)? content,
    TResult? Function(
            SaveMedicalResponseModel saveMedicalResponse, String? message)?
        success,
    TResult? Function(
            SaveMedicalResponseModel saveMedicalResponse, String message)?
        failed,
  }) {
    return content?.call(saveMedicalResponse);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(SaveMedicalResponseModel saveMedicalResponse)? loading,
    TResult Function(SaveMedicalResponseModel saveMedicalResponse)? content,
    TResult Function(
            SaveMedicalResponseModel saveMedicalResponse, String? message)?
        success,
    TResult Function(
            SaveMedicalResponseModel saveMedicalResponse, String message)?
        failed,
    required TResult orElse(),
  }) {
    if (content != null) {
      return content(saveMedicalResponse);
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

abstract class _Content implements SaveMedicalResponseState {
  const factory _Content(final SaveMedicalResponseModel saveMedicalResponse) =
      _$ContentImpl;

  @override
  SaveMedicalResponseModel get saveMedicalResponse;
  @override
  @JsonKey(ignore: true)
  _$$ContentImplCopyWith<_$ContentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SuccessImplCopyWith<$Res>
    implements $SaveMedicalResponseStateCopyWith<$Res> {
  factory _$$SuccessImplCopyWith(
          _$SuccessImpl value, $Res Function(_$SuccessImpl) then) =
      __$$SuccessImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({SaveMedicalResponseModel saveMedicalResponse, String? message});

  @override
  $SaveMedicalResponseModelCopyWith<$Res> get saveMedicalResponse;
}

/// @nodoc
class __$$SuccessImplCopyWithImpl<$Res>
    extends _$SaveMedicalResponseStateCopyWithImpl<$Res, _$SuccessImpl>
    implements _$$SuccessImplCopyWith<$Res> {
  __$$SuccessImplCopyWithImpl(
      _$SuccessImpl _value, $Res Function(_$SuccessImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? saveMedicalResponse = null,
    Object? message = freezed,
  }) {
    return _then(_$SuccessImpl(
      null == saveMedicalResponse
          ? _value.saveMedicalResponse
          : saveMedicalResponse // ignore: cast_nullable_to_non_nullable
              as SaveMedicalResponseModel,
      freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$SuccessImpl implements _Success {
  const _$SuccessImpl(this.saveMedicalResponse, this.message);

  @override
  final SaveMedicalResponseModel saveMedicalResponse;
  @override
  final String? message;

  @override
  String toString() {
    return 'SaveMedicalResponseState.success(saveMedicalResponse: $saveMedicalResponse, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuccessImpl &&
            (identical(other.saveMedicalResponse, saveMedicalResponse) ||
                other.saveMedicalResponse == saveMedicalResponse) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, saveMedicalResponse, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      __$$SuccessImplCopyWithImpl<_$SuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(SaveMedicalResponseModel saveMedicalResponse)
        loading,
    required TResult Function(SaveMedicalResponseModel saveMedicalResponse)
        content,
    required TResult Function(
            SaveMedicalResponseModel saveMedicalResponse, String? message)
        success,
    required TResult Function(
            SaveMedicalResponseModel saveMedicalResponse, String message)
        failed,
  }) {
    return success(saveMedicalResponse, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(SaveMedicalResponseModel saveMedicalResponse)? loading,
    TResult? Function(SaveMedicalResponseModel saveMedicalResponse)? content,
    TResult? Function(
            SaveMedicalResponseModel saveMedicalResponse, String? message)?
        success,
    TResult? Function(
            SaveMedicalResponseModel saveMedicalResponse, String message)?
        failed,
  }) {
    return success?.call(saveMedicalResponse, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(SaveMedicalResponseModel saveMedicalResponse)? loading,
    TResult Function(SaveMedicalResponseModel saveMedicalResponse)? content,
    TResult Function(
            SaveMedicalResponseModel saveMedicalResponse, String? message)?
        success,
    TResult Function(
            SaveMedicalResponseModel saveMedicalResponse, String message)?
        failed,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(saveMedicalResponse, message);
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

abstract class _Success implements SaveMedicalResponseState {
  const factory _Success(final SaveMedicalResponseModel saveMedicalResponse,
      final String? message) = _$SuccessImpl;

  @override
  SaveMedicalResponseModel get saveMedicalResponse;
  String? get message;
  @override
  @JsonKey(ignore: true)
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FailedImplCopyWith<$Res>
    implements $SaveMedicalResponseStateCopyWith<$Res> {
  factory _$$FailedImplCopyWith(
          _$FailedImpl value, $Res Function(_$FailedImpl) then) =
      __$$FailedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({SaveMedicalResponseModel saveMedicalResponse, String message});

  @override
  $SaveMedicalResponseModelCopyWith<$Res> get saveMedicalResponse;
}

/// @nodoc
class __$$FailedImplCopyWithImpl<$Res>
    extends _$SaveMedicalResponseStateCopyWithImpl<$Res, _$FailedImpl>
    implements _$$FailedImplCopyWith<$Res> {
  __$$FailedImplCopyWithImpl(
      _$FailedImpl _value, $Res Function(_$FailedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? saveMedicalResponse = null,
    Object? message = null,
  }) {
    return _then(_$FailedImpl(
      null == saveMedicalResponse
          ? _value.saveMedicalResponse
          : saveMedicalResponse // ignore: cast_nullable_to_non_nullable
              as SaveMedicalResponseModel,
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$FailedImpl implements _Failed {
  const _$FailedImpl(this.saveMedicalResponse, this.message);

  @override
  final SaveMedicalResponseModel saveMedicalResponse;
  @override
  final String message;

  @override
  String toString() {
    return 'SaveMedicalResponseState.failed(saveMedicalResponse: $saveMedicalResponse, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FailedImpl &&
            (identical(other.saveMedicalResponse, saveMedicalResponse) ||
                other.saveMedicalResponse == saveMedicalResponse) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, saveMedicalResponse, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FailedImplCopyWith<_$FailedImpl> get copyWith =>
      __$$FailedImplCopyWithImpl<_$FailedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(SaveMedicalResponseModel saveMedicalResponse)
        loading,
    required TResult Function(SaveMedicalResponseModel saveMedicalResponse)
        content,
    required TResult Function(
            SaveMedicalResponseModel saveMedicalResponse, String? message)
        success,
    required TResult Function(
            SaveMedicalResponseModel saveMedicalResponse, String message)
        failed,
  }) {
    return failed(saveMedicalResponse, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(SaveMedicalResponseModel saveMedicalResponse)? loading,
    TResult? Function(SaveMedicalResponseModel saveMedicalResponse)? content,
    TResult? Function(
            SaveMedicalResponseModel saveMedicalResponse, String? message)?
        success,
    TResult? Function(
            SaveMedicalResponseModel saveMedicalResponse, String message)?
        failed,
  }) {
    return failed?.call(saveMedicalResponse, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(SaveMedicalResponseModel saveMedicalResponse)? loading,
    TResult Function(SaveMedicalResponseModel saveMedicalResponse)? content,
    TResult Function(
            SaveMedicalResponseModel saveMedicalResponse, String? message)?
        success,
    TResult Function(
            SaveMedicalResponseModel saveMedicalResponse, String message)?
        failed,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed(saveMedicalResponse, message);
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

abstract class _Failed implements SaveMedicalResponseState {
  const factory _Failed(final SaveMedicalResponseModel saveMedicalResponse,
      final String message) = _$FailedImpl;

  @override
  SaveMedicalResponseModel get saveMedicalResponse;
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$FailedImplCopyWith<_$FailedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
