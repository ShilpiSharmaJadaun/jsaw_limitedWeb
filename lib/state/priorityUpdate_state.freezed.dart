// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'priorityUpdate_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PriorityUpdateState {
  PriorityUpdateModel get priorityModel => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(PriorityUpdateModel priorityModel) loading,
    required TResult Function(PriorityUpdateModel priorityModel) content,
    required TResult Function(
            PriorityUpdateModel priorityModel, String? message)
        success,
    required TResult Function(PriorityUpdateModel priorityModel, String message)
        failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(PriorityUpdateModel priorityModel)? loading,
    TResult? Function(PriorityUpdateModel priorityModel)? content,
    TResult? Function(PriorityUpdateModel priorityModel, String? message)?
        success,
    TResult? Function(PriorityUpdateModel priorityModel, String message)?
        failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(PriorityUpdateModel priorityModel)? loading,
    TResult Function(PriorityUpdateModel priorityModel)? content,
    TResult Function(PriorityUpdateModel priorityModel, String? message)?
        success,
    TResult Function(PriorityUpdateModel priorityModel, String message)? failed,
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
  $PriorityUpdateStateCopyWith<PriorityUpdateState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PriorityUpdateStateCopyWith<$Res> {
  factory $PriorityUpdateStateCopyWith(
          PriorityUpdateState value, $Res Function(PriorityUpdateState) then) =
      _$PriorityUpdateStateCopyWithImpl<$Res, PriorityUpdateState>;
  @useResult
  $Res call({PriorityUpdateModel priorityModel});

  $PriorityUpdateModelCopyWith<$Res> get priorityModel;
}

