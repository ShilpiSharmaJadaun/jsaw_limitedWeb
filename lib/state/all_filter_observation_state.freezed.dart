// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'all_filter_observation_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AllFilterObservationState {
  AllFilterObservationModel get filterObservation =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AllFilterObservationModel filterObservation)
        loading,
    required TResult Function(AllFilterObservationModel filterObservation)
        content,
    required TResult Function(AllFilterObservationModel filterObservation)
        success,
    required TResult Function(
            AllFilterObservationModel filterObservation, String msg)
        failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AllFilterObservationModel filterObservation)? loading,
    TResult? Function(AllFilterObservationModel filterObservation)? content,
    TResult? Function(AllFilterObservationModel filterObservation)? success,
    TResult? Function(AllFilterObservationModel filterObservation, String msg)?
        failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AllFilterObservationModel filterObservation)? loading,
    TResult Function(AllFilterObservationModel filterObservation)? content,
    TResult Function(AllFilterObservationModel filterObservation)? success,
    TResult Function(AllFilterObservationModel filterObservation, String msg)?
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
  $AllFilterObservationStateCopyWith<AllFilterObservationState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AllFilterObservationStateCopyWith<$Res> {
  factory $AllFilterObservationStateCopyWith(AllFilterObservationState value,
          $Res Function(AllFilterObservationState) then) =
      _$AllFilterObservationStateCopyWithImpl<$Res, AllFilterObservationState>;
  @useResult
  $Res call({AllFilterObservationModel filterObservation});

  $AllFilterObservationModelCopyWith<$Res> get filterObservation;
}

/// @nodoc
class _$AllFilterObservationStateCopyWithImpl<$Res,
        $Val extends AllFilterObservationState>
    implements $AllFilterObservationStateCopyWith<$Res> {
  _$AllFilterObservationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? filterObservation = null,
  }) {
    return _then(_value.copyWith(
      filterObservation: null == filterObservation
          ? _value.filterObservation
          : filterObservation // ignore: cast_nullable_to_non_nullable
              as AllFilterObservationModel,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $AllFilterObservationModelCopyWith<$Res> get filterObservation {
    return $AllFilterObservationModelCopyWith<$Res>(_value.filterObservation,
        (value) {
      return _then(_value.copyWith(filterObservation: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res>
    implements $AllFilterObservationStateCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AllFilterObservationModel filterObservation});

  @override
  $AllFilterObservationModelCopyWith<$Res> get filterObservation;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$AllFilterObservationStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? filterObservation = null,
  }) {
    return _then(_$LoadingImpl(
      null == filterObservation
          ? _value.filterObservation
          : filterObservation // ignore: cast_nullable_to_non_nullable
              as AllFilterObservationModel,
    ));
  }
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl(this.filterObservation);

  @override
  final AllFilterObservationModel filterObservation;

  @override
  String toString() {
    return 'AllFilterObservationState.loading(filterObservation: $filterObservation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadingImpl &&
            (identical(other.filterObservation, filterObservation) ||
                other.filterObservation == filterObservation));
  }

  @override
  int get hashCode => Object.hash(runtimeType, filterObservation);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadingImplCopyWith<_$LoadingImpl> get copyWith =>
      __$$LoadingImplCopyWithImpl<_$LoadingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AllFilterObservationModel filterObservation)
        loading,
    required TResult Function(AllFilterObservationModel filterObservation)
        content,
    required TResult Function(AllFilterObservationModel filterObservation)
        success,
    required TResult Function(
            AllFilterObservationModel filterObservation, String msg)
        failed,
  }) {
    return loading(filterObservation);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AllFilterObservationModel filterObservation)? loading,
    TResult? Function(AllFilterObservationModel filterObservation)? content,
    TResult? Function(AllFilterObservationModel filterObservation)? success,
    TResult? Function(AllFilterObservationModel filterObservation, String msg)?
        failed,
  }) {
    return loading?.call(filterObservation);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AllFilterObservationModel filterObservation)? loading,
    TResult Function(AllFilterObservationModel filterObservation)? content,
    TResult Function(AllFilterObservationModel filterObservation)? success,
    TResult Function(AllFilterObservationModel filterObservation, String msg)?
        failed,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(filterObservation);
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

abstract class _Loading implements AllFilterObservationState {
  const factory _Loading(final AllFilterObservationModel filterObservation) =
      _$LoadingImpl;

