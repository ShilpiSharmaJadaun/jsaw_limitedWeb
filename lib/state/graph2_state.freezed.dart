// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'graph2_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Graph2State {
  List<Graph2Model> get graph2Models => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<Graph2Model> graph2Models) loading,
    required TResult Function(List<Graph2Model> graph2Models) content,
    required TResult Function(List<Graph2Model> graph2Models) success,
    required TResult Function(List<Graph2Model> graph2Models, String error)
        failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<Graph2Model> graph2Models)? loading,
    TResult? Function(List<Graph2Model> graph2Models)? content,
    TResult? Function(List<Graph2Model> graph2Models)? success,
    TResult? Function(List<Graph2Model> graph2Models, String error)? failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<Graph2Model> graph2Models)? loading,
    TResult Function(List<Graph2Model> graph2Models)? content,
    TResult Function(List<Graph2Model> graph2Models)? success,
    TResult Function(List<Graph2Model> graph2Models, String error)? failed,
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
  $Graph2StateCopyWith<Graph2State> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $Graph2StateCopyWith<$Res> {
  factory $Graph2StateCopyWith(
          Graph2State value, $Res Function(Graph2State) then) =
      _$Graph2StateCopyWithImpl<$Res, Graph2State>;
  @useResult
  $Res call({List<Graph2Model> graph2Models});
}

/// @nodoc
class _$Graph2StateCopyWithImpl<$Res, $Val extends Graph2State>
    implements $Graph2StateCopyWith<$Res> {
  _$Graph2StateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? graph2Models = null,
  }) {
    return _then(_value.copyWith(
      graph2Models: null == graph2Models
          ? _value.graph2Models
          : graph2Models // ignore: cast_nullable_to_non_nullable
              as List<Graph2Model>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res>
    implements $Graph2StateCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Graph2Model> graph2Models});
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$Graph2StateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? graph2Models = null,
  }) {
    return _then(_$LoadingImpl(
      null == graph2Models
          ? _value._graph2Models
          : graph2Models // ignore: cast_nullable_to_non_nullable
              as List<Graph2Model>,
    ));
  }
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl(final List<Graph2Model> graph2Models)
      : _graph2Models = graph2Models;

  final List<Graph2Model> _graph2Models;
  @override
  List<Graph2Model> get graph2Models {
    if (_graph2Models is EqualUnmodifiableListView) return _graph2Models;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_graph2Models);
  }

  @override
  String toString() {
    return 'Graph2State.loading(graph2Models: $graph2Models)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadingImpl &&
            const DeepCollectionEquality()
                .equals(other._graph2Models, _graph2Models));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_graph2Models));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadingImplCopyWith<_$LoadingImpl> get copyWith =>
      __$$LoadingImplCopyWithImpl<_$LoadingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<Graph2Model> graph2Models) loading,
    required TResult Function(List<Graph2Model> graph2Models) content,
    required TResult Function(List<Graph2Model> graph2Models) success,
    required TResult Function(List<Graph2Model> graph2Models, String error)
        failed,
  }) {
    return loading(graph2Models);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<Graph2Model> graph2Models)? loading,
    TResult? Function(List<Graph2Model> graph2Models)? content,
    TResult? Function(List<Graph2Model> graph2Models)? success,
    TResult? Function(List<Graph2Model> graph2Models, String error)? failed,
  }) {
    return loading?.call(graph2Models);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<Graph2Model> graph2Models)? loading,
    TResult Function(List<Graph2Model> graph2Models)? content,
    TResult Function(List<Graph2Model> graph2Models)? success,
    TResult Function(List<Graph2Model> graph2Models, String error)? failed,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(graph2Models);
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

abstract class _Loading implements Graph2State {
  const factory _Loading(final List<Graph2Model> graph2Models) = _$LoadingImpl;

  @override
  List<Graph2Model> get graph2Models;
  @override
  @JsonKey(ignore: true)
  _$$LoadingImplCopyWith<_$LoadingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ContentImplCopyWith<$Res>
    implements $Graph2StateCopyWith<$Res> {
  factory _$$ContentImplCopyWith(
          _$ContentImpl value, $Res Function(_$ContentImpl) then) =
      __$$ContentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Graph2Model> graph2Models});
}

