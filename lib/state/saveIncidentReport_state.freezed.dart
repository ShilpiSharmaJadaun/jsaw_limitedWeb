// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'saveIncidentReport_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SaveIncidentReportingState {
  SaveIncidentReportingModel get saveIncident =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(SaveIncidentReportingModel saveIncident) loading,
    required TResult Function(SaveIncidentReportingModel saveIncident) content,
    required TResult Function(
            SaveIncidentReportingModel saveIncident, String msg)
        success,
    required TResult Function(
            SaveIncidentReportingModel saveIncident, String msg)
        failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(SaveIncidentReportingModel saveIncident)? loading,
    TResult? Function(SaveIncidentReportingModel saveIncident)? content,
    TResult? Function(SaveIncidentReportingModel saveIncident, String msg)?
        success,
    TResult? Function(SaveIncidentReportingModel saveIncident, String msg)?
        failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(SaveIncidentReportingModel saveIncident)? loading,
    TResult Function(SaveIncidentReportingModel saveIncident)? content,
    TResult Function(SaveIncidentReportingModel saveIncident, String msg)?
        success,
    TResult Function(SaveIncidentReportingModel saveIncident, String msg)?
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
  $SaveIncidentReportingStateCopyWith<SaveIncidentReportingState>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SaveIncidentReportingStateCopyWith<$Res> {
  factory $SaveIncidentReportingStateCopyWith(SaveIncidentReportingState value,
          $Res Function(SaveIncidentReportingState) then) =
      _$SaveIncidentReportingStateCopyWithImpl<$Res,
          SaveIncidentReportingState>;
  @useResult
  $Res call({SaveIncidentReportingModel saveIncident});

  $SaveIncidentReportingModelCopyWith<$Res> get saveIncident;
}