  @override
  AllFilterObservationModel get filterObservation;
  @override
  @JsonKey(ignore: true)
  _$$LoadingImplCopyWith<_$LoadingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ContentImplCopyWith<$Res>
    implements $AllFilterObservationStateCopyWith<$Res> {
  factory _$$ContentImplCopyWith(
          _$ContentImpl value, $Res Function(_$ContentImpl) then) =
      __$$ContentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AllFilterObservationModel filterObservation});

  @override
  $AllFilterObservationModelCopyWith<$Res> get filterObservation;
}

/// @nodoc
class __$$ContentImplCopyWithImpl<$Res>
    extends _$AllFilterObservationStateCopyWithImpl<$Res, _$ContentImpl>
    implements _$$ContentImplCopyWith<$Res> {
  __$$ContentImplCopyWithImpl(
      _$ContentImpl _value, $Res Function(_$ContentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? filterObservation = null,
  }) {
    return _then(_$ContentImpl(
      null == filterObservation
          ? _value.filterObservation
          : filterObservation // ignore: cast_nullable_to_non_nullable
              as AllFilterObservationModel,
    ));
  }
}

/// @nodoc

class _$ContentImpl implements _Content {
  const _$ContentImpl(this.filterObservation);

  @override
  final AllFilterObservationModel filterObservation;

  @override
  String toString() {
    return 'AllFilterObservationState.content(filterObservation: $filterObservation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContentImpl &&
            (identical(other.filterObservation, filterObservation) ||
                other.filterObservation == filterObservation));
  }

  @override
  int get hashCode => Object.hash(runtimeType, filterObservation);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ContentImplCopyWith<_$ContentImpl> get copyWith =>
      __$$ContentImplCopyWithImpl<_$ContentImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AllFilterObservationModel filterObservation)
        loading,
    required TResult Function(AllFilterObservationModel filterObservation)
        content,
    required TResult Function(AllFilterObservationModel filterObservation)
        success,
    required TResult Function(
            AllFilterObservationModel filterObservation, String msg)
        failed,
  }) {
    return content(filterObservation);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AllFilterObservationModel filterObservation)? loading,
    TResult? Function(AllFilterObservationModel filterObservation)? content,
    TResult? Function(AllFilterObservationModel filterObservation)? success,
    TResult? Function(AllFilterObservationModel filterObservation, String msg)?
        failed,
  }) {
    return content?.call(filterObservation);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AllFilterObservationModel filterObservation)? loading,
    TResult Function(AllFilterObservationModel filterObservation)? content,
    TResult Function(AllFilterObservationModel filterObservation)? success,
    TResult Function(AllFilterObservationModel filterObservation, String msg)?
        failed,
    required TResult orElse(),
  }) {
    if (content != null) {
      return content(filterObservation);
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

abstract class _Content implements AllFilterObservationState {
  const factory _Content(final AllFilterObservationModel filterObservation) =
      _$ContentImpl;

  @override
  AllFilterObservationModel get filterObservation;
  @override
  @JsonKey(ignore: true)
  _$$ContentImplCopyWith<_$ContentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SuccessImplCopyWith<$Res>
    implements $AllFilterObservationStateCopyWith<$Res> {
  factory _$$SuccessImplCopyWith(
          _$SuccessImpl value, $Res Function(_$SuccessImpl) then) =
      __$$SuccessImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AllFilterObservationModel filterObservation});

  @override
  $AllFilterObservationModelCopyWith<$Res> get filterObservation;
}

/// @nodoc
class __$$SuccessImplCopyWithImpl<$Res>
    extends _$AllFilterObservationStateCopyWithImpl<$Res, _$SuccessImpl>
    implements _$$SuccessImplCopyWith<$Res> {
  __$$SuccessImplCopyWithImpl(
      _$SuccessImpl _value, $Res Function(_$SuccessImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? filterObservation = null,
  }) {
    return _then(_$SuccessImpl(
      null == filterObservation
          ? _value.filterObservation
          : filterObservation // ignore: cast_nullable_to_non_nullable
              as AllFilterObservationModel,
    ));
  }
}

/// @nodoc

class _$SuccessImpl implements _Success {
  const _$SuccessImpl(this.filterObservation);

  @override
  final AllFilterObservationModel filterObservation;

  @override
  String toString() {
    return 'AllFilterObservationState.success(filterObservation: $filterObservation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuccessImpl &&
            (identical(other.filterObservation, filterObservation) ||
                other.filterObservation == filterObservation));
  }

  @override
  int get hashCode => Object.hash(runtimeType, filterObservation);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      __$$SuccessImplCopyWithImpl<_$SuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AllFilterObservationModel filterObservation)
        loading,
    required TResult Function(AllFilterObservationModel filterObservation)
        content,
    required TResult Function(AllFilterObservationModel filterObservation)
        success,
    required TResult Function(
            AllFilterObservationModel filterObservation, String msg)
        failed,
  }) {
    return success(filterObservation);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AllFilterObservationModel filterObservation)? loading,
    TResult? Function(AllFilterObservationModel filterObservation)? content,
    TResult? Function(AllFilterObservationModel filterObservation)? success,
    TResult? Function(AllFilterObservationModel filterObservation, String msg)?
        failed,
  }) {
    return success?.call(filterObservation);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AllFilterObservationModel filterObservation)? loading,
    TResult Function(AllFilterObservationModel filterObservation)? content,
    TResult Function(AllFilterObservationModel filterObservation)? success,
    TResult Function(AllFilterObservationModel filterObservation, String msg)?
        failed,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(filterObservation);
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

