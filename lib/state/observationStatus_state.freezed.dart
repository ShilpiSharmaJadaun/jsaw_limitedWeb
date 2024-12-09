// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'observationStatus_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ObservationStatusState {
  ObservationStatusModel get observationStatus =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ObservationStatusModel observationStatus) loading,
    required TResult Function(ObservationStatusModel observationStatus) content,
    required TResult Function(ObservationStatusModel observationStatus) success,
    required TResult Function(
            ObservationStatusModel observationStatus, String msg)
        failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ObservationStatusModel observationStatus)? loading,
    TResult? Function(ObservationStatusModel observationStatus)? content,
    TResult? Function(ObservationStatusModel observationStatus)? success,
    TResult? Function(ObservationStatusModel observationStatus, String msg)?
        failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ObservationStatusModel observationStatus)? loading,
    TResult Function(ObservationStatusModel observationStatus)? content,
    TResult Function(ObservationStatusModel observationStatus)? success,
    TResult Function(ObservationStatusModel observationStatus, String msg)?
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
  $ObservationStatusStateCopyWith<ObservationStatusState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ObservationStatusStateCopyWith<$Res> {
  factory $ObservationStatusStateCopyWith(ObservationStatusState value,
          $Res Function(ObservationStatusState) then) =
      _$ObservationStatusStateCopyWithImpl<$Res, ObservationStatusState>;
  @useResult
  $Res call({ObservationStatusModel observationStatus});

  $ObservationStatusModelCopyWith<$Res> get observationStatus;
}

/// @nodoc
class _$ObservationStatusStateCopyWithImpl<$Res,
        $Val extends ObservationStatusState>
    implements $ObservationStatusStateCopyWith<$Res> {
  _$ObservationStatusStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? observationStatus = null,
  }) {
    return _then(_value.copyWith(
      observationStatus: null == observationStatus
          ? _value.observationStatus
          : observationStatus // ignore: cast_nullable_to_non_nullable
              as ObservationStatusModel,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ObservationStatusModelCopyWith<$Res> get observationStatus {
    return $ObservationStatusModelCopyWith<$Res>(_value.observationStatus,
        (value) {
      return _then(_value.copyWith(observationStatus: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res>
    implements $ObservationStatusStateCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ObservationStatusModel observationStatus});

  @override
  $ObservationStatusModelCopyWith<$Res> get observationStatus;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$ObservationStatusStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? observationStatus = null,
  }) {
    return _then(_$LoadingImpl(
      null == observationStatus
          ? _value.observationStatus
          : observationStatus // ignore: cast_nullable_to_non_nullable
              as ObservationStatusModel,
    ));
  }
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl(this.observationStatus);

  @override
  final ObservationStatusModel observationStatus;

  @override
  String toString() {
    return 'ObservationStatusState.loading(observationStatus: $observationStatus)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadingImpl &&
            (identical(other.observationStatus, observationStatus) ||
                other.observationStatus == observationStatus));
  }

  @override
  int get hashCode => Object.hash(runtimeType, observationStatus);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadingImplCopyWith<_$LoadingImpl> get copyWith =>
      __$$LoadingImplCopyWithImpl<_$LoadingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ObservationStatusModel observationStatus) loading,
    required TResult Function(ObservationStatusModel observationStatus) content,
    required TResult Function(ObservationStatusModel observationStatus) success,
    required TResult Function(
            ObservationStatusModel observationStatus, String msg)
        failed,
  }) {
    return loading(observationStatus);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ObservationStatusModel observationStatus)? loading,
    TResult? Function(ObservationStatusModel observationStatus)? content,
    TResult? Function(ObservationStatusModel observationStatus)? success,
    TResult? Function(ObservationStatusModel observationStatus, String msg)?
        failed,
  }) {
    return loading?.call(observationStatus);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ObservationStatusModel observationStatus)? loading,
    TResult Function(ObservationStatusModel observationStatus)? content,
    TResult Function(ObservationStatusModel observationStatus)? success,
    TResult Function(ObservationStatusModel observationStatus, String msg)?
        failed,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(observationStatus);
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

abstract class _Loading implements ObservationStatusState {
  const factory _Loading(final ObservationStatusModel observationStatus) =
      _$LoadingImpl;

