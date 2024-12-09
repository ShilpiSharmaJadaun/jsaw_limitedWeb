// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_observation_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$UpdateObservationState {
  UpdateObservationModel get updateObservation =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(UpdateObservationModel updateObservation) loading,
    required TResult Function(UpdateObservationModel updateObservation) content,
    required TResult Function(
            UpdateObservationModel updateObservation, String? message)
        success,
    required TResult Function(
            UpdateObservationModel updateObservation, String message)
        failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(UpdateObservationModel updateObservation)? loading,
    TResult? Function(UpdateObservationModel updateObservation)? content,
    TResult? Function(
            UpdateObservationModel updateObservation, String? message)?
        success,
    TResult? Function(UpdateObservationModel updateObservation, String message)?
        failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(UpdateObservationModel updateObservation)? loading,
    TResult Function(UpdateObservationModel updateObservation)? content,
    TResult Function(UpdateObservationModel updateObservation, String? message)?
        success,
    TResult Function(UpdateObservationModel updateObservation, String message)?
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
  $UpdateObservationStateCopyWith<UpdateObservationState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateObservationStateCopyWith<$Res> {
  factory $UpdateObservationStateCopyWith(UpdateObservationState value,
          $Res Function(UpdateObservationState) then) =
      _$UpdateObservationStateCopyWithImpl<$Res, UpdateObservationState>;
  @useResult
  $Res call({UpdateObservationModel updateObservation});

  $UpdateObservationModelCopyWith<$Res> get updateObservation;
}