/// @nodoc
class _$PriorityUpdateStateCopyWithImpl<$Res, $Val extends PriorityUpdateState>
    implements $PriorityUpdateStateCopyWith<$Res> {
  _$PriorityUpdateStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? priorityModel = null,
  }) {
    return _then(_value.copyWith(
      priorityModel: null == priorityModel
          ? _value.priorityModel
          : priorityModel // ignore: cast_nullable_to_non_nullable
              as PriorityUpdateModel,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PriorityUpdateModelCopyWith<$Res> get priorityModel {
    return $PriorityUpdateModelCopyWith<$Res>(_value.priorityModel, (value) {
      return _then(_value.copyWith(priorityModel: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res>
    implements $PriorityUpdateStateCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({PriorityUpdateModel priorityModel});

  @override
  $PriorityUpdateModelCopyWith<$Res> get priorityModel;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$PriorityUpdateStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? priorityModel = null,
  }) {
    return _then(_$LoadingImpl(
      null == priorityModel
          ? _value.priorityModel
          : priorityModel // ignore: cast_nullable_to_non_nullable
              as PriorityUpdateModel,
    ));
  }
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl(this.priorityModel);

  @override
  final PriorityUpdateModel priorityModel;

  @override
  String toString() {
    return 'PriorityUpdateState.loading(priorityModel: $priorityModel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadingImpl &&
            (identical(other.priorityModel, priorityModel) ||
                other.priorityModel == priorityModel));
  }

  @override
  int get hashCode => Object.hash(runtimeType, priorityModel);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadingImplCopyWith<_$LoadingImpl> get copyWith =>
      __$$LoadingImplCopyWithImpl<_$LoadingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(PriorityUpdateModel priorityModel) loading,
    required TResult Function(PriorityUpdateModel priorityModel) content,
    required TResult Function(
            PriorityUpdateModel priorityModel, String? message)
        success,
    required TResult Function(PriorityUpdateModel priorityModel, String message)
        failed,
  }) {
    return loading(priorityModel);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(PriorityUpdateModel priorityModel)? loading,
    TResult? Function(PriorityUpdateModel priorityModel)? content,
    TResult? Function(PriorityUpdateModel priorityModel, String? message)?
        success,
    TResult? Function(PriorityUpdateModel priorityModel, String message)?
        failed,
  }) {
    return loading?.call(priorityModel);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(PriorityUpdateModel priorityModel)? loading,
    TResult Function(PriorityUpdateModel priorityModel)? content,
    TResult Function(PriorityUpdateModel priorityModel, String? message)?
        success,
    TResult Function(PriorityUpdateModel priorityModel, String message)? failed,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(priorityModel);
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

abstract class _Loading implements PriorityUpdateState {
  const factory _Loading(final PriorityUpdateModel priorityModel) =
      _$LoadingImpl;

  @override
  PriorityUpdateModel get priorityModel;
  @override
  @JsonKey(ignore: true)
  _$$LoadingImplCopyWith<_$LoadingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ContentImplCopyWith<$Res>
    implements $PriorityUpdateStateCopyWith<$Res> {
  factory _$$ContentImplCopyWith(
          _$ContentImpl value, $Res Function(_$ContentImpl) then) =
      __$$ContentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({PriorityUpdateModel priorityModel});

  @override
  $PriorityUpdateModelCopyWith<$Res> get priorityModel;
}

/// @nodoc
class __$$ContentImplCopyWithImpl<$Res>
    extends _$PriorityUpdateStateCopyWithImpl<$Res, _$ContentImpl>
    implements _$$ContentImplCopyWith<$Res> {
  __$$ContentImplCopyWithImpl(
      _$ContentImpl _value, $Res Function(_$ContentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? priorityModel = null,
  }) {
    return _then(_$ContentImpl(
      null == priorityModel
          ? _value.priorityModel
          : priorityModel // ignore: cast_nullable_to_non_nullable
              as PriorityUpdateModel,
    ));
  }
}

/// @nodoc

class _$ContentImpl implements _Content {
  const _$ContentImpl(this.priorityModel);

  @override
  final PriorityUpdateModel priorityModel;

  @override
  String toString() {
    return 'PriorityUpdateState.content(priorityModel: $priorityModel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContentImpl &&
            (identical(other.priorityModel, priorityModel) ||
                other.priorityModel == priorityModel));
  }

  @override
  int get hashCode => Object.hash(runtimeType, priorityModel);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ContentImplCopyWith<_$ContentImpl> get copyWith =>
      __$$ContentImplCopyWithImpl<_$ContentImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(PriorityUpdateModel priorityModel) loading,
    required TResult Function(PriorityUpdateModel priorityModel) content,
    required TResult Function(
            PriorityUpdateModel priorityModel, String? message)
        success,
    required TResult Function(PriorityUpdateModel priorityModel, String message)
        failed,
  }) {
    return content(priorityModel);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(PriorityUpdateModel priorityModel)? loading,
    TResult? Function(PriorityUpdateModel priorityModel)? content,
    TResult? Function(PriorityUpdateModel priorityModel, String? message)?
        success,
    TResult? Function(PriorityUpdateModel priorityModel, String message)?
        failed,
  }) {
    return content?.call(priorityModel);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(PriorityUpdateModel priorityModel)? loading,
    TResult Function(PriorityUpdateModel priorityModel)? content,
    TResult Function(PriorityUpdateModel priorityModel, String? message)?
        success,
    TResult Function(PriorityUpdateModel priorityModel, String message)? failed,
    required TResult orElse(),
  }) {
    if (content != null) {
      return content(priorityModel);
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

abstract class _Content implements PriorityUpdateState {
  const factory _Content(final PriorityUpdateModel priorityModel) =
      _$ContentImpl;

  @override
  PriorityUpdateModel get priorityModel;
  @override
  @JsonKey(ignore: true)
  _$$ContentImplCopyWith<_$ContentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SuccessImplCopyWith<$Res>
    implements $PriorityUpdateStateCopyWith<$Res> {
  factory _$$SuccessImplCopyWith(
          _$SuccessImpl value, $Res Function(_$SuccessImpl) then) =
      __$$SuccessImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({PriorityUpdateModel priorityModel, String? message});

  @override
  $PriorityUpdateModelCopyWith<$Res> get priorityModel;
}

/// @nodoc
class __$$SuccessImplCopyWithImpl<$Res>
    extends _$PriorityUpdateStateCopyWithImpl<$Res, _$SuccessImpl>
    implements _$$SuccessImplCopyWith<$Res> {
  __$$SuccessImplCopyWithImpl(
      _$SuccessImpl _value, $Res Function(_$SuccessImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? priorityModel = null,
    Object? message = freezed,
  }) {
    return _then(_$SuccessImpl(
      null == priorityModel
          ? _value.priorityModel
          : priorityModel // ignore: cast_nullable_to_non_nullable
              as PriorityUpdateModel,
      freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$SuccessImpl implements _Success {
  const _$SuccessImpl(this.priorityModel, this.message);

  @override
  final PriorityUpdateModel priorityModel;
  @override
  final String? message;

  @override
  String toString() {
    return 'PriorityUpdateState.success(priorityModel: $priorityModel, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuccessImpl &&
            (identical(other.priorityModel, priorityModel) ||
                other.priorityModel == priorityModel) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, priorityModel, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      __$$SuccessImplCopyWithImpl<_$SuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(PriorityUpdateModel priorityModel) loading,
    required TResult Function(PriorityUpdateModel priorityModel) content,
    required TResult Function(
            PriorityUpdateModel priorityModel, String? message)
        success,
    required TResult Function(PriorityUpdateModel priorityModel, String message)
        failed,
  }) {
    return success(priorityModel, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(PriorityUpdateModel priorityModel)? loading,
    TResult? Function(PriorityUpdateModel priorityModel)? content,
    TResult? Function(PriorityUpdateModel priorityModel, String? message)?
        success,
    TResult? Function(PriorityUpdateModel priorityModel, String message)?
        failed,
  }) {
    return success?.call(priorityModel, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(PriorityUpdateModel priorityModel)? loading,
    TResult Function(PriorityUpdateModel priorityModel)? content,
    TResult Function(PriorityUpdateModel priorityModel, String? message)?
        success,
    TResult Function(PriorityUpdateModel priorityModel, String message)? failed,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(priorityModel, message);
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

abstract class _Success implements PriorityUpdateState {
  const factory _Success(
          final PriorityUpdateModel priorityModel, final String? message) =
      _$SuccessImpl;

  @override
  PriorityUpdateModel get priorityModel;
  String? get message;
  @override
  @JsonKey(ignore: true)
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FailedImplCopyWith<$Res>
    implements $PriorityUpdateStateCopyWith<$Res> {
  factory _$$FailedImplCopyWith(
          _$FailedImpl value, $Res Function(_$FailedImpl) then) =
      __$$FailedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({PriorityUpdateModel priorityModel, String message});

  @override
  $PriorityUpdateModelCopyWith<$Res> get priorityModel;
}

/// @nodoc
class __$$FailedImplCopyWithImpl<$Res>
    extends _$PriorityUpdateStateCopyWithImpl<$Res, _$FailedImpl>
    implements _$$FailedImplCopyWith<$Res> {
  __$$FailedImplCopyWithImpl(
      _$FailedImpl _value, $Res Function(_$FailedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? priorityModel = null,
    Object? message = null,
  }) {
    return _then(_$FailedImpl(
      null == priorityModel
          ? _value.priorityModel
          : priorityModel // ignore: cast_nullable_to_non_nullable
              as PriorityUpdateModel,
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$FailedImpl implements _Failed {
  const _$FailedImpl(this.priorityModel, this.message);

  @override
  final PriorityUpdateModel priorityModel;
  @override
  final String message;

  @override
  String toString() {
    return 'PriorityUpdateState.failed(priorityModel: $priorityModel, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FailedImpl &&
            (identical(other.priorityModel, priorityModel) ||
                other.priorityModel == priorityModel) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, priorityModel, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FailedImplCopyWith<_$FailedImpl> get copyWith =>
      __$$FailedImplCopyWithImpl<_$FailedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(PriorityUpdateModel priorityModel) loading,
    required TResult Function(PriorityUpdateModel priorityModel) content,
    required TResult Function(
            PriorityUpdateModel priorityModel, String? message)
        success,
    required TResult Function(PriorityUpdateModel priorityModel, String message)
        failed,
  }) {
    return failed(priorityModel, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(PriorityUpdateModel priorityModel)? loading,
    TResult? Function(PriorityUpdateModel priorityModel)? content,
    TResult? Function(PriorityUpdateModel priorityModel, String? message)?
        success,
    TResult? Function(PriorityUpdateModel priorityModel, String message)?
        failed,
  }) {
    return failed?.call(priorityModel, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(PriorityUpdateModel priorityModel)? loading,
    TResult Function(PriorityUpdateModel priorityModel)? content,
    TResult Function(PriorityUpdateModel priorityModel, String? message)?
        success,
    TResult Function(PriorityUpdateModel priorityModel, String message)? failed,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed(priorityModel, message);
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

abstract class _Failed implements PriorityUpdateState {
  const factory _Failed(
          final PriorityUpdateModel priorityModel, final String message) =
      _$FailedImpl;

  @override
  PriorityUpdateModel get priorityModel;
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$FailedImplCopyWith<_$FailedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