  @override
  ObservationStatusModel get observationStatus;
  @override
  @JsonKey(ignore: true)
  _$$LoadingImplCopyWith<_$LoadingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ContentImplCopyWith<$Res>
    implements $ObservationStatusStateCopyWith<$Res> {
  factory _$$ContentImplCopyWith(
          _$ContentImpl value, $Res Function(_$ContentImpl) then) =
      __$$ContentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ObservationStatusModel observationStatus});

  @override
  $ObservationStatusModelCopyWith<$Res> get observationStatus;
}

/// @nodoc
class __$$ContentImplCopyWithImpl<$Res>
    extends _$ObservationStatusStateCopyWithImpl<$Res, _$ContentImpl>
    implements _$$ContentImplCopyWith<$Res> {
  __$$ContentImplCopyWithImpl(
      _$ContentImpl _value, $Res Function(_$ContentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? observationStatus = null,
  }) {
    return _then(_$ContentImpl(
      null == observationStatus
          ? _value.observationStatus
          : observationStatus // ignore: cast_nullable_to_non_nullable
              as ObservationStatusModel,
    ));
  }
}

/// @nodoc

class _$ContentImpl implements _Content {
  const _$ContentImpl(this.observationStatus);

  @override
  final ObservationStatusModel observationStatus;

  @override
  String toString() {
    return 'ObservationStatusState.content(observationStatus: $observationStatus)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContentImpl &&
            (identical(other.observationStatus, observationStatus) ||
                other.observationStatus == observationStatus));
  }

  @override
  int get hashCode => Object.hash(runtimeType, observationStatus);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ContentImplCopyWith<_$ContentImpl> get copyWith =>
      __$$ContentImplCopyWithImpl<_$ContentImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ObservationStatusModel observationStatus) loading,
    required TResult Function(ObservationStatusModel observationStatus) content,
    required TResult Function(ObservationStatusModel observationStatus) success,
    required TResult Function(
            ObservationStatusModel observationStatus, String msg)
        failed,
  }) {
    return content(observationStatus);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ObservationStatusModel observationStatus)? loading,
    TResult? Function(ObservationStatusModel observationStatus)? content,
    TResult? Function(ObservationStatusModel observationStatus)? success,
    TResult? Function(ObservationStatusModel observationStatus, String msg)?
        failed,
  }) {
    return content?.call(observationStatus);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ObservationStatusModel observationStatus)? loading,
    TResult Function(ObservationStatusModel observationStatus)? content,
    TResult Function(ObservationStatusModel observationStatus)? success,
    TResult Function(ObservationStatusModel observationStatus, String msg)?
        failed,
    required TResult orElse(),
  }) {
    if (content != null) {
      return content(observationStatus);
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

abstract class _Content implements ObservationStatusState {
  const factory _Content(final ObservationStatusModel observationStatus) =
      _$ContentImpl;

  @override
  ObservationStatusModel get observationStatus;
  @override
  @JsonKey(ignore: true)
  _$$ContentImplCopyWith<_$ContentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SuccessImplCopyWith<$Res>
    implements $ObservationStatusStateCopyWith<$Res> {
  factory _$$SuccessImplCopyWith(
          _$SuccessImpl value, $Res Function(_$SuccessImpl) then) =
      __$$SuccessImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ObservationStatusModel observationStatus});

  @override
  $ObservationStatusModelCopyWith<$Res> get observationStatus;
}

/// @nodoc
class __$$SuccessImplCopyWithImpl<$Res>
    extends _$ObservationStatusStateCopyWithImpl<$Res, _$SuccessImpl>
    implements _$$SuccessImplCopyWith<$Res> {
  __$$SuccessImplCopyWithImpl(
      _$SuccessImpl _value, $Res Function(_$SuccessImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? observationStatus = null,
  }) {
    return _then(_$SuccessImpl(
      null == observationStatus
          ? _value.observationStatus
          : observationStatus // ignore: cast_nullable_to_non_nullable
              as ObservationStatusModel,
    ));
  }
}

/// @nodoc

class _$SuccessImpl implements _Success {
  const _$SuccessImpl(this.observationStatus);

  @override
  final ObservationStatusModel observationStatus;

  @override
  String toString() {
    return 'ObservationStatusState.success(observationStatus: $observationStatus)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuccessImpl &&
            (identical(other.observationStatus, observationStatus) ||
                other.observationStatus == observationStatus));
  }

  @override
  int get hashCode => Object.hash(runtimeType, observationStatus);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      __$$SuccessImplCopyWithImpl<_$SuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ObservationStatusModel observationStatus) loading,
    required TResult Function(ObservationStatusModel observationStatus) content,
    required TResult Function(ObservationStatusModel observationStatus) success,
    required TResult Function(
            ObservationStatusModel observationStatus, String msg)
        failed,
  }) {
    return success(observationStatus);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ObservationStatusModel observationStatus)? loading,
    TResult? Function(ObservationStatusModel observationStatus)? content,
    TResult? Function(ObservationStatusModel observationStatus)? success,
    TResult? Function(ObservationStatusModel observationStatus, String msg)?
        failed,
  }) {
    return success?.call(observationStatus);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ObservationStatusModel observationStatus)? loading,
    TResult Function(ObservationStatusModel observationStatus)? content,
    TResult Function(ObservationStatusModel observationStatus)? success,
    TResult Function(ObservationStatusModel observationStatus, String msg)?
        failed,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(observationStatus);
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

