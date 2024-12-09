// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'suggestion_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SaveSuggestionState {
  SaveSuggestionModel get saveSuggestion => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(SaveSuggestionModel saveSuggestion) loading,
    required TResult Function(SaveSuggestionModel saveSuggestion) content,
    required TResult Function(
            SaveSuggestionModel saveSuggestion, String? message)
        success,
    required TResult Function(
            SaveSuggestionModel saveSuggestion, String message)
        failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(SaveSuggestionModel saveSuggestion)? loading,
    TResult? Function(SaveSuggestionModel saveSuggestion)? content,
    TResult? Function(SaveSuggestionModel saveSuggestion, String? message)?
        success,
    TResult? Function(SaveSuggestionModel saveSuggestion, String message)?
        failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(SaveSuggestionModel saveSuggestion)? loading,
    TResult Function(SaveSuggestionModel saveSuggestion)? content,
    TResult Function(SaveSuggestionModel saveSuggestion, String? message)?
        success,
    TResult Function(SaveSuggestionModel saveSuggestion, String message)?
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
  $SaveSuggestionStateCopyWith<SaveSuggestionState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SaveSuggestionStateCopyWith<$Res> {
  factory $SaveSuggestionStateCopyWith(
          SaveSuggestionState value, $Res Function(SaveSuggestionState) then) =
      _$SaveSuggestionStateCopyWithImpl<$Res, SaveSuggestionState>;
  @useResult
  $Res call({SaveSuggestionModel saveSuggestion});

  $SaveSuggestionModelCopyWith<$Res> get saveSuggestion;
}

