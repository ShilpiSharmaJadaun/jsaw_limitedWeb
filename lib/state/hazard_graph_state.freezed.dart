// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hazard_graph_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$HazardGraphState {
  List<HazardGraphModel> get hazardGraphState =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<HazardGraphModel> hazardGraphState) loading,
    required TResult Function(List<HazardGraphModel> hazardGraphState) content,
    required TResult Function(List<HazardGraphModel> hazardGraphState) success,
    required TResult Function(
            List<HazardGraphModel> hazardGraphState, String error)
        failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<HazardGraphModel> hazardGraphState)? loading,
    TResult? Function(List<HazardGraphModel> hazardGraphState)? content,
    TResult? Function(List<HazardGraphModel> hazardGraphState)? success,
    TResult? Function(List<HazardGraphModel> hazardGraphState, String error)?
        failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<HazardGraphModel> hazardGraphState)? loading,
    TResult Function(List<HazardGraphModel> hazardGraphState)? content,
    TResult Function(List<HazardGraphModel> hazardGraphState)? success,
    TResult Function(List<HazardGraphModel> hazardGraphState, String error)?
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
  $HazardGraphStateCopyWith<HazardGraphState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HazardGraphStateCopyWith<$Res> {
  factory $HazardGraphStateCopyWith(
          HazardGraphState value, $Res Function(HazardGraphState) then) =
      _$HazardGraphStateCopyWithImpl<$Res, HazardGraphState>;
  @useResult
  $Res call({List<HazardGraphModel> hazardGraphState});
}

/// @nodoc
class _$HazardGraphStateCopyWithImpl<$Res, $Val extends HazardGraphState>
    implements $HazardGraphStateCopyWith<$Res> {
  _$HazardGraphStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hazardGraphState = null,
  }) {
    return _then(_value.copyWith(
      hazardGraphState: null == hazardGraphState
          ? _value.hazardGraphState
          : hazardGraphState // ignore: cast_nullable_to_non_nullable
              as List<HazardGraphModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res>
    implements $HazardGraphStateCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<HazardGraphModel> hazardGraphState});
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$HazardGraphStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hazardGraphState = null,
  }) {
    return _then(_$LoadingImpl(
      null == hazardGraphState
          ? _value._hazardGraphState
          : hazardGraphState // ignore: cast_nullable_to_non_nullable
              as List<HazardGraphModel>,
    ));
  }
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl(final List<HazardGraphModel> hazardGraphState)
      : _hazardGraphState = hazardGraphState;

  final List<HazardGraphModel> _hazardGraphState;
  @override
  List<HazardGraphModel> get hazardGraphState {
    if (_hazardGraphState is EqualUnmodifiableListView)
      return _hazardGraphState;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_hazardGraphState);
  }

  @override
  String toString() {
    return 'HazardGraphState.loading(hazardGraphState: $hazardGraphState)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadingImpl &&
            const DeepCollectionEquality()
                .equals(other._hazardGraphState, _hazardGraphState));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_hazardGraphState));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadingImplCopyWith<_$LoadingImpl> get copyWith =>
      __$$LoadingImplCopyWithImpl<_$LoadingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<HazardGraphModel> hazardGraphState) loading,
    required TResult Function(List<HazardGraphModel> hazardGraphState) content,
    required TResult Function(List<HazardGraphModel> hazardGraphState) success,
    required TResult Function(
            List<HazardGraphModel> hazardGraphState, String error)
        failed,
  }) {
    return loading(hazardGraphState);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<HazardGraphModel> hazardGraphState)? loading,
    TResult? Function(List<HazardGraphModel> hazardGraphState)? content,
    TResult? Function(List<HazardGraphModel> hazardGraphState)? success,
    TResult? Function(List<HazardGraphModel> hazardGraphState, String error)?
        failed,
  }) {
    return loading?.call(hazardGraphState);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<HazardGraphModel> hazardGraphState)? loading,
    TResult Function(List<HazardGraphModel> hazardGraphState)? content,
    TResult Function(List<HazardGraphModel> hazardGraphState)? success,
    TResult Function(List<HazardGraphModel> hazardGraphState, String error)?
        failed,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(hazardGraphState);
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

abstract class _Loading implements HazardGraphState {
  const factory _Loading(final List<HazardGraphModel> hazardGraphState) =
      _$LoadingImpl;

  @override
  List<HazardGraphModel> get hazardGraphState;
  @override
  @JsonKey(ignore: true)
  _$$LoadingImplCopyWith<_$LoadingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ContentImplCopyWith<$Res>
    implements $HazardGraphStateCopyWith<$Res> {
  factory _$$ContentImplCopyWith(
          _$ContentImpl value, $Res Function(_$ContentImpl) then) =
      __$$ContentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<HazardGraphModel> hazardGraphState});
}

