// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stationwise_graphtable_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$StationWiseGraphTableState {
  List<StationWiseGraphTableModel> get stationwiseTable =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<StationWiseGraphTableModel> stationwiseTable)
        loading,
    required TResult Function(List<StationWiseGraphTableModel> stationwiseTable)
        content,
    required TResult Function(List<StationWiseGraphTableModel> stationwiseTable)
        success,
    required TResult Function(
            List<StationWiseGraphTableModel> stationwiseTable, String message)
        failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<StationWiseGraphTableModel> stationwiseTable)?
        loading,
    TResult? Function(List<StationWiseGraphTableModel> stationwiseTable)?
        content,
    TResult? Function(List<StationWiseGraphTableModel> stationwiseTable)?
        success,
    TResult? Function(
            List<StationWiseGraphTableModel> stationwiseTable, String message)?
        failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<StationWiseGraphTableModel> stationwiseTable)?
        loading,
    TResult Function(List<StationWiseGraphTableModel> stationwiseTable)?
        content,
    TResult Function(List<StationWiseGraphTableModel> stationwiseTable)?
        success,
    TResult Function(
            List<StationWiseGraphTableModel> stationwiseTable, String message)?
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
  $StationWiseGraphTableStateCopyWith<StationWiseGraphTableState>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StationWiseGraphTableStateCopyWith<$Res> {
  factory $StationWiseGraphTableStateCopyWith(StationWiseGraphTableState value,
          $Res Function(StationWiseGraphTableState) then) =
      _$StationWiseGraphTableStateCopyWithImpl<$Res,
          StationWiseGraphTableState>;
  @useResult
  $Res call({List<StationWiseGraphTableModel> stationwiseTable});
}

/// @nodoc
class _$StationWiseGraphTableStateCopyWithImpl<$Res,
        $Val extends StationWiseGraphTableState>
    implements $StationWiseGraphTableStateCopyWith<$Res> {
  _$StationWiseGraphTableStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stationwiseTable = null,
  }) {
    return _then(_value.copyWith(
      stationwiseTable: null == stationwiseTable
          ? _value.stationwiseTable
          : stationwiseTable // ignore: cast_nullable_to_non_nullable
              as List<StationWiseGraphTableModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res>
    implements $StationWiseGraphTableStateCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<StationWiseGraphTableModel> stationwiseTable});
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$StationWiseGraphTableStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stationwiseTable = null,
  }) {
    return _then(_$LoadingImpl(
      null == stationwiseTable
          ? _value._stationwiseTable
          : stationwiseTable // ignore: cast_nullable_to_non_nullable
              as List<StationWiseGraphTableModel>,
    ));
  }
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl(final List<StationWiseGraphTableModel> stationwiseTable)
      : _stationwiseTable = stationwiseTable;

  final List<StationWiseGraphTableModel> _stationwiseTable;
  @override
  List<StationWiseGraphTableModel> get stationwiseTable {
    if (_stationwiseTable is EqualUnmodifiableListView)
      return _stationwiseTable;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_stationwiseTable);
  }

  @override
  String toString() {
    return 'StationWiseGraphTableState.loading(stationwiseTable: $stationwiseTable)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadingImpl &&
            const DeepCollectionEquality()
                .equals(other._stationwiseTable, _stationwiseTable));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_stationwiseTable));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadingImplCopyWith<_$LoadingImpl> get copyWith =>
      __$$LoadingImplCopyWithImpl<_$LoadingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<StationWiseGraphTableModel> stationwiseTable)
        loading,
    required TResult Function(List<StationWiseGraphTableModel> stationwiseTable)
        content,
    required TResult Function(List<StationWiseGraphTableModel> stationwiseTable)
        success,
    required TResult Function(
            List<StationWiseGraphTableModel> stationwiseTable, String message)
        failed,
  }) {
    return loading(stationwiseTable);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<StationWiseGraphTableModel> stationwiseTable)?
        loading,
    TResult? Function(List<StationWiseGraphTableModel> stationwiseTable)?
        content,
    TResult? Function(List<StationWiseGraphTableModel> stationwiseTable)?
        success,
    TResult? Function(
            List<StationWiseGraphTableModel> stationwiseTable, String message)?
        failed,
  }) {
    return loading?.call(stationwiseTable);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<StationWiseGraphTableModel> stationwiseTable)?
        loading,
    TResult Function(List<StationWiseGraphTableModel> stationwiseTable)?
        content,
    TResult Function(List<StationWiseGraphTableModel> stationwiseTable)?
        success,
    TResult Function(
            List<StationWiseGraphTableModel> stationwiseTable, String message)?
        failed,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(stationwiseTable);
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

abstract class _Loading implements StationWiseGraphTableState {
  const factory _Loading(
      final List<StationWiseGraphTableModel> stationwiseTable) = _$LoadingImpl;