/// @nodoc
class __$$ContentImplCopyWithImpl<$Res>
    extends _$Graph2StateCopyWithImpl<$Res, _$ContentImpl>
    implements _$$ContentImplCopyWith<$Res> {
  __$$ContentImplCopyWithImpl(
      _$ContentImpl _value, $Res Function(_$ContentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? graph2Models = null,
  }) {
    return _then(_$ContentImpl(
      null == graph2Models
          ? _value._graph2Models
          : graph2Models // ignore: cast_nullable_to_non_nullable
              as List<Graph2Model>,
    ));
  }
}

/// @nodoc

class _$ContentImpl implements _Content {
  const _$ContentImpl(final List<Graph2Model> graph2Models)
      : _graph2Models = graph2Models;

  final List<Graph2Model> _graph2Models;
  @override
  List<Graph2Model> get graph2Models {
    if (_graph2Models is EqualUnmodifiableListView) return _graph2Models;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_graph2Models);
  }

  @override
  String toString() {
    return 'Graph2State.content(graph2Models: $graph2Models)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContentImpl &&
            const DeepCollectionEquality()
                .equals(other._graph2Models, _graph2Models));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_graph2Models));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ContentImplCopyWith<_$ContentImpl> get copyWith =>
      __$$ContentImplCopyWithImpl<_$ContentImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<Graph2Model> graph2Models) loading,
    required TResult Function(List<Graph2Model> graph2Models) content,
    required TResult Function(List<Graph2Model> graph2Models) success,
    required TResult Function(List<Graph2Model> graph2Models, String error)
        failed,
  }) {
    return content(graph2Models);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<Graph2Model> graph2Models)? loading,
    TResult? Function(List<Graph2Model> graph2Models)? content,
    TResult? Function(List<Graph2Model> graph2Models)? success,
    TResult? Function(List<Graph2Model> graph2Models, String error)? failed,
  }) {
    return content?.call(graph2Models);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<Graph2Model> graph2Models)? loading,
    TResult Function(List<Graph2Model> graph2Models)? content,
    TResult Function(List<Graph2Model> graph2Models)? success,
    TResult Function(List<Graph2Model> graph2Models, String error)? failed,
    required TResult orElse(),
  }) {
    if (content != null) {
      return content(graph2Models);
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

abstract class _Content implements Graph2State {
  const factory _Content(final List<Graph2Model> graph2Models) = _$ContentImpl;

  @override
  List<Graph2Model> get graph2Models;
  @override
  @JsonKey(ignore: true)
  _$$ContentImplCopyWith<_$ContentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SuccessImplCopyWith<$Res>
    implements $Graph2StateCopyWith<$Res> {
  factory _$$SuccessImplCopyWith(
          _$SuccessImpl value, $Res Function(_$SuccessImpl) then) =
      __$$SuccessImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Graph2Model> graph2Models});
}

/// @nodoc
class __$$SuccessImplCopyWithImpl<$Res>
    extends _$Graph2StateCopyWithImpl<$Res, _$SuccessImpl>
    implements _$$SuccessImplCopyWith<$Res> {
  __$$SuccessImplCopyWithImpl(
      _$SuccessImpl _value, $Res Function(_$SuccessImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? graph2Models = null,
  }) {
    return _then(_$SuccessImpl(
      null == graph2Models
          ? _value._graph2Models
          : graph2Models // ignore: cast_nullable_to_non_nullable
              as List<Graph2Model>,
    ));
  }
}

/// @nodoc

class _$SuccessImpl implements _Success {
  const _$SuccessImpl(final List<Graph2Model> graph2Models)
      : _graph2Models = graph2Models;

  final List<Graph2Model> _graph2Models;
  @override
  List<Graph2Model> get graph2Models {
    if (_graph2Models is EqualUnmodifiableListView) return _graph2Models;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_graph2Models);
  }

  @override
  String toString() {
    return 'Graph2State.success(graph2Models: $graph2Models)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuccessImpl &&
            const DeepCollectionEquality()
                .equals(other._graph2Models, _graph2Models));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_graph2Models));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      __$$SuccessImplCopyWithImpl<_$SuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<Graph2Model> graph2Models) loading,
    required TResult Function(List<Graph2Model> graph2Models) content,
    required TResult Function(List<Graph2Model> graph2Models) success,
    required TResult Function(List<Graph2Model> graph2Models, String error)
        failed,
  }) {
    return success(graph2Models);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<Graph2Model> graph2Models)? loading,
    TResult? Function(List<Graph2Model> graph2Models)? content,
    TResult? Function(List<Graph2Model> graph2Models)? success,
    TResult? Function(List<Graph2Model> graph2Models, String error)? failed,
  }) {
    return success?.call(graph2Models);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<Graph2Model> graph2Models)? loading,
    TResult Function(List<Graph2Model> graph2Models)? content,
    TResult Function(List<Graph2Model> graph2Models)? success,
    TResult Function(List<Graph2Model> graph2Models, String error)? failed,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(graph2Models);
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