abstract class _Success implements AllFilterObservationState {
  const factory _Success(final AllFilterObservationModel filterObservation) =
      _$SuccessImpl;

  @override
  AllFilterObservationModel get filterObservation;
  @override
  @JsonKey(ignore: true)
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FailedImplCopyWith<$Res>
    implements $AllFilterObservationStateCopyWith<$Res> {
  factory _$$FailedImplCopyWith(
          _$FailedImpl value, $Res Function(_$FailedImpl) then) =
      __$$FailedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AllFilterObservationModel filterObservation, String msg});

  @override
  $AllFilterObservationModelCopyWith<$Res> get filterObservation;
}

/// @nodoc
class __$$FailedImplCopyWithImpl<$Res>
    extends _$AllFilterObservationStateCopyWithImpl<$Res, _$FailedImpl>
    implements _$$FailedImplCopyWith<$Res> {
  __$$FailedImplCopyWithImpl(
      _$FailedImpl _value, $Res Function(_$FailedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? filterObservation = null,
    Object? msg = null,
  }) {
    return _then(_$FailedImpl(
      null == filterObservation
          ? _value.filterObservation
          : filterObservation // ignore: cast_nullable_to_non_nullable
              as AllFilterObservationModel,
      null == msg
          ? _value.msg
          : msg // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$FailedImpl implements _Failed {
  const _$FailedImpl(this.filterObservation, this.msg);

  @override
  final AllFilterObservationModel filterObservation;
  @override
  final String msg;

  @override
  String toString() {
    return 'AllFilterObservationState.failed(filterObservation: $filterObservation, msg: $msg)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FailedImpl &&
            (identical(other.filterObservation, filterObservation) ||
                other.filterObservation == filterObservation) &&
            (identical(other.msg, msg) || other.msg == msg));
  }

  @override
  int get hashCode => Object.hash(runtimeType, filterObservation, msg);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FailedImplCopyWith<_$FailedImpl> get copyWith =>
      __$$FailedImplCopyWithImpl<_$FailedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AllFilterObservationModel filterObservation)
        loading,
    required TResult Function(AllFilterObservationModel filterObservation)
        content,
    required TResult Function(AllFilterObservationModel filterObservation)
        success,
    required TResult Function(
            AllFilterObservationModel filterObservation, String msg)
        failed,
  }) {
    return failed(filterObservation, msg);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AllFilterObservationModel filterObservation)? loading,
    TResult? Function(AllFilterObservationModel filterObservation)? content,
    TResult? Function(AllFilterObservationModel filterObservation)? success,
    TResult? Function(AllFilterObservationModel filterObservation, String msg)?
        failed,
  }) {
    return failed?.call(filterObservation, msg);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AllFilterObservationModel filterObservation)? loading,
    TResult Function(AllFilterObservationModel filterObservation)? content,
    TResult Function(AllFilterObservationModel filterObservation)? success,
    TResult Function(AllFilterObservationModel filterObservation, String msg)?
        failed,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed(filterObservation, msg);
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

abstract class _Failed implements AllFilterObservationState {
  const factory _Failed(
          final AllFilterObservationModel filterObservation, final String msg) =
      _$FailedImpl;

  @override
  AllFilterObservationModel get filterObservation;
  String get msg;
  @override
  @JsonKey(ignore: true)
  _$$FailedImplCopyWith<_$FailedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