  @override
  List<StationWiseGraphTableModel> get stationwiseTable;
  @override
  @JsonKey(ignore: true)
  _$$LoadingImplCopyWith<_$LoadingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ContentImplCopyWith<$Res>
    implements $StationWiseGraphTableStateCopyWith<$Res> {
  factory _$$ContentImplCopyWith(
          _$ContentImpl value, $Res Function(_$ContentImpl) then) =
      __$$ContentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<StationWiseGraphTableModel> stationwiseTable});
}

/// @nodoc
class __$$ContentImplCopyWithImpl<$Res>
    extends _$StationWiseGraphTableStateCopyWithImpl<$Res, _$ContentImpl>
    implements _$$ContentImplCopyWith<$Res> {
  __$$ContentImplCopyWithImpl(
      _$ContentImpl _value, $Res Function(_$ContentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stationwiseTable = null,
  }) {
    return _then(_$ContentImpl(
      null == stationwiseTable
          ? _value._stationwiseTable
          : stationwiseTable // ignore: cast_nullable_to_non_nullable
              as List<StationWiseGraphTableModel>,
    ));
  }
}

/// @nodoc

class _$ContentImpl implements _Content {
  const _$ContentImpl(final List<StationWiseGraphTableModel> stationwiseTable)
      : _stationwiseTable = stationwiseTable;

  final List<StationWiseGraphTableModel> _stationwiseTable;
  @override
  List<StationWiseGraphTableModel> get stationwiseTable {
    if (_stationwiseTable is EqualUnmodifiableListView)
      return _stationwiseTable;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_stationwiseTable);
  }

  @override
  String toString() {
    return 'StationWiseGraphTableState.content(stationwiseTable: $stationwiseTable)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContentImpl &&
            const DeepCollectionEquality()
                .equals(other._stationwiseTable, _stationwiseTable));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_stationwiseTable));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ContentImplCopyWith<_$ContentImpl> get copyWith =>
      __$$ContentImplCopyWithImpl<_$ContentImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<StationWiseGraphTableModel> stationwiseTable)
        loading,
    required TResult Function(List<StationWiseGraphTableModel> stationwiseTable)
        content,
    required TResult Function(List<StationWiseGraphTableModel> stationwiseTable)
        success,
    required TResult Function(
            List<StationWiseGraphTableModel> stationwiseTable, String message)
        failed,
  }) {
    return content(stationwiseTable);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<StationWiseGraphTableModel> stationwiseTable)?
        loading,
    TResult? Function(List<StationWiseGraphTableModel> stationwiseTable)?
        content,
    TResult? Function(List<StationWiseGraphTableModel> stationwiseTable)?
        success,
    TResult? Function(
            List<StationWiseGraphTableModel> stationwiseTable, String message)?
        failed,
  }) {
    return content?.call(stationwiseTable);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<StationWiseGraphTableModel> stationwiseTable)?
        loading,
    TResult Function(List<StationWiseGraphTableModel> stationwiseTable)?
        content,
    TResult Function(List<StationWiseGraphTableModel> stationwiseTable)?
        success,
    TResult Function(
            List<StationWiseGraphTableModel> stationwiseTable, String message)?
        failed,
    required TResult orElse(),
  }) {
    if (content != null) {
      return content(stationwiseTable);
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

abstract class _Content implements StationWiseGraphTableState {
  const factory _Content(
      final List<StationWiseGraphTableModel> stationwiseTable) = _$ContentImpl;

  @override
  List<StationWiseGraphTableModel> get stationwiseTable;
  @override
  @JsonKey(ignore: true)
  _$$ContentImplCopyWith<_$ContentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SuccessImplCopyWith<$Res>
    implements $StationWiseGraphTableStateCopyWith<$Res> {
  factory _$$SuccessImplCopyWith(
          _$SuccessImpl value, $Res Function(_$SuccessImpl) then) =
      __$$SuccessImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<StationWiseGraphTableModel> stationwiseTable});
}

/// @nodoc
class __$$SuccessImplCopyWithImpl<$Res>
    extends _$StationWiseGraphTableStateCopyWithImpl<$Res, _$SuccessImpl>
    implements _$$SuccessImplCopyWith<$Res> {
  __$$SuccessImplCopyWithImpl(
      _$SuccessImpl _value, $Res Function(_$SuccessImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stationwiseTable = null,
  }) {
    return _then(_$SuccessImpl(
      null == stationwiseTable
          ? _value._stationwiseTable
          : stationwiseTable // ignore: cast_nullable_to_non_nullable
              as List<StationWiseGraphTableModel>,
    ));
  }
}

/// @nodoc

class _$SuccessImpl implements _Success {
  const _$SuccessImpl(final List<StationWiseGraphTableModel> stationwiseTable)
      : _stationwiseTable = stationwiseTable;

  final List<StationWiseGraphTableModel> _stationwiseTable;
  @override
  List<StationWiseGraphTableModel> get stationwiseTable {
    if (_stationwiseTable is EqualUnmodifiableListView)
      return _stationwiseTable;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_stationwiseTable);
  }

  @override
  String toString() {
    return 'StationWiseGraphTableState.success(stationwiseTable: $stationwiseTable)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuccessImpl &&
            const DeepCollectionEquality()
                .equals(other._stationwiseTable, _stationwiseTable));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_stationwiseTable));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      __$$SuccessImplCopyWithImpl<_$SuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<StationWiseGraphTableModel> stationwiseTable)
        loading,
    required TResult Function(List<StationWiseGraphTableModel> stationwiseTable)
        content,
    required TResult Function(List<StationWiseGraphTableModel> stationwiseTable)
        success,
    required TResult Function(
            List<StationWiseGraphTableModel> stationwiseTable, String message)
        failed,
  }) {
    return success(stationwiseTable);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<StationWiseGraphTableModel> stationwiseTable)?
        loading,
    TResult? Function(List<StationWiseGraphTableModel> stationwiseTable)?
        content,
    TResult? Function(List<StationWiseGraphTableModel> stationwiseTable)?
        success,
    TResult? Function(
            List<StationWiseGraphTableModel> stationwiseTable, String message)?
        failed,
  }) {
    return success?.call(stationwiseTable);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<StationWiseGraphTableModel> stationwiseTable)?
        loading,
    TResult Function(List<StationWiseGraphTableModel> stationwiseTable)?
        content,
    TResult Function(List<StationWiseGraphTableModel> stationwiseTable)?
        success,
    TResult Function(
            List<StationWiseGraphTableModel> stationwiseTable, String message)?
        failed,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(stationwiseTable);
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