/// @nodoc
class _$UpdateObservationStateCopyWithImpl<$Res,
        $Val extends UpdateObservationState>
    implements $UpdateObservationStateCopyWith<$Res> {
  _$UpdateObservationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? updateObservation = null,
  }) {
    return _then(_value.copyWith(
      updateObservation: null == updateObservation
          ? _value.updateObservation
          : updateObservation // ignore: cast_nullable_to_non_nullable
              as UpdateObservationModel,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UpdateObservationModelCopyWith<$Res> get updateObservation {
    return $UpdateObservationModelCopyWith<$Res>(_value.updateObservation,
        (value) {
      return _then(_value.copyWith(updateObservation: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res>
    implements $UpdateObservationStateCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({UpdateObservationModel updateObservation});

  @override
  $UpdateObservationModelCopyWith<$Res> get updateObservation;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$UpdateObservationStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? updateObservation = null,
  }) {
    return _then(_$LoadingImpl(
      null == updateObservation
          ? _value.updateObservation
          : updateObservation // ignore: cast_nullable_to_non_nullable
              as UpdateObservationModel,
    ));
  }
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl(this.updateObservation);

  @override
  final UpdateObservationModel updateObservation;

  @override
  String toString() {
    return 'UpdateObservationState.loading(updateObservation: $updateObservation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadingImpl &&
            (identical(other.updateObservation, updateObservation) ||
                other.updateObservation == updateObservation));
  }

  @override
  int get hashCode => Object.hash(runtimeType, updateObservation);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadingImplCopyWith<_$LoadingImpl> get copyWith =>
      __$$LoadingImplCopyWithImpl<_$LoadingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(UpdateObservationModel updateObservation) loading,
    required TResult Function(UpdateObservationModel updateObservation) content,
    required TResult Function(
            UpdateObservationModel updateObservation, String? message)
        success,
    required TResult Function(
            UpdateObservationModel updateObservation, String message)
        failed,
  }) {
    return loading(updateObservation);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(UpdateObservationModel updateObservation)? loading,
    TResult? Function(UpdateObservationModel updateObservation)? content,
    TResult? Function(
            UpdateObservationModel updateObservation, String? message)?
        success,
    TResult? Function(UpdateObservationModel updateObservation, String message)?
        failed,
  }) {
    return loading?.call(updateObservation);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(UpdateObservationModel updateObservation)? loading,
    TResult Function(UpdateObservationModel updateObservation)? content,
    TResult Function(UpdateObservationModel updateObservation, String? message)?
        success,
    TResult Function(UpdateObservationModel updateObservation, String message)?
        failed,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(updateObservation);
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

abstract class _Loading implements UpdateObservationState {
  const factory _Loading(final UpdateObservationModel updateObservation) =
      _$LoadingImpl;

  @override
  UpdateObservationModel get updateObservation;
  @override
  @JsonKey(ignore: true)
  _$$LoadingImplCopyWith<_$LoadingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ContentImplCopyWith<$Res>
    implements $UpdateObservationStateCopyWith<$Res> {
  factory _$$ContentImplCopyWith(
          _$ContentImpl value, $Res Function(_$ContentImpl) then) =
      __$$ContentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({UpdateObservationModel updateObservation});

  @override
  $UpdateObservationModelCopyWith<$Res> get updateObservation;
}

/// @nodoc
class __$$ContentImplCopyWithImpl<$Res>
    extends _$UpdateObservationStateCopyWithImpl<$Res, _$ContentImpl>
    implements _$$ContentImplCopyWith<$Res> {
  __$$ContentImplCopyWithImpl(
      _$ContentImpl _value, $Res Function(_$ContentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? updateObservation = null,
  }) {
    return _then(_$ContentImpl(
      null == updateObservation
          ? _value.updateObservation
          : updateObservation // ignore: cast_nullable_to_non_nullable
              as UpdateObservationModel,
    ));
  }
}

/// @nodoc

class _$ContentImpl implements _Content {
  const _$ContentImpl(this.updateObservation);

  @override
  final UpdateObservationModel updateObservation;

  @override
  String toString() {
    return 'UpdateObservationState.content(updateObservation: $updateObservation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContentImpl &&
            (identical(other.updateObservation, updateObservation) ||
                other.updateObservation == updateObservation));
  }

  @override
  int get hashCode => Object.hash(runtimeType, updateObservation);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ContentImplCopyWith<_$ContentImpl> get copyWith =>
      __$$ContentImplCopyWithImpl<_$ContentImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(UpdateObservationModel updateObservation) loading,
    required TResult Function(UpdateObservationModel updateObservation) content,
    required TResult Function(
            UpdateObservationModel updateObservation, String? message)
        success,
    required TResult Function(
            UpdateObservationModel updateObservation, String message)
        failed,
  }) {
    return content(updateObservation);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(UpdateObservationModel updateObservation)? loading,
    TResult? Function(UpdateObservationModel updateObservation)? content,
    TResult? Function(
            UpdateObservationModel updateObservation, String? message)?
        success,
    TResult? Function(UpdateObservationModel updateObservation, String message)?
        failed,
  }) {
    return content?.call(updateObservation);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(UpdateObservationModel updateObservation)? loading,
    TResult Function(UpdateObservationModel updateObservation)? content,
    TResult Function(UpdateObservationModel updateObservation, String? message)?
        success,
    TResult Function(UpdateObservationModel updateObservation, String message)?
        failed,
    required TResult orElse(),
  }) {
    if (content != null) {
      return content(updateObservation);
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

abstract class _Content implements UpdateObservationState {
  const factory _Content(final UpdateObservationModel updateObservation) =
      _$ContentImpl;

  @override
  UpdateObservationModel get updateObservation;
  @override
  @JsonKey(ignore: true)
  _$$ContentImplCopyWith<_$ContentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SuccessImplCopyWith<$Res>
    implements $UpdateObservationStateCopyWith<$Res> {
  factory _$$SuccessImplCopyWith(
          _$SuccessImpl value, $Res Function(_$SuccessImpl) then) =
      __$$SuccessImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({UpdateObservationModel updateObservation, String? message});

  @override
  $UpdateObservationModelCopyWith<$Res> get updateObservation;
}

/// @nodoc
class __$$SuccessImplCopyWithImpl<$Res>
    extends _$UpdateObservationStateCopyWithImpl<$Res, _$SuccessImpl>
    implements _$$SuccessImplCopyWith<$Res> {
  __$$SuccessImplCopyWithImpl(
      _$SuccessImpl _value, $Res Function(_$SuccessImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? updateObservation = null,
    Object? message = freezed,
  }) {
    return _then(_$SuccessImpl(
      null == updateObservation
          ? _value.updateObservation
          : updateObservation // ignore: cast_nullable_to_non_nullable
              as UpdateObservationModel,
      freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$SuccessImpl implements _Success {
  const _$SuccessImpl(this.updateObservation, this.message);

  @override
  final UpdateObservationModel updateObservation;
  @override
  final String? message;

  @override
  String toString() {
    return 'UpdateObservationState.success(updateObservation: $updateObservation, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuccessImpl &&
            (identical(other.updateObservation, updateObservation) ||
                other.updateObservation == updateObservation) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, updateObservation, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      __$$SuccessImplCopyWithImpl<_$SuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(UpdateObservationModel updateObservation) loading,
    required TResult Function(UpdateObservationModel updateObservation) content,
    required TResult Function(
            UpdateObservationModel updateObservation, String? message)
        success,
    required TResult Function(
            UpdateObservationModel updateObservation, String message)
        failed,
  }) {
    return success(updateObservation, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(UpdateObservationModel updateObservation)? loading,
    TResult? Function(UpdateObservationModel updateObservation)? content,
    TResult? Function(
            UpdateObservationModel updateObservation, String? message)?
        success,
    TResult? Function(UpdateObservationModel updateObservation, String message)?
        failed,
  }) {
    return success?.call(updateObservation, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(UpdateObservationModel updateObservation)? loading,
    TResult Function(UpdateObservationModel updateObservation)? content,
    TResult Function(UpdateObservationModel updateObservation, String? message)?
        success,
    TResult Function(UpdateObservationModel updateObservation, String message)?
        failed,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(updateObservation, message);
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

abstract class _Success implements UpdateObservationState {
  const factory _Success(final UpdateObservationModel updateObservation,
      final String? message) = _$SuccessImpl;

  @override
  UpdateObservationModel get updateObservation;
  String? get message;
  @override
  @JsonKey(ignore: true)
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FailedImplCopyWith<$Res>
    implements $UpdateObservationStateCopyWith<$Res> {
  factory _$$FailedImplCopyWith(
          _$FailedImpl value, $Res Function(_$FailedImpl) then) =
      __$$FailedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({UpdateObservationModel updateObservation, String message});

  @override
  $UpdateObservationModelCopyWith<$Res> get updateObservation;
}

/// @nodoc
class __$$FailedImplCopyWithImpl<$Res>
    extends _$UpdateObservationStateCopyWithImpl<$Res, _$FailedImpl>
    implements _$$FailedImplCopyWith<$Res> {
  __$$FailedImplCopyWithImpl(
      _$FailedImpl _value, $Res Function(_$FailedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? updateObservation = null,
    Object? message = null,
  }) {
    return _then(_$FailedImpl(
      null == updateObservation
          ? _value.updateObservation
          : updateObservation // ignore: cast_nullable_to_non_nullable
              as UpdateObservationModel,
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$FailedImpl implements _Failed {
  const _$FailedImpl(this.updateObservation, this.message);

  @override
  final UpdateObservationModel updateObservation;
  @override
  final String message;

  @override
  String toString() {
    return 'UpdateObservationState.failed(updateObservation: $updateObservation, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FailedImpl &&
            (identical(other.updateObservation, updateObservation) ||
                other.updateObservation == updateObservation) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, updateObservation, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FailedImplCopyWith<_$FailedImpl> get copyWith =>
      __$$FailedImplCopyWithImpl<_$FailedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(UpdateObservationModel updateObservation) loading,
    required TResult Function(UpdateObservationModel updateObservation) content,
    required TResult Function(
            UpdateObservationModel updateObservation, String? message)
        success,
    required TResult Function(
            UpdateObservationModel updateObservation, String message)
        failed,
  }) {
    return failed(updateObservation, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(UpdateObservationModel updateObservation)? loading,
    TResult? Function(UpdateObservationModel updateObservation)? content,
    TResult? Function(
            UpdateObservationModel updateObservation, String? message)?
        success,
    TResult? Function(UpdateObservationModel updateObservation, String message)?
        failed,
  }) {
    return failed?.call(updateObservation, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(UpdateObservationModel updateObservation)? loading,
    TResult Function(UpdateObservationModel updateObservation)? content,
    TResult Function(UpdateObservationModel updateObservation, String? message)?
        success,
    TResult Function(UpdateObservationModel updateObservation, String message)?
        failed,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed(updateObservation, message);
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

abstract class _Failed implements UpdateObservationState {
  const factory _Failed(final UpdateObservationModel updateObservation,
      final String message) = _$FailedImpl;

  @override
  UpdateObservationModel get updateObservation;
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$FailedImplCopyWith<_$FailedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
