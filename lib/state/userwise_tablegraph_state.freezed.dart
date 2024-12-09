// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'userwise_tablegraph_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$UserWiseTableGraphState {
  List<UserWiseTableGraphModel> get userWiseTable =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<UserWiseTableGraphModel> userWiseTable)
        loading,
    required TResult Function(List<UserWiseTableGraphModel> userWiseTable)
        content,
    required TResult Function(List<UserWiseTableGraphModel> userWiseTable)
        success,
    required TResult Function(
            List<UserWiseTableGraphModel> userWiseTable, String message)
        failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<UserWiseTableGraphModel> userWiseTable)? loading,
    TResult? Function(List<UserWiseTableGraphModel> userWiseTable)? content,
    TResult? Function(List<UserWiseTableGraphModel> userWiseTable)? success,
    TResult? Function(
            List<UserWiseTableGraphModel> userWiseTable, String message)?
        failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<UserWiseTableGraphModel> userWiseTable)? loading,
    TResult Function(List<UserWiseTableGraphModel> userWiseTable)? content,
    TResult Function(List<UserWiseTableGraphModel> userWiseTable)? success,
    TResult Function(
            List<UserWiseTableGraphModel> userWiseTable, String message)?
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
  $UserWiseTableGraphStateCopyWith<UserWiseTableGraphState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserWiseTableGraphStateCopyWith<$Res> {
  factory $UserWiseTableGraphStateCopyWith(UserWiseTableGraphState value,
          $Res Function(UserWiseTableGraphState) then) =
      _$UserWiseTableGraphStateCopyWithImpl<$Res, UserWiseTableGraphState>;
  @useResult
  $Res call({List<UserWiseTableGraphModel> userWiseTable});
}

/// @nodoc
class _$UserWiseTableGraphStateCopyWithImpl<$Res,
        $Val extends UserWiseTableGraphState>
    implements $UserWiseTableGraphStateCopyWith<$Res> {
  _$UserWiseTableGraphStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userWiseTable = null,
  }) {
    return _then(_value.copyWith(
      userWiseTable: null == userWiseTable
          ? _value.userWiseTable
          : userWiseTable // ignore: cast_nullable_to_non_nullable
              as List<UserWiseTableGraphModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res>
    implements $UserWiseTableGraphStateCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<UserWiseTableGraphModel> userWiseTable});
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$UserWiseTableGraphStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userWiseTable = null,
  }) {
    return _then(_$LoadingImpl(
      null == userWiseTable
          ? _value._userWiseTable
          : userWiseTable // ignore: cast_nullable_to_non_nullable
              as List<UserWiseTableGraphModel>,
    ));
  }
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl(final List<UserWiseTableGraphModel> userWiseTable)
      : _userWiseTable = userWiseTable;

  final List<UserWiseTableGraphModel> _userWiseTable;
  @override
  List<UserWiseTableGraphModel> get userWiseTable {
    if (_userWiseTable is EqualUnmodifiableListView) return _userWiseTable;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_userWiseTable);
  }

  @override
  String toString() {
    return 'UserWiseTableGraphState.loading(userWiseTable: $userWiseTable)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadingImpl &&
            const DeepCollectionEquality()
                .equals(other._userWiseTable, _userWiseTable));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_userWiseTable));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadingImplCopyWith<_$LoadingImpl> get copyWith =>
      __$$LoadingImplCopyWithImpl<_$LoadingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<UserWiseTableGraphModel> userWiseTable)
        loading,
    required TResult Function(List<UserWiseTableGraphModel> userWiseTable)
        content,
    required TResult Function(List<UserWiseTableGraphModel> userWiseTable)
        success,
    required TResult Function(
            List<UserWiseTableGraphModel> userWiseTable, String message)
        failed,
  }) {
    return loading(userWiseTable);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<UserWiseTableGraphModel> userWiseTable)? loading,
    TResult? Function(List<UserWiseTableGraphModel> userWiseTable)? content,
    TResult? Function(List<UserWiseTableGraphModel> userWiseTable)? success,
    TResult? Function(
            List<UserWiseTableGraphModel> userWiseTable, String message)?
        failed,
  }) {
    return loading?.call(userWiseTable);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<UserWiseTableGraphModel> userWiseTable)? loading,
    TResult Function(List<UserWiseTableGraphModel> userWiseTable)? content,
    TResult Function(List<UserWiseTableGraphModel> userWiseTable)? success,
    TResult Function(
            List<UserWiseTableGraphModel> userWiseTable, String message)?
        failed,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(userWiseTable);
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

abstract class _Loading implements UserWiseTableGraphState {
  const factory _Loading(final List<UserWiseTableGraphModel> userWiseTable) =
      _$LoadingImpl;