abstract class _Success implements Graph2State {
  const factory _Success(final List<Graph2Model> graph2Models) = _$SuccessImpl;

  @override
  List<Graph2Model> get graph2Models;
  @override
  @JsonKey(ignore: true)
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FailedImplCopyWith<$Res>
    implements $Graph2StateCopyWith<$Res> {
  factory _$$FailedImplCopyWith(
          _$FailedImpl value, $Res Function(_$FailedImpl) then) =
      __$$FailedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Graph2Model> graph2Models, String error});
}

/// @nodoc
class __$$FailedImplCopyWithImpl<$Res>
    extends _$Graph2StateCopyWithImpl<$Res, _$FailedImpl>
    implements _$$FailedImplCopyWith<$Res> {
  __$$FailedImplCopyWithImpl(
      _$FailedImpl _value, $Res Function(_$FailedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? graph2Models = null,
    Object? error = null,
  }) {
    return _then(_$FailedImpl(
      null == graph2Models
          ? _value._graph2Models
          : graph2Models // ignore: cast_nullable_to_non_nullable
              as List<Graph2Model>,
      null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$FailedImpl implements _Failed {
  const _$FailedImpl(final List<Graph2Model> graph2Models, this.error)
      : _graph2Models = graph2Models;

  final List<Graph2Model> _graph2Models;
  @override
  List<Graph2Model> get graph2Models {
    if (_graph2Models is EqualUnmodifiableListView) return _graph2Models;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_graph2Models);
  }

  @override
  final String error;

  @override
  String toString() {
    return 'Graph2State.failed(graph2Models: $graph2Models, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FailedImpl &&
            const DeepCollectionEquality()
                .equals(other._graph2Models, _graph2Models) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_graph2Models), error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FailedImplCopyWith<_$FailedImpl> get copyWith =>
      __$$FailedImplCopyWithImpl<_$FailedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<Graph2Model> graph2Models) loading,
    required TResult Function(List<Graph2Model> graph2Models) content,
    required TResult Function(List<Graph2Model> graph2Models) success,
    required TResult Function(List<Graph2Model> graph2Models, String error)
        failed,
  }) {
    return failed(graph2Models, error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<Graph2Model> graph2Models)? loading,
    TResult? Function(List<Graph2Model> graph2Models)? content,
    TResult? Function(List<Graph2Model> graph2Models)? success,
    TResult? Function(List<Graph2Model> graph2Models, String error)? failed,
  }) {
    return failed?.call(graph2Models, error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<Graph2Model> graph2Models)? loading,
    TResult Function(List<Graph2Model> graph2Models)? content,
    TResult Function(List<Graph2Model> graph2Models)? success,
    TResult Function(List<Graph2Model> graph2Models, String error)? failed,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed(graph2Models, error);
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

abstract class _Failed implements Graph2State {
  const factory _Failed(
      final List<Graph2Model> graph2Models, final String error) = _$FailedImpl;

  @override
  List<Graph2Model> get graph2Models;
  String get error;
  @override
  @JsonKey(ignore: true)
  _$$FailedImplCopyWith<_$FailedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
