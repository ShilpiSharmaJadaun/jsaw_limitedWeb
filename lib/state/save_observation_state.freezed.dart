// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'save_observation_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SaveObservationState {
  SaveObservationModel get saveObservation =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(SaveObservationModel saveObservation) loading,
    required TResult Function(SaveObservationModel saveObservation) content,
    required TResult Function(SaveObservationModel saveObservation, String msg)
        success,
    required TResult Function(SaveObservationModel saveObservation, String msg)
        failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(SaveObservationModel saveObservation)? loading,
    TResult? Function(SaveObservationModel saveObservation)? content,
    TResult? Function(SaveObservationModel saveObservation, String msg)?
        success,
    TResult? Function(SaveObservationModel saveObservation, String msg)? failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(SaveObservationModel saveObservation)? loading,
    TResult Function(SaveObservationModel saveObservation)? content,
    TResult Function(SaveObservationModel saveObservation, String msg)? success,
    TResult Function(SaveObservationModel saveObservation, String msg)? failed,
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
  $SaveObservationStateCopyWith<SaveObservationState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SaveObservationStateCopyWith<$Res> {
  factory $SaveObservationStateCopyWith(SaveObservationState value,
          $Res Function(SaveObservationState) then) =
      _$SaveObservationStateCopyWithImpl<$Res, SaveObservationState>;
  @useResult
  $Res call({SaveObservationModel saveObservation});

  $SaveObservationModelCopyWith<$Res> get saveObservation;
}