  @override
  List<UserWiseTableGraphModel> get userWiseTable;
  @override
  @JsonKey(ignore: true)
  _$$LoadingImplCopyWith<_$LoadingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ContentImplCopyWith<$Res>
    implements $UserWiseTableGraphStateCopyWith<$Res> {
  factory _$$ContentImplCopyWith(
          _$ContentImpl value, $Res Function(_$ContentImpl) then) =
      __$$ContentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<UserWiseTableGraphModel> userWiseTable});
}

/// @nodoc
class __$$ContentImplCopyWithImpl<$Res>
    extends _$UserWiseTableGraphStateCopyWithImpl<$Res, _$ContentImpl>
    implements _$$ContentImplCopyWith<$Res> {
  __$$ContentImplCopyWithImpl(
      _$ContentImpl _value, $Res Function(_$ContentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userWiseTable = null,
  }) {
    return _then(_$ContentImpl(
      null == userWiseTable
          ? _value._userWiseTable
          : userWiseTable // ignore: cast_nullable_to_non_nullable
              as List<UserWiseTableGraphModel>,
    ));
  }
}

/// @nodoc

class _$ContentImpl implements _Content {
  const _$ContentImpl(final List<UserWiseTableGraphModel> userWiseTable)
      : _userWiseTable = userWiseTable;

  final List<UserWiseTableGraphModel> _userWiseTable;
  @override
  List<UserWiseTableGraphModel> get userWiseTable {
    if (_userWiseTable is EqualUnmodifiableListView) return _userWiseTable;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_userWiseTable);
  }

  @override
  String toString() {
    return 'UserWiseTableGraphState.content(userWiseTable: $userWiseTable)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContentImpl &&
            const DeepCollectionEquality()
                .equals(other._userWiseTable, _userWiseTable));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_userWiseTable));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ContentImplCopyWith<_$ContentImpl> get copyWith =>
      __$$ContentImplCopyWithImpl<_$ContentImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<UserWiseTableGraphModel> userWiseTable)
        loading,
    required TResult Function(List<UserWiseTableGraphModel> userWiseTable)
        content,
    required TResult Function(List<UserWiseTableGraphModel> userWiseTable)
        success,
    required TResult Function(
            List<UserWiseTableGraphModel> userWiseTable, String message)
        failed,
  }) {
    return content(userWiseTable);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<UserWiseTableGraphModel> userWiseTable)? loading,
    TResult? Function(List<UserWiseTableGraphModel> userWiseTable)? content,
    TResult? Function(List<UserWiseTableGraphModel> userWiseTable)? success,
    TResult? Function(
            List<UserWiseTableGraphModel> userWiseTable, String message)?
        failed,
  }) {
    return content?.call(userWiseTable);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<UserWiseTableGraphModel> userWiseTable)? loading,
    TResult Function(List<UserWiseTableGraphModel> userWiseTable)? content,
    TResult Function(List<UserWiseTableGraphModel> userWiseTable)? success,
    TResult Function(
            List<UserWiseTableGraphModel> userWiseTable, String message)?
        failed,
    required TResult orElse(),
  }) {
    if (content != null) {
      return content(userWiseTable);
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

abstract class _Content implements UserWiseTableGraphState {
  const factory _Content(final List<UserWiseTableGraphModel> userWiseTable) =
      _$ContentImpl;

  @override
  List<UserWiseTableGraphModel> get userWiseTable;
  @override
  @JsonKey(ignore: true)
  _$$ContentImplCopyWith<_$ContentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SuccessImplCopyWith<$Res>
    implements $UserWiseTableGraphStateCopyWith<$Res> {
  factory _$$SuccessImplCopyWith(
          _$SuccessImpl value, $Res Function(_$SuccessImpl) then) =
      __$$SuccessImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<UserWiseTableGraphModel> userWiseTable});
}

/// @nodoc
class __$$SuccessImplCopyWithImpl<$Res>
    extends _$UserWiseTableGraphStateCopyWithImpl<$Res, _$SuccessImpl>
    implements _$$SuccessImplCopyWith<$Res> {
  __$$SuccessImplCopyWithImpl(
      _$SuccessImpl _value, $Res Function(_$SuccessImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userWiseTable = null,
  }) {
    return _then(_$SuccessImpl(
      null == userWiseTable
          ? _value._userWiseTable
          : userWiseTable // ignore: cast_nullable_to_non_nullable
              as List<UserWiseTableGraphModel>,
    ));
  }
}

/// @nodoc

class _$SuccessImpl implements _Success {
  const _$SuccessImpl(final List<UserWiseTableGraphModel> userWiseTable)
      : _userWiseTable = userWiseTable;

  final List<UserWiseTableGraphModel> _userWiseTable;
  @override
  List<UserWiseTableGraphModel> get userWiseTable {
    if (_userWiseTable is EqualUnmodifiableListView) return _userWiseTable;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_userWiseTable);
  }

  @override
  String toString() {
    return 'UserWiseTableGraphState.success(userWiseTable: $userWiseTable)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuccessImpl &&
            const DeepCollectionEquality()
                .equals(other._userWiseTable, _userWiseTable));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_userWiseTable));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      __$$SuccessImplCopyWithImpl<_$SuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<UserWiseTableGraphModel> userWiseTable)
        loading,
    required TResult Function(List<UserWiseTableGraphModel> userWiseTable)
        content,
    required TResult Function(List<UserWiseTableGraphModel> userWiseTable)
        success,
    required TResult Function(
            List<UserWiseTableGraphModel> userWiseTable, String message)
        failed,
  }) {
    return success(userWiseTable);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<UserWiseTableGraphModel> userWiseTable)? loading,
    TResult? Function(List<UserWiseTableGraphModel> userWiseTable)? content,
    TResult? Function(List<UserWiseTableGraphModel> userWiseTable)? success,
    TResult? Function(
            List<UserWiseTableGraphModel> userWiseTable, String message)?
        failed,
  }) {
    return success?.call(userWiseTable);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<UserWiseTableGraphModel> userWiseTable)? loading,
    TResult Function(List<UserWiseTableGraphModel> userWiseTable)? content,
    TResult Function(List<UserWiseTableGraphModel> userWiseTable)? success,
    TResult Function(
            List<UserWiseTableGraphModel> userWiseTable, String message)?
        failed,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(userWiseTable);
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