abstract class _Success implements StationWiseGraphTableState {
  const factory _Success(
      final List<StationWiseGraphTableModel> stationwiseTable) = _$SuccessImpl;

  @override
  List<StationWiseGraphTableModel> get stationwiseTable;
  @override
  @JsonKey(ignore: true)
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FailedImplCopyWith<$Res>
    implements $StationWiseGraphTableStateCopyWith<$Res> {
  factory _$$FailedImplCopyWith(
          _$FailedImpl value, $Res Function(_$FailedImpl) then) =
      __$$FailedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<StationWiseGraphTableModel> stationwiseTable, String message});
}

/// @nodoc
class __$$FailedImplCopyWithImpl<$Res>
    extends _$StationWiseGraphTableStateCopyWithImpl<$Res, _$FailedImpl>
    implements _$$FailedImplCopyWith<$Res> {
  __$$FailedImplCopyWithImpl(
      _$FailedImpl _value, $Res Function(_$FailedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stationwiseTable = null,
    Object? message = null,
  }) {
    return _then(_$FailedImpl(
      null == stationwiseTable
          ? _value._stationwiseTable
          : stationwiseTable // ignore: cast_nullable_to_non_nullable
              as List<StationWiseGraphTableModel>,
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$FailedImpl implements _Failed {
  const _$FailedImpl(
      final List<StationWiseGraphTableModel> stationwiseTable, this.message)
      : _stationwiseTable = stationwiseTable;

  final List<StationWiseGraphTableModel> _stationwiseTable;
  @override
  List<StationWiseGraphTableModel> get stationwiseTable {
    if (_stationwiseTable is EqualUnmodifiableListView)
      return _stationwiseTable;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_stationwiseTable);
  }

  @override
  final String message;

  @override
  String toString() {
    return 'StationWiseGraphTableState.failed(stationwiseTable: $stationwiseTable, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FailedImpl &&
            const DeepCollectionEquality()
                .equals(other._stationwiseTable, _stationwiseTable) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_stationwiseTable), message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FailedImplCopyWith<_$FailedImpl> get copyWith =>
      __$$FailedImplCopyWithImpl<_$FailedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<StationWiseGraphTableModel> stationwiseTable)
        loading,
    required TResult Function(List<StationWiseGraphTableModel> stationwiseTable)
        content,
    required TResult Function(List<StationWiseGraphTableModel> stationwiseTable)
        success,
    required TResult Function(
            List<StationWiseGraphTableModel> stationwiseTable, String message)
        failed,
  }) {
    return failed(stationwiseTable, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<StationWiseGraphTableModel> stationwiseTable)?
        loading,
    TResult? Function(List<StationWiseGraphTableModel> stationwiseTable)?
        content,
    TResult? Function(List<StationWiseGraphTableModel> stationwiseTable)?
        success,
    TResult? Function(
            List<StationWiseGraphTableModel> stationwiseTable, String message)?
        failed,
  }) {
    return failed?.call(stationwiseTable, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<StationWiseGraphTableModel> stationwiseTable)?
        loading,
    TResult Function(List<StationWiseGraphTableModel> stationwiseTable)?
        content,
    TResult Function(List<StationWiseGraphTableModel> stationwiseTable)?
        success,
    TResult Function(
            List<StationWiseGraphTableModel> stationwiseTable, String message)?
        failed,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed(stationwiseTable, message);
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

abstract class _Failed implements StationWiseGraphTableState {
  const factory _Failed(final List<StationWiseGraphTableModel> stationwiseTable,
      final String message) = _$FailedImpl;

  @override
  List<StationWiseGraphTableModel> get stationwiseTable;
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$FailedImplCopyWith<_$FailedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
