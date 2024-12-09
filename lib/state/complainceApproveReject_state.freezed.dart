// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'complainceApproveReject_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ComplainceApproveRejectState {
  ComplianceModel get complianceModel => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ComplianceModel complianceModel) loading,
    required TResult Function(ComplianceModel complianceModel) content,
    required TResult Function(ComplianceModel complianceModel, String? message)
        success,
    required TResult Function(ComplianceModel complianceModel, String message)
        failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ComplianceModel complianceModel)? loading,
    TResult? Function(ComplianceModel complianceModel)? content,
    TResult? Function(ComplianceModel complianceModel, String? message)?
        success,
    TResult? Function(ComplianceModel complianceModel, String message)? failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ComplianceModel complianceModel)? loading,
    TResult Function(ComplianceModel complianceModel)? content,
    TResult Function(ComplianceModel complianceModel, String? message)? success,
    TResult Function(ComplianceModel complianceModel, String message)? failed,
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
  $ComplainceApproveRejectStateCopyWith<ComplainceApproveRejectState>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ComplainceApproveRejectStateCopyWith<$Res> {
  factory $ComplainceApproveRejectStateCopyWith(
          ComplainceApproveRejectState value,
          $Res Function(ComplainceApproveRejectState) then) =
      _$ComplainceApproveRejectStateCopyWithImpl<$Res,
          ComplainceApproveRejectState>;
  @useResult
  $Res call({ComplianceModel complianceModel});

  $ComplianceModelCopyWith<$Res> get complianceModel;
}

/// @nodoc
class _$ComplainceApproveRejectStateCopyWithImpl<$Res,
        $Val extends ComplainceApproveRejectState>
    implements $ComplainceApproveRejectStateCopyWith<$Res> {
  _$ComplainceApproveRejectStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? complianceModel = null,
  }) {
    return _then(_value.copyWith(
      complianceModel: null == complianceModel
          ? _value.complianceModel
          : complianceModel // ignore: cast_nullable_to_non_nullable
              as ComplianceModel,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ComplianceModelCopyWith<$Res> get complianceModel {
    return $ComplianceModelCopyWith<$Res>(_value.complianceModel, (value) {
      return _then(_value.copyWith(complianceModel: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res>
    implements $ComplainceApproveRejectStateCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ComplianceModel complianceModel});

  @override
  $ComplianceModelCopyWith<$Res> get complianceModel;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$ComplainceApproveRejectStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? complianceModel = null,
  }) {
    return _then(_$LoadingImpl(
      null == complianceModel
          ? _value.complianceModel
          : complianceModel // ignore: cast_nullable_to_non_nullable
              as ComplianceModel,
    ));
  }
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl(this.complianceModel);

  @override
  final ComplianceModel complianceModel;

  @override
  String toString() {
    return 'ComplainceApproveRejectState.loading(complianceModel: $complianceModel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadingImpl &&
            (identical(other.complianceModel, complianceModel) ||
                other.complianceModel == complianceModel));
  }

  @override
  int get hashCode => Object.hash(runtimeType, complianceModel);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadingImplCopyWith<_$LoadingImpl> get copyWith =>
      __$$LoadingImplCopyWithImpl<_$LoadingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ComplianceModel complianceModel) loading,
    required TResult Function(ComplianceModel complianceModel) content,
    required TResult Function(ComplianceModel complianceModel, String? message)
        success,
    required TResult Function(ComplianceModel complianceModel, String message)
        failed,
  }) {
    return loading(complianceModel);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ComplianceModel complianceModel)? loading,
    TResult? Function(ComplianceModel complianceModel)? content,
    TResult? Function(ComplianceModel complianceModel, String? message)?
        success,
    TResult? Function(ComplianceModel complianceModel, String message)? failed,
  }) {
    return loading?.call(complianceModel);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ComplianceModel complianceModel)? loading,
    TResult Function(ComplianceModel complianceModel)? content,
    TResult Function(ComplianceModel complianceModel, String? message)? success,
    TResult Function(ComplianceModel complianceModel, String message)? failed,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(complianceModel);
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

abstract class _Loading implements ComplainceApproveRejectState {
  const factory _Loading(final ComplianceModel complianceModel) = _$LoadingImpl;

