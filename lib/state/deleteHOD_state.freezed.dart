// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'deleteHOD_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$DeleteHODState {
  DeleteHODModel get deleteHOD => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DeleteHODModel deleteHOD) loading,
    required TResult Function(DeleteHODModel deleteHOD) content,
    required TResult Function(DeleteHODModel deleteHOD, String? message)
        success,
    required TResult Function(DeleteHODModel deleteHOD, String message) failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DeleteHODModel deleteHOD)? loading,
    TResult? Function(DeleteHODModel deleteHOD)? content,
    TResult? Function(DeleteHODModel deleteHOD, String? message)? success,
    TResult? Function(DeleteHODModel deleteHOD, String message)? failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DeleteHODModel deleteHOD)? loading,
    TResult Function(DeleteHODModel deleteHOD)? content,
    TResult Function(DeleteHODModel deleteHOD, String? message)? success,
    TResult Function(DeleteHODModel deleteHOD, String message)? failed,
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
  $DeleteHODStateCopyWith<DeleteHODState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeleteHODStateCopyWith<$Res> {
  factory $DeleteHODStateCopyWith(
          DeleteHODState value, $Res Function(DeleteHODState) then) =
      _$DeleteHODStateCopyWithImpl<$Res, DeleteHODState>;
  @useResult
  $Res call({DeleteHODModel deleteHOD});

  $DeleteHODModelCopyWith<$Res> get deleteHOD;
}

/// @nodoc
class _$DeleteHODStateCopyWithImpl<$Res, $Val extends DeleteHODState>
    implements $DeleteHODStateCopyWith<$Res> {
  _$DeleteHODStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? deleteHOD = null,
  }) {
    return _then(_value.copyWith(
      deleteHOD: null == deleteHOD
          ? _value.deleteHOD
          : deleteHOD // ignore: cast_nullable_to_non_nullable
              as DeleteHODModel,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $DeleteHODModelCopyWith<$Res> get deleteHOD {
    return $DeleteHODModelCopyWith<$Res>(_value.deleteHOD, (value) {
      return _then(_value.copyWith(deleteHOD: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res>
    implements $DeleteHODStateCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DeleteHODModel deleteHOD});

  @override
  $DeleteHODModelCopyWith<$Res> get deleteHOD;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$DeleteHODStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? deleteHOD = null,
  }) {
    return _then(_$LoadingImpl(
      null == deleteHOD
          ? _value.deleteHOD
          : deleteHOD // ignore: cast_nullable_to_non_nullable
              as DeleteHODModel,
    ));
  }
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl(this.deleteHOD);

  @override
  final DeleteHODModel deleteHOD;

  @override
  String toString() {
    return 'DeleteHODState.loading(deleteHOD: $deleteHOD)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadingImpl &&
            (identical(other.deleteHOD, deleteHOD) ||
                other.deleteHOD == deleteHOD));
  }

  @override
  int get hashCode => Object.hash(runtimeType, deleteHOD);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadingImplCopyWith<_$LoadingImpl> get copyWith =>
      __$$LoadingImplCopyWithImpl<_$LoadingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DeleteHODModel deleteHOD) loading,
    required TResult Function(DeleteHODModel deleteHOD) content,
    required TResult Function(DeleteHODModel deleteHOD, String? message)
        success,
    required TResult Function(DeleteHODModel deleteHOD, String message) failed,
  }) {
    return loading(deleteHOD);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DeleteHODModel deleteHOD)? loading,
    TResult? Function(DeleteHODModel deleteHOD)? content,
    TResult? Function(DeleteHODModel deleteHOD, String? message)? success,
    TResult? Function(DeleteHODModel deleteHOD, String message)? failed,
  }) {
    return loading?.call(deleteHOD);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DeleteHODModel deleteHOD)? loading,
    TResult Function(DeleteHODModel deleteHOD)? content,
    TResult Function(DeleteHODModel deleteHOD, String? message)? success,
    TResult Function(DeleteHODModel deleteHOD, String message)? failed,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(deleteHOD);
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

abstract class _Loading implements DeleteHODState {
  const factory _Loading(final DeleteHODModel deleteHOD) = _$LoadingImpl;

