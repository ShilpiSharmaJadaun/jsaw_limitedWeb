// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'allIncident_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AllIncidentState {
  List<AllIncidentModel> get allIncident => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<AllIncidentModel> allIncident) loading,
    required TResult Function(List<AllIncidentModel> allIncident) content,
    required TResult Function(List<AllIncidentModel> allIncident) success,
    required TResult Function(List<AllIncidentModel> allIncident, String msg)
        failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<AllIncidentModel> allIncident)? loading,
    TResult? Function(List<AllIncidentModel> allIncident)? content,
    TResult? Function(List<AllIncidentModel> allIncident)? success,
    TResult? Function(List<AllIncidentModel> allIncident, String msg)? failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<AllIncidentModel> allIncident)? loading,
    TResult Function(List<AllIncidentModel> allIncident)? content,
    TResult Function(List<AllIncidentModel> allIncident)? success,
    TResult Function(List<AllIncidentModel> allIncident, String msg)? failed,
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
  $AllIncidentStateCopyWith<AllIncidentState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AllIncidentStateCopyWith<$Res> {
  factory $AllIncidentStateCopyWith(
          AllIncidentState value, $Res Function(AllIncidentState) then) =
      _$AllIncidentStateCopyWithImpl<$Res, AllIncidentState>;
  @useResult
  $Res call({List<AllIncidentModel> allIncident});
}

/// @nodoc
class _$AllIncidentStateCopyWithImpl<$Res, $Val extends AllIncidentState>
    implements $AllIncidentStateCopyWith<$Res> {
  _$AllIncidentStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? allIncident = null,
  }) {
    return _then(_value.copyWith(
      allIncident: null == allIncident
          ? _value.allIncident
          : allIncident // ignore: cast_nullable_to_non_nullable
              as List<AllIncidentModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res>
    implements $AllIncidentStateCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<AllIncidentModel> allIncident});
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$AllIncidentStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? allIncident = null,
  }) {
    return _then(_$LoadingImpl(
      null == allIncident
          ? _value._allIncident
          : allIncident // ignore: cast_nullable_to_non_nullable
              as List<AllIncidentModel>,
    ));
  }
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl(final List<AllIncidentModel> allIncident)
      : _allIncident = allIncident;

  final List<AllIncidentModel> _allIncident;
  @override
  List<AllIncidentModel> get allIncident {
    if (_allIncident is EqualUnmodifiableListView) return _allIncident;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allIncident);
  }

  @override
  String toString() {
    return 'AllIncidentState.loading(allIncident: $allIncident)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadingImpl &&
            const DeepCollectionEquality()
                .equals(other._allIncident, _allIncident));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_allIncident));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadingImplCopyWith<_$LoadingImpl> get copyWith =>
      __$$LoadingImplCopyWithImpl<_$LoadingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<AllIncidentModel> allIncident) loading,
    required TResult Function(List<AllIncidentModel> allIncident) content,
    required TResult Function(List<AllIncidentModel> allIncident) success,
    required TResult Function(List<AllIncidentModel> allIncident, String msg)
        failed,
  }) {
    return loading(allIncident);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<AllIncidentModel> allIncident)? loading,
    TResult? Function(List<AllIncidentModel> allIncident)? content,
    TResult? Function(List<AllIncidentModel> allIncident)? success,
    TResult? Function(List<AllIncidentModel> allIncident, String msg)? failed,
  }) {
    return loading?.call(allIncident);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<AllIncidentModel> allIncident)? loading,
    TResult Function(List<AllIncidentModel> allIncident)? content,
    TResult Function(List<AllIncidentModel> allIncident)? success,
    TResult Function(List<AllIncidentModel> allIncident, String msg)? failed,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(allIncident);
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

abstract class _Loading implements AllIncidentState {
  const factory _Loading(final List<AllIncidentModel> allIncident) =
      _$LoadingImpl;

  @override
  List<AllIncidentModel> get allIncident;
  @override
  @JsonKey(ignore: true)
  _$$LoadingImplCopyWith<_$LoadingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ContentImplCopyWith<$Res>
    implements $AllIncidentStateCopyWith<$Res> {
  factory _$$ContentImplCopyWith(
          _$ContentImpl value, $Res Function(_$ContentImpl) then) =
      __$$ContentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<AllIncidentModel> allIncident});
}