  @override
  ComplianceModel get complianceModel;
  @override
  @JsonKey(ignore: true)
  _$$LoadingImplCopyWith<_$LoadingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ContentImplCopyWith<$Res>
    implements $ComplainceApproveRejectStateCopyWith<$Res> {
  factory _$$ContentImplCopyWith(
          _$ContentImpl value, $Res Function(_$ContentImpl) then) =
      __$$ContentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ComplianceModel complianceModel});

  @override
  $ComplianceModelCopyWith<$Res> get complianceModel;
}

/// @nodoc
class __$$ContentImplCopyWithImpl<$Res>
    extends _$ComplainceApproveRejectStateCopyWithImpl<$Res, _$ContentImpl>
    implements _$$ContentImplCopyWith<$Res> {
  __$$ContentImplCopyWithImpl(
      _$ContentImpl _value, $Res Function(_$ContentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? complianceModel = null,
  }) {
    return _then(_$ContentImpl(
      null == complianceModel
          ? _value.complianceModel
          : complianceModel // ignore: cast_nullable_to_non_nullable
              as ComplianceModel,
    ));
  }
}

/// @nodoc

class _$ContentImpl implements _Content {
  const _$ContentImpl(this.complianceModel);

  @override
  final ComplianceModel complianceModel;

  @override
  String toString() {
    return 'ComplainceApproveRejectState.content(complianceModel: $complianceModel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContentImpl &&
            (identical(other.complianceModel, complianceModel) ||
                other.complianceModel == complianceModel));
  }

  @override
  int get hashCode => Object.hash(runtimeType, complianceModel);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ContentImplCopyWith<_$ContentImpl> get copyWith =>
      __$$ContentImplCopyWithImpl<_$ContentImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ComplianceModel complianceModel) loading,
    required TResult Function(ComplianceModel complianceModel) content,
    required TResult Function(ComplianceModel complianceModel, String? message)
        success,
    required TResult Function(ComplianceModel complianceModel, String message)
        failed,
  }) {
    return content(complianceModel);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ComplianceModel complianceModel)? loading,
    TResult? Function(ComplianceModel complianceModel)? content,
    TResult? Function(ComplianceModel complianceModel, String? message)?
        success,
    TResult? Function(ComplianceModel complianceModel, String message)? failed,
  }) {
    return content?.call(complianceModel);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ComplianceModel complianceModel)? loading,
    TResult Function(ComplianceModel complianceModel)? content,
    TResult Function(ComplianceModel complianceModel, String? message)? success,
    TResult Function(ComplianceModel complianceModel, String message)? failed,
    required TResult orElse(),
  }) {
    if (content != null) {
      return content(complianceModel);
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

abstract class _Content implements ComplainceApproveRejectState {
  const factory _Content(final ComplianceModel complianceModel) = _$ContentImpl;

  @override
  ComplianceModel get complianceModel;
  @override
  @JsonKey(ignore: true)
  _$$ContentImplCopyWith<_$ContentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SuccessImplCopyWith<$Res>
    implements $ComplainceApproveRejectStateCopyWith<$Res> {
  factory _$$SuccessImplCopyWith(
          _$SuccessImpl value, $Res Function(_$SuccessImpl) then) =
      __$$SuccessImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ComplianceModel complianceModel, String? message});

  @override
  $ComplianceModelCopyWith<$Res> get complianceModel;
}

/// @nodoc
class __$$SuccessImplCopyWithImpl<$Res>
    extends _$ComplainceApproveRejectStateCopyWithImpl<$Res, _$SuccessImpl>
    implements _$$SuccessImplCopyWith<$Res> {
  __$$SuccessImplCopyWithImpl(
      _$SuccessImpl _value, $Res Function(_$SuccessImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? complianceModel = null,
    Object? message = freezed,
  }) {
    return _then(_$SuccessImpl(
      null == complianceModel
          ? _value.complianceModel
          : complianceModel // ignore: cast_nullable_to_non_nullable
              as ComplianceModel,
      freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$SuccessImpl implements _Success {
  const _$SuccessImpl(this.complianceModel, this.message);

  @override
  final ComplianceModel complianceModel;
  @override
  final String? message;

  @override
  String toString() {
    return 'ComplainceApproveRejectState.success(complianceModel: $complianceModel, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuccessImpl &&
            (identical(other.complianceModel, complianceModel) ||
                other.complianceModel == complianceModel) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, complianceModel, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      __$$SuccessImplCopyWithImpl<_$SuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ComplianceModel complianceModel) loading,
    required TResult Function(ComplianceModel complianceModel) content,
    required TResult Function(ComplianceModel complianceModel, String? message)
        success,
    required TResult Function(ComplianceModel complianceModel, String message)
        failed,
  }) {
    return success(complianceModel, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ComplianceModel complianceModel)? loading,
    TResult? Function(ComplianceModel complianceModel)? content,
    TResult? Function(ComplianceModel complianceModel, String? message)?
        success,
    TResult? Function(ComplianceModel complianceModel, String message)? failed,
  }) {
    return success?.call(complianceModel, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ComplianceModel complianceModel)? loading,
    TResult Function(ComplianceModel complianceModel)? content,
    TResult Function(ComplianceModel complianceModel, String? message)? success,
    TResult Function(ComplianceModel complianceModel, String message)? failed,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(complianceModel, message);
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

abstract class _Success implements ComplainceApproveRejectState {
  const factory _Success(
          final ComplianceModel complianceModel, final String? message) =
      _$SuccessImpl;

  @override
  ComplianceModel get complianceModel;
  String? get message;
  @override
  @JsonKey(ignore: true)
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FailedImplCopyWith<$Res>
    implements $ComplainceApproveRejectStateCopyWith<$Res> {
  factory _$$FailedImplCopyWith(
          _$FailedImpl value, $Res Function(_$FailedImpl) then) =
      __$$FailedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ComplianceModel complianceModel, String message});

  @override
  $ComplianceModelCopyWith<$Res> get complianceModel;
}

/// @nodoc
class __$$FailedImplCopyWithImpl<$Res>
    extends _$ComplainceApproveRejectStateCopyWithImpl<$Res, _$FailedImpl>
    implements _$$FailedImplCopyWith<$Res> {
  __$$FailedImplCopyWithImpl(
      _$FailedImpl _value, $Res Function(_$FailedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? complianceModel = null,
    Object? message = null,
  }) {
    return _then(_$FailedImpl(
      null == complianceModel
          ? _value.complianceModel
          : complianceModel // ignore: cast_nullable_to_non_nullable
              as ComplianceModel,
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$FailedImpl implements _Failed {
  const _$FailedImpl(this.complianceModel, this.message);

  @override
  final ComplianceModel complianceModel;
  @override
  final String message;

  @override
  String toString() {
    return 'ComplainceApproveRejectState.failed(complianceModel: $complianceModel, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FailedImpl &&
            (identical(other.complianceModel, complianceModel) ||
                other.complianceModel == complianceModel) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, complianceModel, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FailedImplCopyWith<_$FailedImpl> get copyWith =>
      __$$FailedImplCopyWithImpl<_$FailedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ComplianceModel complianceModel) loading,
    required TResult Function(ComplianceModel complianceModel) content,
    required TResult Function(ComplianceModel complianceModel, String? message)
        success,
    required TResult Function(ComplianceModel complianceModel, String message)
        failed,
  }) {
    return failed(complianceModel, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ComplianceModel complianceModel)? loading,
    TResult? Function(ComplianceModel complianceModel)? content,
    TResult? Function(ComplianceModel complianceModel, String? message)?
        success,
    TResult? Function(ComplianceModel complianceModel, String message)? failed,
  }) {
    return failed?.call(complianceModel, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ComplianceModel complianceModel)? loading,
    TResult Function(ComplianceModel complianceModel)? content,
    TResult Function(ComplianceModel complianceModel, String? message)? success,
    TResult Function(ComplianceModel complianceModel, String message)? failed,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed(complianceModel, message);
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

abstract class _Failed implements ComplainceApproveRejectState {
  const factory _Failed(
          final ComplianceModel complianceModel, final String message) =
      _$FailedImpl;

  @override
  ComplianceModel get complianceModel;
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$FailedImplCopyWith<_$FailedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