/// @nodoc
class _$SaveSuggestionStateCopyWithImpl<$Res, $Val extends SaveSuggestionState>
    implements $SaveSuggestionStateCopyWith<$Res> {
  _$SaveSuggestionStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? saveSuggestion = null,
  }) {
    return _then(_value.copyWith(
      saveSuggestion: null == saveSuggestion
          ? _value.saveSuggestion
          : saveSuggestion // ignore: cast_nullable_to_non_nullable
              as SaveSuggestionModel,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $SaveSuggestionModelCopyWith<$Res> get saveSuggestion {
    return $SaveSuggestionModelCopyWith<$Res>(_value.saveSuggestion, (value) {
      return _then(_value.copyWith(saveSuggestion: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res>
    implements $SaveSuggestionStateCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({SaveSuggestionModel saveSuggestion});

  @override
  $SaveSuggestionModelCopyWith<$Res> get saveSuggestion;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$SaveSuggestionStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? saveSuggestion = null,
  }) {
    return _then(_$LoadingImpl(
      null == saveSuggestion
          ? _value.saveSuggestion
          : saveSuggestion // ignore: cast_nullable_to_non_nullable
              as SaveSuggestionModel,
    ));
  }
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl(this.saveSuggestion);

  @override
  final SaveSuggestionModel saveSuggestion;

  @override
  String toString() {
    return 'SaveSuggestionState.loading(saveSuggestion: $saveSuggestion)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadingImpl &&
            (identical(other.saveSuggestion, saveSuggestion) ||
                other.saveSuggestion == saveSuggestion));
  }

  @override
  int get hashCode => Object.hash(runtimeType, saveSuggestion);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadingImplCopyWith<_$LoadingImpl> get copyWith =>
      __$$LoadingImplCopyWithImpl<_$LoadingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(SaveSuggestionModel saveSuggestion) loading,
    required TResult Function(SaveSuggestionModel saveSuggestion) content,
    required TResult Function(
            SaveSuggestionModel saveSuggestion, String? message)
        success,
    required TResult Function(
            SaveSuggestionModel saveSuggestion, String message)
        failed,
  }) {
    return loading(saveSuggestion);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(SaveSuggestionModel saveSuggestion)? loading,
    TResult? Function(SaveSuggestionModel saveSuggestion)? content,
    TResult? Function(SaveSuggestionModel saveSuggestion, String? message)?
        success,
    TResult? Function(SaveSuggestionModel saveSuggestion, String message)?
        failed,
  }) {
    return loading?.call(saveSuggestion);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(SaveSuggestionModel saveSuggestion)? loading,
    TResult Function(SaveSuggestionModel saveSuggestion)? content,
    TResult Function(SaveSuggestionModel saveSuggestion, String? message)?
        success,
    TResult Function(SaveSuggestionModel saveSuggestion, String message)?
        failed,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(saveSuggestion);
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

abstract class _Loading implements SaveSuggestionState {
  const factory _Loading(final SaveSuggestionModel saveSuggestion) =
      _$LoadingImpl;

  @override
  SaveSuggestionModel get saveSuggestion;
  @override
  @JsonKey(ignore: true)
  _$$LoadingImplCopyWith<_$LoadingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ContentImplCopyWith<$Res>
    implements $SaveSuggestionStateCopyWith<$Res> {
  factory _$$ContentImplCopyWith(
          _$ContentImpl value, $Res Function(_$ContentImpl) then) =
      __$$ContentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({SaveSuggestionModel saveSuggestion});

  @override
  $SaveSuggestionModelCopyWith<$Res> get saveSuggestion;
}

/// @nodoc
class __$$ContentImplCopyWithImpl<$Res>
    extends _$SaveSuggestionStateCopyWithImpl<$Res, _$ContentImpl>
    implements _$$ContentImplCopyWith<$Res> {
  __$$ContentImplCopyWithImpl(
      _$ContentImpl _value, $Res Function(_$ContentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? saveSuggestion = null,
  }) {
    return _then(_$ContentImpl(
      null == saveSuggestion
          ? _value.saveSuggestion
          : saveSuggestion // ignore: cast_nullable_to_non_nullable
              as SaveSuggestionModel,
    ));
  }
}

/// @nodoc

class _$ContentImpl implements _Content {
  const _$ContentImpl(this.saveSuggestion);

  @override
  final SaveSuggestionModel saveSuggestion;

  @override
  String toString() {
    return 'SaveSuggestionState.content(saveSuggestion: $saveSuggestion)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContentImpl &&
            (identical(other.saveSuggestion, saveSuggestion) ||
                other.saveSuggestion == saveSuggestion));
  }

  @override
  int get hashCode => Object.hash(runtimeType, saveSuggestion);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ContentImplCopyWith<_$ContentImpl> get copyWith =>
      __$$ContentImplCopyWithImpl<_$ContentImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(SaveSuggestionModel saveSuggestion) loading,
    required TResult Function(SaveSuggestionModel saveSuggestion) content,
    required TResult Function(
            SaveSuggestionModel saveSuggestion, String? message)
        success,
    required TResult Function(
            SaveSuggestionModel saveSuggestion, String message)
        failed,
  }) {
    return content(saveSuggestion);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(SaveSuggestionModel saveSuggestion)? loading,
    TResult? Function(SaveSuggestionModel saveSuggestion)? content,
    TResult? Function(SaveSuggestionModel saveSuggestion, String? message)?
        success,
    TResult? Function(SaveSuggestionModel saveSuggestion, String message)?
        failed,
  }) {
    return content?.call(saveSuggestion);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(SaveSuggestionModel saveSuggestion)? loading,
    TResult Function(SaveSuggestionModel saveSuggestion)? content,
    TResult Function(SaveSuggestionModel saveSuggestion, String? message)?
        success,
    TResult Function(SaveSuggestionModel saveSuggestion, String message)?
        failed,
    required TResult orElse(),
  }) {
    if (content != null) {
      return content(saveSuggestion);
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

abstract class _Content implements SaveSuggestionState {
  const factory _Content(final SaveSuggestionModel saveSuggestion) =
      _$ContentImpl;

  @override
  SaveSuggestionModel get saveSuggestion;
  @override
  @JsonKey(ignore: true)
  _$$ContentImplCopyWith<_$ContentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SuccessImplCopyWith<$Res>
    implements $SaveSuggestionStateCopyWith<$Res> {
  factory _$$SuccessImplCopyWith(
          _$SuccessImpl value, $Res Function(_$SuccessImpl) then) =
      __$$SuccessImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({SaveSuggestionModel saveSuggestion, String? message});

  @override
  $SaveSuggestionModelCopyWith<$Res> get saveSuggestion;
}

/// @nodoc
class __$$SuccessImplCopyWithImpl<$Res>
    extends _$SaveSuggestionStateCopyWithImpl<$Res, _$SuccessImpl>
    implements _$$SuccessImplCopyWith<$Res> {
  __$$SuccessImplCopyWithImpl(
      _$SuccessImpl _value, $Res Function(_$SuccessImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? saveSuggestion = null,
    Object? message = freezed,
  }) {
    return _then(_$SuccessImpl(
      null == saveSuggestion
          ? _value.saveSuggestion
          : saveSuggestion // ignore: cast_nullable_to_non_nullable
              as SaveSuggestionModel,
      freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$SuccessImpl implements _Success {
  const _$SuccessImpl(this.saveSuggestion, this.message);

  @override
  final SaveSuggestionModel saveSuggestion;
  @override
  final String? message;

  @override
  String toString() {
    return 'SaveSuggestionState.success(saveSuggestion: $saveSuggestion, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuccessImpl &&
            (identical(other.saveSuggestion, saveSuggestion) ||
                other.saveSuggestion == saveSuggestion) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, saveSuggestion, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      __$$SuccessImplCopyWithImpl<_$SuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(SaveSuggestionModel saveSuggestion) loading,
    required TResult Function(SaveSuggestionModel saveSuggestion) content,
    required TResult Function(
            SaveSuggestionModel saveSuggestion, String? message)
        success,
    required TResult Function(
            SaveSuggestionModel saveSuggestion, String message)
        failed,
  }) {
    return success(saveSuggestion, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(SaveSuggestionModel saveSuggestion)? loading,
    TResult? Function(SaveSuggestionModel saveSuggestion)? content,
    TResult? Function(SaveSuggestionModel saveSuggestion, String? message)?
        success,
    TResult? Function(SaveSuggestionModel saveSuggestion, String message)?
        failed,
  }) {
    return success?.call(saveSuggestion, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(SaveSuggestionModel saveSuggestion)? loading,
    TResult Function(SaveSuggestionModel saveSuggestion)? content,
    TResult Function(SaveSuggestionModel saveSuggestion, String? message)?
        success,
    TResult Function(SaveSuggestionModel saveSuggestion, String message)?
        failed,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(saveSuggestion, message);
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

abstract class _Success implements SaveSuggestionState {
  const factory _Success(
          final SaveSuggestionModel saveSuggestion, final String? message) =
      _$SuccessImpl;

  @override
  SaveSuggestionModel get saveSuggestion;
  String? get message;
  @override
  @JsonKey(ignore: true)
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FailedImplCopyWith<$Res>
    implements $SaveSuggestionStateCopyWith<$Res> {
  factory _$$FailedImplCopyWith(
          _$FailedImpl value, $Res Function(_$FailedImpl) then) =
      __$$FailedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({SaveSuggestionModel saveSuggestion, String message});

  @override
  $SaveSuggestionModelCopyWith<$Res> get saveSuggestion;
}

/// @nodoc
class __$$FailedImplCopyWithImpl<$Res>
    extends _$SaveSuggestionStateCopyWithImpl<$Res, _$FailedImpl>
    implements _$$FailedImplCopyWith<$Res> {
  __$$FailedImplCopyWithImpl(
      _$FailedImpl _value, $Res Function(_$FailedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? saveSuggestion = null,
    Object? message = null,
  }) {
    return _then(_$FailedImpl(
      null == saveSuggestion
          ? _value.saveSuggestion
          : saveSuggestion // ignore: cast_nullable_to_non_nullable
              as SaveSuggestionModel,
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$FailedImpl implements _Failed {
  const _$FailedImpl(this.saveSuggestion, this.message);

  @override
  final SaveSuggestionModel saveSuggestion;
  @override
  final String message;

  @override
  String toString() {
    return 'SaveSuggestionState.failed(saveSuggestion: $saveSuggestion, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FailedImpl &&
            (identical(other.saveSuggestion, saveSuggestion) ||
                other.saveSuggestion == saveSuggestion) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, saveSuggestion, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FailedImplCopyWith<_$FailedImpl> get copyWith =>
      __$$FailedImplCopyWithImpl<_$FailedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(SaveSuggestionModel saveSuggestion) loading,
    required TResult Function(SaveSuggestionModel saveSuggestion) content,
    required TResult Function(
            SaveSuggestionModel saveSuggestion, String? message)
        success,
    required TResult Function(
            SaveSuggestionModel saveSuggestion, String message)
        failed,
  }) {
    return failed(saveSuggestion, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(SaveSuggestionModel saveSuggestion)? loading,
    TResult? Function(SaveSuggestionModel saveSuggestion)? content,
    TResult? Function(SaveSuggestionModel saveSuggestion, String? message)?
        success,
    TResult? Function(SaveSuggestionModel saveSuggestion, String message)?
        failed,
  }) {
    return failed?.call(saveSuggestion, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(SaveSuggestionModel saveSuggestion)? loading,
    TResult Function(SaveSuggestionModel saveSuggestion)? content,
    TResult Function(SaveSuggestionModel saveSuggestion, String? message)?
        success,
    TResult Function(SaveSuggestionModel saveSuggestion, String message)?
        failed,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed(saveSuggestion, message);
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

abstract class _Failed implements SaveSuggestionState {
  const factory _Failed(
          final SaveSuggestionModel saveSuggestion, final String message) =
      _$FailedImpl;

  @override
  SaveSuggestionModel get saveSuggestion;
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$FailedImplCopyWith<_$FailedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