/// @nodoc
class __$$ContentImplCopyWithImpl<$Res>
    extends _$AllIncidentStateCopyWithImpl<$Res, _$ContentImpl>
    implements _$$ContentImplCopyWith<$Res> {
  __$$ContentImplCopyWithImpl(
      _$ContentImpl _value, $Res Function(_$ContentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? allIncident = null,
  }) {
    return _then(_$ContentImpl(
      null == allIncident
          ? _value._allIncident
          : allIncident // ignore: cast_nullable_to_non_nullable
              as List<AllIncidentModel>,
    ));
  }
}

/// @nodoc

class _$ContentImpl implements _Content {
  const _$ContentImpl(final List<AllIncidentModel> allIncident)
      : _allIncident = allIncident;

  final List<AllIncidentModel> _allIncident;
  @override
  List<AllIncidentModel> get allIncident {
    if (_allIncident is EqualUnmodifiableListView) return _allIncident;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allIncident);
  }

  @override
  String toString() {
    return 'AllIncidentState.content(allIncident: $allIncident)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContentImpl &&
            const DeepCollectionEquality()
                .equals(other._allIncident, _allIncident));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_allIncident));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ContentImplCopyWith<_$ContentImpl> get copyWith =>
      __$$ContentImplCopyWithImpl<_$ContentImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<AllIncidentModel> allIncident) loading,
    required TResult Function(List<AllIncidentModel> allIncident) content,
    required TResult Function(List<AllIncidentModel> allIncident) success,
    required TResult Function(List<AllIncidentModel> allIncident, String msg)
        failed,
  }) {
    return content(allIncident);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<AllIncidentModel> allIncident)? loading,
    TResult? Function(List<AllIncidentModel> allIncident)? content,
    TResult? Function(List<AllIncidentModel> allIncident)? success,
    TResult? Function(List<AllIncidentModel> allIncident, String msg)? failed,
  }) {
    return content?.call(allIncident);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<AllIncidentModel> allIncident)? loading,
    TResult Function(List<AllIncidentModel> allIncident)? content,
    TResult Function(List<AllIncidentModel> allIncident)? success,
    TResult Function(List<AllIncidentModel> allIncident, String msg)? failed,
    required TResult orElse(),
  }) {
    if (content != null) {
      return content(allIncident);
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

abstract class _Content implements AllIncidentState {
  const factory _Content(final List<AllIncidentModel> allIncident) =
      _$ContentImpl;

  @override
  List<AllIncidentModel> get allIncident;
  @override
  @JsonKey(ignore: true)
  _$$ContentImplCopyWith<_$ContentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SuccessImplCopyWith<$Res>
    implements $AllIncidentStateCopyWith<$Res> {
  factory _$$SuccessImplCopyWith(
          _$SuccessImpl value, $Res Function(_$SuccessImpl) then) =
      __$$SuccessImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<AllIncidentModel> allIncident});
}

/// @nodoc
class __$$SuccessImplCopyWithImpl<$Res>
    extends _$AllIncidentStateCopyWithImpl<$Res, _$SuccessImpl>
    implements _$$SuccessImplCopyWith<$Res> {
  __$$SuccessImplCopyWithImpl(
      _$SuccessImpl _value, $Res Function(_$SuccessImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? allIncident = null,
  }) {
    return _then(_$SuccessImpl(
      null == allIncident
          ? _value._allIncident
          : allIncident // ignore: cast_nullable_to_non_nullable
              as List<AllIncidentModel>,
    ));
  }
}

/// @nodoc

class _$SuccessImpl implements _Success {
  const _$SuccessImpl(final List<AllIncidentModel> allIncident)
      : _allIncident = allIncident;

  final List<AllIncidentModel> _allIncident;
  @override
  List<AllIncidentModel> get allIncident {
    if (_allIncident is EqualUnmodifiableListView) return _allIncident;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allIncident);
  }

  @override
  String toString() {
    return 'AllIncidentState.success(allIncident: $allIncident)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuccessImpl &&
            const DeepCollectionEquality()
                .equals(other._allIncident, _allIncident));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_allIncident));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      __$$SuccessImplCopyWithImpl<_$SuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<AllIncidentModel> allIncident) loading,
    required TResult Function(List<AllIncidentModel> allIncident) content,
    required TResult Function(List<AllIncidentModel> allIncident) success,
    required TResult Function(List<AllIncidentModel> allIncident, String msg)
        failed,
  }) {
    return success(allIncident);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<AllIncidentModel> allIncident)? loading,
    TResult? Function(List<AllIncidentModel> allIncident)? content,
    TResult? Function(List<AllIncidentModel> allIncident)? success,
    TResult? Function(List<AllIncidentModel> allIncident, String msg)? failed,
  }) {
    return success?.call(allIncident);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<AllIncidentModel> allIncident)? loading,
    TResult Function(List<AllIncidentModel> allIncident)? content,
    TResult Function(List<AllIncidentModel> allIncident)? success,
    TResult Function(List<AllIncidentModel> allIncident, String msg)? failed,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(allIncident);
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