/// @nodoc
class _$SaveObservationStateCopyWithImpl<$Res,
        $Val extends SaveObservationState>
    implements $SaveObservationStateCopyWith<$Res> {
  _$SaveObservationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? saveObservation = null,
  }) {
    return _then(_value.copyWith(
      saveObservation: null == saveObservation
          ? _value.saveObservation
          : saveObservation // ignore: cast_nullable_to_non_nullable
              as SaveObservationModel,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $SaveObservationModelCopyWith<$Res> get saveObservation {
    return $SaveObservationModelCopyWith<$Res>(_value.saveObservation, (value) {
      return _then(_value.copyWith(saveObservation: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res>
    implements $SaveObservationStateCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({SaveObservationModel saveObservation});

  @override
  $SaveObservationModelCopyWith<$Res> get saveObservation;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$SaveObservationStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? saveObservation = null,
  }) {
    return _then(_$LoadingImpl(
      null == saveObservation
          ? _value.saveObservation
          : saveObservation // ignore: cast_nullable_to_non_nullable
              as SaveObservationModel,
    ));
  }
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl(this.saveObservation);

  @override
  final SaveObservationModel saveObservation;

  @override
  String toString() {
    return 'SaveObservationState.loading(saveObservation: $saveObservation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadingImpl &&
            (identical(other.saveObservation, saveObservation) ||
                other.saveObservation == saveObservation));
  }

  @override
  int get hashCode => Object.hash(runtimeType, saveObservation);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadingImplCopyWith<_$LoadingImpl> get copyWith =>
      __$$LoadingImplCopyWithImpl<_$LoadingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(SaveObservationModel saveObservation) loading,
    required TResult Function(SaveObservationModel saveObservation) content,
    required TResult Function(SaveObservationModel saveObservation, String msg)
        success,
    required TResult Function(SaveObservationModel saveObservation, String msg)
        failed,
  }) {
    return loading(saveObservation);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(SaveObservationModel saveObservation)? loading,
    TResult? Function(SaveObservationModel saveObservation)? content,
    TResult? Function(SaveObservationModel saveObservation, String msg)?
        success,
    TResult? Function(SaveObservationModel saveObservation, String msg)? failed,
  }) {
    return loading?.call(saveObservation);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(SaveObservationModel saveObservation)? loading,
    TResult Function(SaveObservationModel saveObservation)? content,
    TResult Function(SaveObservationModel saveObservation, String msg)? success,
    TResult Function(SaveObservationModel saveObservation, String msg)? failed,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(saveObservation);
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

abstract class _Loading implements SaveObservationState {
  const factory _Loading(final SaveObservationModel saveObservation) =
      _$LoadingImpl;

  @override
  SaveObservationModel get saveObservation;
  @override
  @JsonKey(ignore: true)
  _$$LoadingImplCopyWith<_$LoadingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ContentImplCopyWith<$Res>
    implements $SaveObservationStateCopyWith<$Res> {
  factory _$$ContentImplCopyWith(
          _$ContentImpl value, $Res Function(_$ContentImpl) then) =
      __$$ContentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({SaveObservationModel saveObservation});

  @override
  $SaveObservationModelCopyWith<$Res> get saveObservation;
}

/// @nodoc
class __$$ContentImplCopyWithImpl<$Res>
    extends _$SaveObservationStateCopyWithImpl<$Res, _$ContentImpl>
    implements _$$ContentImplCopyWith<$Res> {
  __$$ContentImplCopyWithImpl(
      _$ContentImpl _value, $Res Function(_$ContentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? saveObservation = null,
  }) {
    return _then(_$ContentImpl(
      null == saveObservation
          ? _value.saveObservation
          : saveObservation // ignore: cast_nullable_to_non_nullable
              as SaveObservationModel,
    ));
  }
}

/// @nodoc

class _$ContentImpl implements _Content {
  const _$ContentImpl(this.saveObservation);

  @override
  final SaveObservationModel saveObservation;

  @override
  String toString() {
    return 'SaveObservationState.content(saveObservation: $saveObservation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContentImpl &&
            (identical(other.saveObservation, saveObservation) ||
                other.saveObservation == saveObservation));
  }

  @override
  int get hashCode => Object.hash(runtimeType, saveObservation);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ContentImplCopyWith<_$ContentImpl> get copyWith =>
      __$$ContentImplCopyWithImpl<_$ContentImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(SaveObservationModel saveObservation) loading,
    required TResult Function(SaveObservationModel saveObservation) content,
    required TResult Function(SaveObservationModel saveObservation, String msg)
        success,
    required TResult Function(SaveObservationModel saveObservation, String msg)
        failed,
  }) {
    return content(saveObservation);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(SaveObservationModel saveObservation)? loading,
    TResult? Function(SaveObservationModel saveObservation)? content,
    TResult? Function(SaveObservationModel saveObservation, String msg)?
        success,
    TResult? Function(SaveObservationModel saveObservation, String msg)? failed,
  }) {
    return content?.call(saveObservation);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(SaveObservationModel saveObservation)? loading,
    TResult Function(SaveObservationModel saveObservation)? content,
    TResult Function(SaveObservationModel saveObservation, String msg)? success,
    TResult Function(SaveObservationModel saveObservation, String msg)? failed,
    required TResult orElse(),
  }) {
    if (content != null) {
      return content(saveObservation);
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

abstract class _Content implements SaveObservationState {
  const factory _Content(final SaveObservationModel saveObservation) =
      _$ContentImpl;

  @override
  SaveObservationModel get saveObservation;
  @override
  @JsonKey(ignore: true)
  _$$ContentImplCopyWith<_$ContentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SuccessImplCopyWith<$Res>
    implements $SaveObservationStateCopyWith<$Res> {
  factory _$$SuccessImplCopyWith(
          _$SuccessImpl value, $Res Function(_$SuccessImpl) then) =
      __$$SuccessImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({SaveObservationModel saveObservation, String msg});

  @override
  $SaveObservationModelCopyWith<$Res> get saveObservation;
}

/// @nodoc
class __$$SuccessImplCopyWithImpl<$Res>
    extends _$SaveObservationStateCopyWithImpl<$Res, _$SuccessImpl>
    implements _$$SuccessImplCopyWith<$Res> {
  __$$SuccessImplCopyWithImpl(
      _$SuccessImpl _value, $Res Function(_$SuccessImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? saveObservation = null,
    Object? msg = null,
  }) {
    return _then(_$SuccessImpl(
      null == saveObservation
          ? _value.saveObservation
          : saveObservation // ignore: cast_nullable_to_non_nullable
              as SaveObservationModel,
      null == msg
          ? _value.msg
          : msg // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SuccessImpl implements _Success {
  const _$SuccessImpl(this.saveObservation, this.msg);

  @override
  final SaveObservationModel saveObservation;
  @override
  final String msg;

  @override
  String toString() {
    return 'SaveObservationState.success(saveObservation: $saveObservation, msg: $msg)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuccessImpl &&
            (identical(other.saveObservation, saveObservation) ||
                other.saveObservation == saveObservation) &&
            (identical(other.msg, msg) || other.msg == msg));
  }

  @override
  int get hashCode => Object.hash(runtimeType, saveObservation, msg);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      __$$SuccessImplCopyWithImpl<_$SuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(SaveObservationModel saveObservation) loading,
    required TResult Function(SaveObservationModel saveObservation) content,
    required TResult Function(SaveObservationModel saveObservation, String msg)
        success,
    required TResult Function(SaveObservationModel saveObservation, String msg)
        failed,
  }) {
    return success(saveObservation, msg);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(SaveObservationModel saveObservation)? loading,
    TResult? Function(SaveObservationModel saveObservation)? content,
    TResult? Function(SaveObservationModel saveObservation, String msg)?
        success,
    TResult? Function(SaveObservationModel saveObservation, String msg)? failed,
  }) {
    return success?.call(saveObservation, msg);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(SaveObservationModel saveObservation)? loading,
    TResult Function(SaveObservationModel saveObservation)? content,
    TResult Function(SaveObservationModel saveObservation, String msg)? success,
    TResult Function(SaveObservationModel saveObservation, String msg)? failed,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(saveObservation, msg);
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

abstract class _Success implements SaveObservationState {
  const factory _Success(
          final SaveObservationModel saveObservation, final String msg) =
      _$SuccessImpl;

  @override
  SaveObservationModel get saveObservation;
  String get msg;
  @override
  @JsonKey(ignore: true)
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FailedImplCopyWith<$Res>
    implements $SaveObservationStateCopyWith<$Res> {
  factory _$$FailedImplCopyWith(
          _$FailedImpl value, $Res Function(_$FailedImpl) then) =
      __$$FailedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({SaveObservationModel saveObservation, String msg});

  @override
  $SaveObservationModelCopyWith<$Res> get saveObservation;
}

/// @nodoc
class __$$FailedImplCopyWithImpl<$Res>
    extends _$SaveObservationStateCopyWithImpl<$Res, _$FailedImpl>
    implements _$$FailedImplCopyWith<$Res> {
  __$$FailedImplCopyWithImpl(
      _$FailedImpl _value, $Res Function(_$FailedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? saveObservation = null,
    Object? msg = null,
  }) {
    return _then(_$FailedImpl(
      null == saveObservation
          ? _value.saveObservation
          : saveObservation // ignore: cast_nullable_to_non_nullable
              as SaveObservationModel,
      null == msg
          ? _value.msg
          : msg // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$FailedImpl implements _Failed {
  const _$FailedImpl(this.saveObservation, this.msg);

  @override
  final SaveObservationModel saveObservation;
  @override
  final String msg;

  @override
  String toString() {
    return 'SaveObservationState.failed(saveObservation: $saveObservation, msg: $msg)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FailedImpl &&
            (identical(other.saveObservation, saveObservation) ||
                other.saveObservation == saveObservation) &&
            (identical(other.msg, msg) || other.msg == msg));
  }

  @override
  int get hashCode => Object.hash(runtimeType, saveObservation, msg);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FailedImplCopyWith<_$FailedImpl> get copyWith =>
      __$$FailedImplCopyWithImpl<_$FailedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(SaveObservationModel saveObservation) loading,
    required TResult Function(SaveObservationModel saveObservation) content,
    required TResult Function(SaveObservationModel saveObservation, String msg)
        success,
    required TResult Function(SaveObservationModel saveObservation, String msg)
        failed,
  }) {
    return failed(saveObservation, msg);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(SaveObservationModel saveObservation)? loading,
    TResult? Function(SaveObservationModel saveObservation)? content,
    TResult? Function(SaveObservationModel saveObservation, String msg)?
        success,
    TResult? Function(SaveObservationModel saveObservation, String msg)? failed,
  }) {
    return failed?.call(saveObservation, msg);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(SaveObservationModel saveObservation)? loading,
    TResult Function(SaveObservationModel saveObservation)? content,
    TResult Function(SaveObservationModel saveObservation, String msg)? success,
    TResult Function(SaveObservationModel saveObservation, String msg)? failed,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed(saveObservation, msg);
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

abstract class _Failed implements SaveObservationState {
  const factory _Failed(
          final SaveObservationModel saveObservation, final String msg) =
      _$FailedImpl;

  @override
  SaveObservationModel get saveObservation;
  String get msg;
  @override
  @JsonKey(ignore: true)
  _$$FailedImplCopyWith<_$FailedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