  @override
  DeleteHODModel get deleteHOD;
  @override
  @JsonKey(ignore: true)
  _$$LoadingImplCopyWith<_$LoadingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ContentImplCopyWith<$Res>
    implements $DeleteHODStateCopyWith<$Res> {
  factory _$$ContentImplCopyWith(
          _$ContentImpl value, $Res Function(_$ContentImpl) then) =
      __$$ContentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DeleteHODModel deleteHOD});

  @override
  $DeleteHODModelCopyWith<$Res> get deleteHOD;
}

/// @nodoc
class __$$ContentImplCopyWithImpl<$Res>
    extends _$DeleteHODStateCopyWithImpl<$Res, _$ContentImpl>
    implements _$$ContentImplCopyWith<$Res> {
  __$$ContentImplCopyWithImpl(
      _$ContentImpl _value, $Res Function(_$ContentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? deleteHOD = null,
  }) {
    return _then(_$ContentImpl(
      null == deleteHOD
          ? _value.deleteHOD
          : deleteHOD // ignore: cast_nullable_to_non_nullable
              as DeleteHODModel,
    ));
  }
}

/// @nodoc

class _$ContentImpl implements _Content {
  const _$ContentImpl(this.deleteHOD);

  @override
  final DeleteHODModel deleteHOD;

  @override
  String toString() {
    return 'DeleteHODState.content(deleteHOD: $deleteHOD)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContentImpl &&
            (identical(other.deleteHOD, deleteHOD) ||
                other.deleteHOD == deleteHOD));
  }

  @override
  int get hashCode => Object.hash(runtimeType, deleteHOD);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ContentImplCopyWith<_$ContentImpl> get copyWith =>
      __$$ContentImplCopyWithImpl<_$ContentImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DeleteHODModel deleteHOD) loading,
    required TResult Function(DeleteHODModel deleteHOD) content,
    required TResult Function(DeleteHODModel deleteHOD, String? message)
        success,
    required TResult Function(DeleteHODModel deleteHOD, String message) failed,
  }) {
    return content(deleteHOD);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DeleteHODModel deleteHOD)? loading,
    TResult? Function(DeleteHODModel deleteHOD)? content,
    TResult? Function(DeleteHODModel deleteHOD, String? message)? success,
    TResult? Function(DeleteHODModel deleteHOD, String message)? failed,
  }) {
    return content?.call(deleteHOD);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DeleteHODModel deleteHOD)? loading,
    TResult Function(DeleteHODModel deleteHOD)? content,
    TResult Function(DeleteHODModel deleteHOD, String? message)? success,
    TResult Function(DeleteHODModel deleteHOD, String message)? failed,
    required TResult orElse(),
  }) {
    if (content != null) {
      return content(deleteHOD);
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

abstract class _Content implements DeleteHODState {
  const factory _Content(final DeleteHODModel deleteHOD) = _$ContentImpl;

  @override
  DeleteHODModel get deleteHOD;
  @override
  @JsonKey(ignore: true)
  _$$ContentImplCopyWith<_$ContentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SuccessImplCopyWith<$Res>
    implements $DeleteHODStateCopyWith<$Res> {
  factory _$$SuccessImplCopyWith(
          _$SuccessImpl value, $Res Function(_$SuccessImpl) then) =
      __$$SuccessImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DeleteHODModel deleteHOD, String? message});

  @override
  $DeleteHODModelCopyWith<$Res> get deleteHOD;
}

/// @nodoc
class __$$SuccessImplCopyWithImpl<$Res>
    extends _$DeleteHODStateCopyWithImpl<$Res, _$SuccessImpl>
    implements _$$SuccessImplCopyWith<$Res> {
  __$$SuccessImplCopyWithImpl(
      _$SuccessImpl _value, $Res Function(_$SuccessImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? deleteHOD = null,
    Object? message = freezed,
  }) {
    return _then(_$SuccessImpl(
      null == deleteHOD
          ? _value.deleteHOD
          : deleteHOD // ignore: cast_nullable_to_non_nullable
              as DeleteHODModel,
      freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$SuccessImpl implements _Success {
  const _$SuccessImpl(this.deleteHOD, this.message);

  @override
  final DeleteHODModel deleteHOD;
  @override
  final String? message;

  @override
  String toString() {
    return 'DeleteHODState.success(deleteHOD: $deleteHOD, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuccessImpl &&
            (identical(other.deleteHOD, deleteHOD) ||
                other.deleteHOD == deleteHOD) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, deleteHOD, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      __$$SuccessImplCopyWithImpl<_$SuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DeleteHODModel deleteHOD) loading,
    required TResult Function(DeleteHODModel deleteHOD) content,
    required TResult Function(DeleteHODModel deleteHOD, String? message)
        success,
    required TResult Function(DeleteHODModel deleteHOD, String message) failed,
  }) {
    return success(deleteHOD, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DeleteHODModel deleteHOD)? loading,
    TResult? Function(DeleteHODModel deleteHOD)? content,
    TResult? Function(DeleteHODModel deleteHOD, String? message)? success,
    TResult? Function(DeleteHODModel deleteHOD, String message)? failed,
  }) {
    return success?.call(deleteHOD, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DeleteHODModel deleteHOD)? loading,
    TResult Function(DeleteHODModel deleteHOD)? content,
    TResult Function(DeleteHODModel deleteHOD, String? message)? success,
    TResult Function(DeleteHODModel deleteHOD, String message)? failed,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(deleteHOD, message);
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

abstract class _Success implements DeleteHODState {
  const factory _Success(
      final DeleteHODModel deleteHOD, final String? message) = _$SuccessImpl;

  @override
  DeleteHODModel get deleteHOD;
  String? get message;
  @override
  @JsonKey(ignore: true)
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FailedImplCopyWith<$Res>
    implements $DeleteHODStateCopyWith<$Res> {
  factory _$$FailedImplCopyWith(
          _$FailedImpl value, $Res Function(_$FailedImpl) then) =
      __$$FailedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DeleteHODModel deleteHOD, String message});

  @override
  $DeleteHODModelCopyWith<$Res> get deleteHOD;
}

/// @nodoc
class __$$FailedImplCopyWithImpl<$Res>
    extends _$DeleteHODStateCopyWithImpl<$Res, _$FailedImpl>
    implements _$$FailedImplCopyWith<$Res> {
  __$$FailedImplCopyWithImpl(
      _$FailedImpl _value, $Res Function(_$FailedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? deleteHOD = null,
    Object? message = null,
  }) {
    return _then(_$FailedImpl(
      null == deleteHOD
          ? _value.deleteHOD
          : deleteHOD // ignore: cast_nullable_to_non_nullable
              as DeleteHODModel,
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$FailedImpl implements _Failed {
  const _$FailedImpl(this.deleteHOD, this.message);

  @override
  final DeleteHODModel deleteHOD;
  @override
  final String message;

  @override
  String toString() {
    return 'DeleteHODState.failed(deleteHOD: $deleteHOD, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FailedImpl &&
            (identical(other.deleteHOD, deleteHOD) ||
                other.deleteHOD == deleteHOD) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, deleteHOD, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FailedImplCopyWith<_$FailedImpl> get copyWith =>
      __$$FailedImplCopyWithImpl<_$FailedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DeleteHODModel deleteHOD) loading,
    required TResult Function(DeleteHODModel deleteHOD) content,
    required TResult Function(DeleteHODModel deleteHOD, String? message)
        success,
    required TResult Function(DeleteHODModel deleteHOD, String message) failed,
  }) {
    return failed(deleteHOD, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DeleteHODModel deleteHOD)? loading,
    TResult? Function(DeleteHODModel deleteHOD)? content,
    TResult? Function(DeleteHODModel deleteHOD, String? message)? success,
    TResult? Function(DeleteHODModel deleteHOD, String message)? failed,
  }) {
    return failed?.call(deleteHOD, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DeleteHODModel deleteHOD)? loading,
    TResult Function(DeleteHODModel deleteHOD)? content,
    TResult Function(DeleteHODModel deleteHOD, String? message)? success,
    TResult Function(DeleteHODModel deleteHOD, String message)? failed,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed(deleteHOD, message);
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

abstract class _Failed implements DeleteHODState {
  const factory _Failed(final DeleteHODModel deleteHOD, final String message) =
      _$FailedImpl;

  @override
  DeleteHODModel get deleteHOD;
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$FailedImplCopyWith<_$FailedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