abstract class _Success implements AllIncidentState {
  const factory _Success(final List<AllIncidentModel> allIncident) =
      _$SuccessImpl;

  @override
  List<AllIncidentModel> get allIncident;
  @override
  @JsonKey(ignore: true)
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FailedImplCopyWith<$Res>
    implements $AllIncidentStateCopyWith<$Res> {
  factory _$$FailedImplCopyWith(
          _$FailedImpl value, $Res Function(_$FailedImpl) then) =
      __$$FailedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<AllIncidentModel> allIncident, String msg});
}

/// @nodoc
class __$$FailedImplCopyWithImpl<$Res>
    extends _$AllIncidentStateCopyWithImpl<$Res, _$FailedImpl>
    implements _$$FailedImplCopyWith<$Res> {
  __$$FailedImplCopyWithImpl(
      _$FailedImpl _value, $Res Function(_$FailedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? allIncident = null,
    Object? msg = null,
  }) {
    return _then(_$FailedImpl(
      null == allIncident
          ? _value._allIncident
          : allIncident // ignore: cast_nullable_to_non_nullable
              as List<AllIncidentModel>,
      null == msg
          ? _value.msg
          : msg // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$FailedImpl implements _Failed {
  const _$FailedImpl(final List<AllIncidentModel> allIncident, this.msg)
      : _allIncident = allIncident;

  final List<AllIncidentModel> _allIncident;
  @override
  List<AllIncidentModel> get allIncident {
    if (_allIncident is EqualUnmodifiableListView) return _allIncident;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allIncident);
  }

  @override
  final String msg;

  @override
  String toString() {
    return 'AllIncidentState.failed(allIncident: $allIncident, msg: $msg)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FailedImpl &&
            const DeepCollectionEquality()
                .equals(other._allIncident, _allIncident) &&
            (identical(other.msg, msg) || other.msg == msg));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_allIncident), msg);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FailedImplCopyWith<_$FailedImpl> get copyWith =>
      __$$FailedImplCopyWithImpl<_$FailedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<AllIncidentModel> allIncident) loading,
    required TResult Function(List<AllIncidentModel> allIncident) content,
    required TResult Function(List<AllIncidentModel> allIncident) success,
    required TResult Function(List<AllIncidentModel> allIncident, String msg)
        failed,
  }) {
    return failed(allIncident, msg);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<AllIncidentModel> allIncident)? loading,
    TResult? Function(List<AllIncidentModel> allIncident)? content,
    TResult? Function(List<AllIncidentModel> allIncident)? success,
    TResult? Function(List<AllIncidentModel> allIncident, String msg)? failed,
  }) {
    return failed?.call(allIncident, msg);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<AllIncidentModel> allIncident)? loading,
    TResult Function(List<AllIncidentModel> allIncident)? content,
    TResult Function(List<AllIncidentModel> allIncident)? success,
    TResult Function(List<AllIncidentModel> allIncident, String msg)? failed,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed(allIncident, msg);
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

abstract class _Failed implements AllIncidentState {
  const factory _Failed(
          final List<AllIncidentModel> allIncident, final String msg) =
      _$FailedImpl;

  @override
  List<AllIncidentModel> get allIncident;
  String get msg;
  @override
  @JsonKey(ignore: true)
  _$$FailedImplCopyWith<_$FailedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