/// @nodoc
class _$SaveIncidentReportingStateCopyWithImpl<$Res,
        $Val extends SaveIncidentReportingState>
    implements $SaveIncidentReportingStateCopyWith<$Res> {
  _$SaveIncidentReportingStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? saveIncident = null,
  }) {
    return _then(_value.copyWith(
      saveIncident: null == saveIncident
          ? _value.saveIncident
          : saveIncident // ignore: cast_nullable_to_non_nullable
              as SaveIncidentReportingModel,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $SaveIncidentReportingModelCopyWith<$Res> get saveIncident {
    return $SaveIncidentReportingModelCopyWith<$Res>(_value.saveIncident,
        (value) {
      return _then(_value.copyWith(saveIncident: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res>
    implements $SaveIncidentReportingStateCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({SaveIncidentReportingModel saveIncident});

  @override
  $SaveIncidentReportingModelCopyWith<$Res> get saveIncident;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$SaveIncidentReportingStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? saveIncident = null,
  }) {
    return _then(_$LoadingImpl(
      null == saveIncident
          ? _value.saveIncident
          : saveIncident // ignore: cast_nullable_to_non_nullable
              as SaveIncidentReportingModel,
    ));
  }
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl(this.saveIncident);

  @override
  final SaveIncidentReportingModel saveIncident;

  @override
  String toString() {
    return 'SaveIncidentReportingState.loading(saveIncident: $saveIncident)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadingImpl &&
            (identical(other.saveIncident, saveIncident) ||
                other.saveIncident == saveIncident));
  }

  @override
  int get hashCode => Object.hash(runtimeType, saveIncident);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadingImplCopyWith<_$LoadingImpl> get copyWith =>
      __$$LoadingImplCopyWithImpl<_$LoadingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(SaveIncidentReportingModel saveIncident) loading,
    required TResult Function(SaveIncidentReportingModel saveIncident) content,
    required TResult Function(
            SaveIncidentReportingModel saveIncident, String msg)
        success,
    required TResult Function(
            SaveIncidentReportingModel saveIncident, String msg)
        failed,
  }) {
    return loading(saveIncident);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(SaveIncidentReportingModel saveIncident)? loading,
    TResult? Function(SaveIncidentReportingModel saveIncident)? content,
    TResult? Function(SaveIncidentReportingModel saveIncident, String msg)?
        success,
    TResult? Function(SaveIncidentReportingModel saveIncident, String msg)?
        failed,
  }) {
    return loading?.call(saveIncident);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(SaveIncidentReportingModel saveIncident)? loading,
    TResult Function(SaveIncidentReportingModel saveIncident)? content,
    TResult Function(SaveIncidentReportingModel saveIncident, String msg)?
        success,
    TResult Function(SaveIncidentReportingModel saveIncident, String msg)?
        failed,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(saveIncident);
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

abstract class _Loading implements SaveIncidentReportingState {
  const factory _Loading(final SaveIncidentReportingModel saveIncident) =
      _$LoadingImpl;

  @override
  SaveIncidentReportingModel get saveIncident;
  @override
  @JsonKey(ignore: true)
  _$$LoadingImplCopyWith<_$LoadingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ContentImplCopyWith<$Res>
    implements $SaveIncidentReportingStateCopyWith<$Res> {
  factory _$$ContentImplCopyWith(
          _$ContentImpl value, $Res Function(_$ContentImpl) then) =
      __$$ContentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({SaveIncidentReportingModel saveIncident});

  @override
  $SaveIncidentReportingModelCopyWith<$Res> get saveIncident;
}

/// @nodoc
class __$$ContentImplCopyWithImpl<$Res>
    extends _$SaveIncidentReportingStateCopyWithImpl<$Res, _$ContentImpl>
    implements _$$ContentImplCopyWith<$Res> {
  __$$ContentImplCopyWithImpl(
      _$ContentImpl _value, $Res Function(_$ContentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? saveIncident = null,
  }) {
    return _then(_$ContentImpl(
      null == saveIncident
          ? _value.saveIncident
          : saveIncident // ignore: cast_nullable_to_non_nullable
              as SaveIncidentReportingModel,
    ));
  }
}

/// @nodoc

class _$ContentImpl implements _Content {
  const _$ContentImpl(this.saveIncident);

  @override
  final SaveIncidentReportingModel saveIncident;

  @override
  String toString() {
    return 'SaveIncidentReportingState.content(saveIncident: $saveIncident)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContentImpl &&
            (identical(other.saveIncident, saveIncident) ||
                other.saveIncident == saveIncident));
  }

  @override
  int get hashCode => Object.hash(runtimeType, saveIncident);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ContentImplCopyWith<_$ContentImpl> get copyWith =>
      __$$ContentImplCopyWithImpl<_$ContentImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(SaveIncidentReportingModel saveIncident) loading,
    required TResult Function(SaveIncidentReportingModel saveIncident) content,
    required TResult Function(
            SaveIncidentReportingModel saveIncident, String msg)
        success,
    required TResult Function(
            SaveIncidentReportingModel saveIncident, String msg)
        failed,
  }) {
    return content(saveIncident);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(SaveIncidentReportingModel saveIncident)? loading,
    TResult? Function(SaveIncidentReportingModel saveIncident)? content,
    TResult? Function(SaveIncidentReportingModel saveIncident, String msg)?
        success,
    TResult? Function(SaveIncidentReportingModel saveIncident, String msg)?
        failed,
  }) {
    return content?.call(saveIncident);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(SaveIncidentReportingModel saveIncident)? loading,
    TResult Function(SaveIncidentReportingModel saveIncident)? content,
    TResult Function(SaveIncidentReportingModel saveIncident, String msg)?
        success,
    TResult Function(SaveIncidentReportingModel saveIncident, String msg)?
        failed,
    required TResult orElse(),
  }) {
    if (content != null) {
      return content(saveIncident);
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

abstract class _Content implements SaveIncidentReportingState {
  const factory _Content(final SaveIncidentReportingModel saveIncident) =
      _$ContentImpl;

  @override
  SaveIncidentReportingModel get saveIncident;
  @override
  @JsonKey(ignore: true)
  _$$ContentImplCopyWith<_$ContentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SuccessImplCopyWith<$Res>
    implements $SaveIncidentReportingStateCopyWith<$Res> {
  factory _$$SuccessImplCopyWith(
          _$SuccessImpl value, $Res Function(_$SuccessImpl) then) =
      __$$SuccessImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({SaveIncidentReportingModel saveIncident, String msg});

  @override
  $SaveIncidentReportingModelCopyWith<$Res> get saveIncident;
}

/// @nodoc
class __$$SuccessImplCopyWithImpl<$Res>
    extends _$SaveIncidentReportingStateCopyWithImpl<$Res, _$SuccessImpl>
    implements _$$SuccessImplCopyWith<$Res> {
  __$$SuccessImplCopyWithImpl(
      _$SuccessImpl _value, $Res Function(_$SuccessImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? saveIncident = null,
    Object? msg = null,
  }) {
    return _then(_$SuccessImpl(
      null == saveIncident
          ? _value.saveIncident
          : saveIncident // ignore: cast_nullable_to_non_nullable
              as SaveIncidentReportingModel,
      null == msg
          ? _value.msg
          : msg // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SuccessImpl implements _Success {
  const _$SuccessImpl(this.saveIncident, this.msg);

  @override
  final SaveIncidentReportingModel saveIncident;
  @override
  final String msg;

  @override
  String toString() {
    return 'SaveIncidentReportingState.success(saveIncident: $saveIncident, msg: $msg)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuccessImpl &&
            (identical(other.saveIncident, saveIncident) ||
                other.saveIncident == saveIncident) &&
            (identical(other.msg, msg) || other.msg == msg));
  }

  @override
  int get hashCode => Object.hash(runtimeType, saveIncident, msg);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      __$$SuccessImplCopyWithImpl<_$SuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(SaveIncidentReportingModel saveIncident) loading,
    required TResult Function(SaveIncidentReportingModel saveIncident) content,
    required TResult Function(
            SaveIncidentReportingModel saveIncident, String msg)
        success,
    required TResult Function(
            SaveIncidentReportingModel saveIncident, String msg)
        failed,
  }) {
    return success(saveIncident, msg);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(SaveIncidentReportingModel saveIncident)? loading,
    TResult? Function(SaveIncidentReportingModel saveIncident)? content,
    TResult? Function(SaveIncidentReportingModel saveIncident, String msg)?
        success,
    TResult? Function(SaveIncidentReportingModel saveIncident, String msg)?
        failed,
  }) {
    return success?.call(saveIncident, msg);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(SaveIncidentReportingModel saveIncident)? loading,
    TResult Function(SaveIncidentReportingModel saveIncident)? content,
    TResult Function(SaveIncidentReportingModel saveIncident, String msg)?
        success,
    TResult Function(SaveIncidentReportingModel saveIncident, String msg)?
        failed,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(saveIncident, msg);
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

abstract class _Success implements SaveIncidentReportingState {
  const factory _Success(
          final SaveIncidentReportingModel saveIncident, final String msg) =
      _$SuccessImpl;

  @override
  SaveIncidentReportingModel get saveIncident;
  String get msg;
  @override
  @JsonKey(ignore: true)
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FailedImplCopyWith<$Res>
    implements $SaveIncidentReportingStateCopyWith<$Res> {
  factory _$$FailedImplCopyWith(
          _$FailedImpl value, $Res Function(_$FailedImpl) then) =
      __$$FailedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({SaveIncidentReportingModel saveIncident, String msg});

  @override
  $SaveIncidentReportingModelCopyWith<$Res> get saveIncident;
}

/// @nodoc
class __$$FailedImplCopyWithImpl<$Res>
    extends _$SaveIncidentReportingStateCopyWithImpl<$Res, _$FailedImpl>
    implements _$$FailedImplCopyWith<$Res> {
  __$$FailedImplCopyWithImpl(
      _$FailedImpl _value, $Res Function(_$FailedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? saveIncident = null,
    Object? msg = null,
  }) {
    return _then(_$FailedImpl(
      null == saveIncident
          ? _value.saveIncident
          : saveIncident // ignore: cast_nullable_to_non_nullable
              as SaveIncidentReportingModel,
      null == msg
          ? _value.msg
          : msg // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$FailedImpl implements _Failed {
  const _$FailedImpl(this.saveIncident, this.msg);

  @override
  final SaveIncidentReportingModel saveIncident;
  @override
  final String msg;

  @override
  String toString() {
    return 'SaveIncidentReportingState.failed(saveIncident: $saveIncident, msg: $msg)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FailedImpl &&
            (identical(other.saveIncident, saveIncident) ||
                other.saveIncident == saveIncident) &&
            (identical(other.msg, msg) || other.msg == msg));
  }

  @override
  int get hashCode => Object.hash(runtimeType, saveIncident, msg);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FailedImplCopyWith<_$FailedImpl> get copyWith =>
      __$$FailedImplCopyWithImpl<_$FailedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(SaveIncidentReportingModel saveIncident) loading,
    required TResult Function(SaveIncidentReportingModel saveIncident) content,
    required TResult Function(
            SaveIncidentReportingModel saveIncident, String msg)
        success,
    required TResult Function(
            SaveIncidentReportingModel saveIncident, String msg)
        failed,
  }) {
    return failed(saveIncident, msg);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(SaveIncidentReportingModel saveIncident)? loading,
    TResult? Function(SaveIncidentReportingModel saveIncident)? content,
    TResult? Function(SaveIncidentReportingModel saveIncident, String msg)?
        success,
    TResult? Function(SaveIncidentReportingModel saveIncident, String msg)?
        failed,
  }) {
    return failed?.call(saveIncident, msg);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(SaveIncidentReportingModel saveIncident)? loading,
    TResult Function(SaveIncidentReportingModel saveIncident)? content,
    TResult Function(SaveIncidentReportingModel saveIncident, String msg)?
        success,
    TResult Function(SaveIncidentReportingModel saveIncident, String msg)?
        failed,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed(saveIncident, msg);
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

abstract class _Failed implements SaveIncidentReportingState {
  const factory _Failed(
          final SaveIncidentReportingModel saveIncident, final String msg) =
      _$FailedImpl;

  @override
  SaveIncidentReportingModel get saveIncident;
  String get msg;
  @override
  @JsonKey(ignore: true)
  _$$FailedImplCopyWith<_$FailedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