/// @nodoc
class __$$ContentImplCopyWithImpl<$Res>
    extends _$HazardGraphStateCopyWithImpl<$Res, _$ContentImpl>
    implements _$$ContentImplCopyWith<$Res> {
  __$$ContentImplCopyWithImpl(
      _$ContentImpl _value, $Res Function(_$ContentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hazardGraphState = null,
  }) {
    return _then(_$ContentImpl(
      null == hazardGraphState
          ? _value._hazardGraphState
          : hazardGraphState // ignore: cast_nullable_to_non_nullable
              as List<HazardGraphModel>,
    ));
  }
}

/// @nodoc

class _$ContentImpl implements _Content {
  const _$ContentImpl(final List<HazardGraphModel> hazardGraphState)
      : _hazardGraphState = hazardGraphState;

  final List<HazardGraphModel> _hazardGraphState;
  @override
  List<HazardGraphModel> get hazardGraphState {
    if (_hazardGraphState is EqualUnmodifiableListView)
      return _hazardGraphState;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_hazardGraphState);
  }

  @override
  String toString() {
    return 'HazardGraphState.content(hazardGraphState: $hazardGraphState)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContentImpl &&
            const DeepCollectionEquality()
                .equals(other._hazardGraphState, _hazardGraphState));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_hazardGraphState));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ContentImplCopyWith<_$ContentImpl> get copyWith =>
      __$$ContentImplCopyWithImpl<_$ContentImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<HazardGraphModel> hazardGraphState) loading,
    required TResult Function(List<HazardGraphModel> hazardGraphState) content,
    required TResult Function(List<HazardGraphModel> hazardGraphState) success,
    required TResult Function(
            List<HazardGraphModel> hazardGraphState, String error)
        failed,
  }) {
    return content(hazardGraphState);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<HazardGraphModel> hazardGraphState)? loading,
    TResult? Function(List<HazardGraphModel> hazardGraphState)? content,
    TResult? Function(List<HazardGraphModel> hazardGraphState)? success,
    TResult? Function(List<HazardGraphModel> hazardGraphState, String error)?
        failed,
  }) {
    return content?.call(hazardGraphState);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<HazardGraphModel> hazardGraphState)? loading,
    TResult Function(List<HazardGraphModel> hazardGraphState)? content,
    TResult Function(List<HazardGraphModel> hazardGraphState)? success,
    TResult Function(List<HazardGraphModel> hazardGraphState, String error)?
        failed,
    required TResult orElse(),
  }) {
    if (content != null) {
      return content(hazardGraphState);
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

abstract class _Content implements HazardGraphState {
  const factory _Content(final List<HazardGraphModel> hazardGraphState) =
      _$ContentImpl;

  @override
  List<HazardGraphModel> get hazardGraphState;
  @override
  @JsonKey(ignore: true)
  _$$ContentImplCopyWith<_$ContentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SuccessImplCopyWith<$Res>
    implements $HazardGraphStateCopyWith<$Res> {
  factory _$$SuccessImplCopyWith(
          _$SuccessImpl value, $Res Function(_$SuccessImpl) then) =
      __$$SuccessImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<HazardGraphModel> hazardGraphState});
}

/// @nodoc
class __$$SuccessImplCopyWithImpl<$Res>
    extends _$HazardGraphStateCopyWithImpl<$Res, _$SuccessImpl>
    implements _$$SuccessImplCopyWith<$Res> {
  __$$SuccessImplCopyWithImpl(
      _$SuccessImpl _value, $Res Function(_$SuccessImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hazardGraphState = null,
  }) {
    return _then(_$SuccessImpl(
      null == hazardGraphState
          ? _value._hazardGraphState
          : hazardGraphState // ignore: cast_nullable_to_non_nullable
              as List<HazardGraphModel>,
    ));
  }
}

/// @nodoc

class _$SuccessImpl implements _Success {
  const _$SuccessImpl(final List<HazardGraphModel> hazardGraphState)
      : _hazardGraphState = hazardGraphState;

  final List<HazardGraphModel> _hazardGraphState;
  @override
  List<HazardGraphModel> get hazardGraphState {
    if (_hazardGraphState is EqualUnmodifiableListView)
      return _hazardGraphState;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_hazardGraphState);
  }

  @override
  String toString() {
    return 'HazardGraphState.success(hazardGraphState: $hazardGraphState)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuccessImpl &&
            const DeepCollectionEquality()
                .equals(other._hazardGraphState, _hazardGraphState));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_hazardGraphState));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      __$$SuccessImplCopyWithImpl<_$SuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<HazardGraphModel> hazardGraphState) loading,
    required TResult Function(List<HazardGraphModel> hazardGraphState) content,
    required TResult Function(List<HazardGraphModel> hazardGraphState) success,
    required TResult Function(
            List<HazardGraphModel> hazardGraphState, String error)
        failed,
  }) {
    return success(hazardGraphState);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<HazardGraphModel> hazardGraphState)? loading,
    TResult? Function(List<HazardGraphModel> hazardGraphState)? content,
    TResult? Function(List<HazardGraphModel> hazardGraphState)? success,
    TResult? Function(List<HazardGraphModel> hazardGraphState, String error)?
        failed,
  }) {
    return success?.call(hazardGraphState);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<HazardGraphModel> hazardGraphState)? loading,
    TResult Function(List<HazardGraphModel> hazardGraphState)? content,
    TResult Function(List<HazardGraphModel> hazardGraphState)? success,
    TResult Function(List<HazardGraphModel> hazardGraphState, String error)?
        failed,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(hazardGraphState);
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