abstract class _Success implements UserWiseTableGraphState {
  const factory _Success(final List<UserWiseTableGraphModel> userWiseTable) =
      _$SuccessImpl;

  @override
  List<UserWiseTableGraphModel> get userWiseTable;
  @override
  @JsonKey(ignore: true)
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FailedImplCopyWith<$Res>
    implements $UserWiseTableGraphStateCopyWith<$Res> {
  factory _$$FailedImplCopyWith(
          _$FailedImpl value, $Res Function(_$FailedImpl) then) =
      __$$FailedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<UserWiseTableGraphModel> userWiseTable, String message});
}

/// @nodoc
class __$$FailedImplCopyWithImpl<$Res>
    extends _$UserWiseTableGraphStateCopyWithImpl<$Res, _$FailedImpl>
    implements _$$FailedImplCopyWith<$Res> {
  __$$FailedImplCopyWithImpl(
      _$FailedImpl _value, $Res Function(_$FailedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userWiseTable = null,
    Object? message = null,
  }) {
    return _then(_$FailedImpl(
      null == userWiseTable
          ? _value._userWiseTable
          : userWiseTable // ignore: cast_nullable_to_non_nullable
              as List<UserWiseTableGraphModel>,
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
      final List<UserWiseTableGraphModel> userWiseTable, this.message)
      : _userWiseTable = userWiseTable;

  final List<UserWiseTableGraphModel> _userWiseTable;
  @override
  List<UserWiseTableGraphModel> get userWiseTable {
    if (_userWiseTable is EqualUnmodifiableListView) return _userWiseTable;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_userWiseTable);
  }

  @override
  final String message;

  @override
  String toString() {
    return 'UserWiseTableGraphState.failed(userWiseTable: $userWiseTable, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FailedImpl &&
            const DeepCollectionEquality()
                .equals(other._userWiseTable, _userWiseTable) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_userWiseTable), message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FailedImplCopyWith<_$FailedImpl> get copyWith =>
      __$$FailedImplCopyWithImpl<_$FailedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<UserWiseTableGraphModel> userWiseTable)
        loading,
    required TResult Function(List<UserWiseTableGraphModel> userWiseTable)
        content,
    required TResult Function(List<UserWiseTableGraphModel> userWiseTable)
        success,
    required TResult Function(
            List<UserWiseTableGraphModel> userWiseTable, String message)
        failed,
  }) {
    return failed(userWiseTable, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<UserWiseTableGraphModel> userWiseTable)? loading,
    TResult? Function(List<UserWiseTableGraphModel> userWiseTable)? content,
    TResult? Function(List<UserWiseTableGraphModel> userWiseTable)? success,
    TResult? Function(
            List<UserWiseTableGraphModel> userWiseTable, String message)?
        failed,
  }) {
    return failed?.call(userWiseTable, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<UserWiseTableGraphModel> userWiseTable)? loading,
    TResult Function(List<UserWiseTableGraphModel> userWiseTable)? content,
    TResult Function(List<UserWiseTableGraphModel> userWiseTable)? success,
    TResult Function(
            List<UserWiseTableGraphModel> userWiseTable, String message)?
        failed,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed(userWiseTable, message);
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

abstract class _Failed implements UserWiseTableGraphState {
  const factory _Failed(final List<UserWiseTableGraphModel> userWiseTable,
      final String message) = _$FailedImpl;

  @override
  List<UserWiseTableGraphModel> get userWiseTable;
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$FailedImplCopyWith<_$FailedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