abstract class _Success implements ObservationStatusState {
  const factory _Success(final ObservationStatusModel observationStatus) =
      _$SuccessImpl;

  @override
  ObservationStatusModel get observationStatus;
  @override
  @JsonKey(ignore: true)
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FailedImplCopyWith<$Res>
    implements $ObservationStatusStateCopyWith<$Res> {
  factory _$$FailedImplCopyWith(
          _$FailedImpl value, $Res Function(_$FailedImpl) then) =
      __$$FailedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ObservationStatusModel observationStatus, String msg});

  @override
  $ObservationStatusModelCopyWith<$Res> get observationStatus;
}

/// @nodoc
class __$$FailedImplCopyWithImpl<$Res>
    extends _$ObservationStatusStateCopyWithImpl<$Res, _$FailedImpl>
    implements _$$FailedImplCopyWith<$Res> {
  __$$FailedImplCopyWithImpl(
      _$FailedImpl _value, $Res Function(_$FailedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? observationStatus = null,
    Object? msg = null,
  }) {
    return _then(_$FailedImpl(
      null == observationStatus
          ? _value.observationStatus
          : observationStatus // ignore: cast_nullable_to_non_nullable
              as ObservationStatusModel,
      null == msg
          ? _value.msg
          : msg // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$FailedImpl implements _Failed {
  const _$FailedImpl(this.observationStatus, this.msg);

  @override
  final ObservationStatusModel observationStatus;
  @override
  final String msg;

  @override
  String toString() {
    return 'ObservationStatusState.failed(observationStatus: $observationStatus, msg: $msg)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FailedImpl &&
            (identical(other.observationStatus, observationStatus) ||
                other.observationStatus == observationStatus) &&
            (identical(other.msg, msg) || other.msg == msg));
  }

  @override
  int get hashCode => Object.hash(runtimeType, observationStatus, msg);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FailedImplCopyWith<_$FailedImpl> get copyWith =>
      __$$FailedImplCopyWithImpl<_$FailedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ObservationStatusModel observationStatus) loading,
    required TResult Function(ObservationStatusModel observationStatus) content,
    required TResult Function(ObservationStatusModel observationStatus) success,
    required TResult Function(
            ObservationStatusModel observationStatus, String msg)
        failed,
  }) {
    return failed(observationStatus, msg);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ObservationStatusModel observationStatus)? loading,
    TResult? Function(ObservationStatusModel observationStatus)? content,
    TResult? Function(ObservationStatusModel observationStatus)? success,
    TResult? Function(ObservationStatusModel observationStatus, String msg)?
        failed,
  }) {
    return failed?.call(observationStatus, msg);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ObservationStatusModel observationStatus)? loading,
    TResult Function(ObservationStatusModel observationStatus)? content,
    TResult Function(ObservationStatusModel observationStatus)? success,
    TResult Function(ObservationStatusModel observationStatus, String msg)?
        failed,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed(observationStatus, msg);
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

abstract class _Failed implements ObservationStatusState {
  const factory _Failed(
          final ObservationStatusModel observationStatus, final String msg) =
      _$FailedImpl;

  @override
  ObservationStatusModel get observationStatus;
  String get msg;
  @override
  @JsonKey(ignore: true)
  _$$FailedImplCopyWith<_$FailedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