abstract class _Success implements HazardGraphState {
  const factory _Success(final List<HazardGraphModel> hazardGraphState) =
      _$SuccessImpl;

  @override
  List<HazardGraphModel> get hazardGraphState;
  @override
  @JsonKey(ignore: true)
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FailedImplCopyWith<$Res>
    implements $HazardGraphStateCopyWith<$Res> {
  factory _$$FailedImplCopyWith(
          _$FailedImpl value, $Res Function(_$FailedImpl) then) =
      __$$FailedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<HazardGraphModel> hazardGraphState, String error});
}

/// @nodoc
class __$$FailedImplCopyWithImpl<$Res>
    extends _$HazardGraphStateCopyWithImpl<$Res, _$FailedImpl>
    implements _$$FailedImplCopyWith<$Res> {
  __$$FailedImplCopyWithImpl(
      _$FailedImpl _value, $Res Function(_$FailedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hazardGraphState = null,
    Object? error = null,
  }) {
    return _then(_$FailedImpl(
      null == hazardGraphState
          ? _value._hazardGraphState
          : hazardGraphState // ignore: cast_nullable_to_non_nullable
              as List<HazardGraphModel>,
      null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$FailedImpl implements _Failed {
  const _$FailedImpl(final List<HazardGraphModel> hazardGraphState, this.error)
      : _hazardGraphState = hazardGraphState;

  final List<HazardGraphModel> _hazardGraphState;
  @override
  List<HazardGraphModel> get hazardGraphState {
    if (_hazardGraphState is EqualUnmodifiableListView)
      return _hazardGraphState;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_hazardGraphState);
  }

  @override
  final String error;

  @override
  String toString() {
    return 'HazardGraphState.failed(hazardGraphState: $hazardGraphState, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FailedImpl &&
            const DeepCollectionEquality()
                .equals(other._hazardGraphState, _hazardGraphState) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_hazardGraphState), error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FailedImplCopyWith<_$FailedImpl> get copyWith =>
      __$$FailedImplCopyWithImpl<_$FailedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<HazardGraphModel> hazardGraphState) loading,
    required TResult Function(List<HazardGraphModel> hazardGraphState) content,
    required TResult Function(List<HazardGraphModel> hazardGraphState) success,
    required TResult Function(
            List<HazardGraphModel> hazardGraphState, String error)
        failed,
  }) {
    return failed(hazardGraphState, error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<HazardGraphModel> hazardGraphState)? loading,
    TResult? Function(List<HazardGraphModel> hazardGraphState)? content,
    TResult? Function(List<HazardGraphModel> hazardGraphState)? success,
    TResult? Function(List<HazardGraphModel> hazardGraphState, String error)?
        failed,
  }) {
    return failed?.call(hazardGraphState, error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<HazardGraphModel> hazardGraphState)? loading,
    TResult Function(List<HazardGraphModel> hazardGraphState)? content,
    TResult Function(List<HazardGraphModel> hazardGraphState)? success,
    TResult Function(List<HazardGraphModel> hazardGraphState, String error)?
        failed,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed(hazardGraphState, error);
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

abstract class _Failed implements HazardGraphState {
  const factory _Failed(
          final List<HazardGraphModel> hazardGraphState, final String error) =
      _$FailedImpl;

  @override
  List<HazardGraphModel> get hazardGraphState;
  String get error;
  @override
  @JsonKey(ignore: true)
  _$$FailedImplCopyWith<_$FailedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
