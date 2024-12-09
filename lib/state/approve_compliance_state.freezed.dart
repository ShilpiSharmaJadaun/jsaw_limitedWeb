// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'approve_compliance_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ApproveComplianceState {
  List<ApproveComplianceModel> get complianceModel =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<ApproveComplianceModel> complianceModel)
        loading,
    required TResult Function(List<ApproveComplianceModel> complianceModel)
        content,
    required TResult Function(List<ApproveComplianceModel> complianceModel)
        success,
    required TResult Function(
            List<ApproveComplianceModel> complianceModel, String msg)
        failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<ApproveComplianceModel> complianceModel)? loading,
    TResult? Function(List<ApproveComplianceModel> complianceModel)? content,
    TResult? Function(List<ApproveComplianceModel> complianceModel)? success,
    TResult? Function(List<ApproveComplianceModel> complianceModel, String msg)?
        failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<ApproveComplianceModel> complianceModel)? loading,
    TResult Function(List<ApproveComplianceModel> complianceModel)? content,
    TResult Function(List<ApproveComplianceModel> complianceModel)? success,
    TResult Function(List<ApproveComplianceModel> complianceModel, String msg)?
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
  $ApproveComplianceStateCopyWith<ApproveComplianceState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApproveComplianceStateCopyWith<$Res> {
  factory $ApproveComplianceStateCopyWith(ApproveComplianceState value,
          $Res Function(ApproveComplianceState) then) =
      _$ApproveComplianceStateCopyWithImpl<$Res, ApproveComplianceState>;
  @useResult
  $Res call({List<ApproveComplianceModel> complianceModel});
}

/// @nodoc
class _$ApproveComplianceStateCopyWithImpl<$Res,
        $Val extends ApproveComplianceState>
    implements $ApproveComplianceStateCopyWith<$Res> {
  _$ApproveComplianceStateCopyWithImpl(this._value, this._then);

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
              as List<ApproveComplianceModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res>
    implements $ApproveComplianceStateCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<ApproveComplianceModel> complianceModel});
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$ApproveComplianceStateCopyWithImpl<$Res, _$LoadingImpl>
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
          ? _value._complianceModel
          : complianceModel // ignore: cast_nullable_to_non_nullable
              as List<ApproveComplianceModel>,
    ));
  }
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl(final List<ApproveComplianceModel> complianceModel)
      : _complianceModel = complianceModel;

  final List<ApproveComplianceModel> _complianceModel;
  @override
  List<ApproveComplianceModel> get complianceModel {
    if (_complianceModel is EqualUnmodifiableListView) return _complianceModel;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_complianceModel);
  }

  @override
  String toString() {
    return 'ApproveComplianceState.loading(complianceModel: $complianceModel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadingImpl &&
            const DeepCollectionEquality()
                .equals(other._complianceModel, _complianceModel));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_complianceModel));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadingImplCopyWith<_$LoadingImpl> get copyWith =>
      __$$LoadingImplCopyWithImpl<_$LoadingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<ApproveComplianceModel> complianceModel)
        loading,
    required TResult Function(List<ApproveComplianceModel> complianceModel)
        content,
    required TResult Function(List<ApproveComplianceModel> complianceModel)
        success,
    required TResult Function(
            List<ApproveComplianceModel> complianceModel, String msg)
        failed,
  }) {
    return loading(complianceModel);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<ApproveComplianceModel> complianceModel)? loading,
    TResult? Function(List<ApproveComplianceModel> complianceModel)? content,
    TResult? Function(List<ApproveComplianceModel> complianceModel)? success,
    TResult? Function(List<ApproveComplianceModel> complianceModel, String msg)?
        failed,
  }) {
    return loading?.call(complianceModel);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<ApproveComplianceModel> complianceModel)? loading,
    TResult Function(List<ApproveComplianceModel> complianceModel)? content,
    TResult Function(List<ApproveComplianceModel> complianceModel)? success,
    TResult Function(List<ApproveComplianceModel> complianceModel, String msg)?
        failed,
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

abstract class _Loading implements ApproveComplianceState {
  const factory _Loading(final List<ApproveComplianceModel> complianceModel) =
      _$LoadingImpl;

  @override
  List<ApproveComplianceModel> get complianceModel;
  @override
  @JsonKey(ignore: true)
  _$$LoadingImplCopyWith<_$LoadingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ContentImplCopyWith<$Res>
    implements $ApproveComplianceStateCopyWith<$Res> {
  factory _$$ContentImplCopyWith(
          _$ContentImpl value, $Res Function(_$ContentImpl) then) =
      __$$ContentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<ApproveComplianceModel> complianceModel});
}

/// @nodoc
class __$$ContentImplCopyWithImpl<$Res>
    extends _$ApproveComplianceStateCopyWithImpl<$Res, _$ContentImpl>
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
          ? _value._complianceModel
          : complianceModel // ignore: cast_nullable_to_non_nullable
              as List<ApproveComplianceModel>,
    ));
  }
}

/// @nodoc

class _$ContentImpl implements _Content {
  const _$ContentImpl(final List<ApproveComplianceModel> complianceModel)
      : _complianceModel = complianceModel;

  final List<ApproveComplianceModel> _complianceModel;
  @override
  List<ApproveComplianceModel> get complianceModel {
    if (_complianceModel is EqualUnmodifiableListView) return _complianceModel;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_complianceModel);
  }

  @override
  String toString() {
    return 'ApproveComplianceState.content(complianceModel: $complianceModel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContentImpl &&
            const DeepCollectionEquality()
                .equals(other._complianceModel, _complianceModel));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_complianceModel));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ContentImplCopyWith<_$ContentImpl> get copyWith =>
      __$$ContentImplCopyWithImpl<_$ContentImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<ApproveComplianceModel> complianceModel)
        loading,
    required TResult Function(List<ApproveComplianceModel> complianceModel)
        content,
    required TResult Function(List<ApproveComplianceModel> complianceModel)
        success,
    required TResult Function(
            List<ApproveComplianceModel> complianceModel, String msg)
        failed,
  }) {
    return content(complianceModel);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<ApproveComplianceModel> complianceModel)? loading,
    TResult? Function(List<ApproveComplianceModel> complianceModel)? content,
    TResult? Function(List<ApproveComplianceModel> complianceModel)? success,
    TResult? Function(List<ApproveComplianceModel> complianceModel, String msg)?
        failed,
  }) {
    return content?.call(complianceModel);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<ApproveComplianceModel> complianceModel)? loading,
    TResult Function(List<ApproveComplianceModel> complianceModel)? content,
    TResult Function(List<ApproveComplianceModel> complianceModel)? success,
    TResult Function(List<ApproveComplianceModel> complianceModel, String msg)?
        failed,
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

abstract class _Content implements ApproveComplianceState {
  const factory _Content(final List<ApproveComplianceModel> complianceModel) =
      _$ContentImpl;

  @override
  List<ApproveComplianceModel> get complianceModel;
  @override
  @JsonKey(ignore: true)
  _$$ContentImplCopyWith<_$ContentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SuccessImplCopyWith<$Res>
    implements $ApproveComplianceStateCopyWith<$Res> {
  factory _$$SuccessImplCopyWith(
          _$SuccessImpl value, $Res Function(_$SuccessImpl) then) =
      __$$SuccessImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<ApproveComplianceModel> complianceModel});
}

/// @nodoc
class __$$SuccessImplCopyWithImpl<$Res>
    extends _$ApproveComplianceStateCopyWithImpl<$Res, _$SuccessImpl>
    implements _$$SuccessImplCopyWith<$Res> {
  __$$SuccessImplCopyWithImpl(
      _$SuccessImpl _value, $Res Function(_$SuccessImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? complianceModel = null,
  }) {
    return _then(_$SuccessImpl(
      null == complianceModel
          ? _value._complianceModel
          : complianceModel // ignore: cast_nullable_to_non_nullable
              as List<ApproveComplianceModel>,
    ));
  }
}

/// @nodoc

class _$SuccessImpl implements _Success {
  const _$SuccessImpl(final List<ApproveComplianceModel> complianceModel)
      : _complianceModel = complianceModel;

  final List<ApproveComplianceModel> _complianceModel;
  @override
  List<ApproveComplianceModel> get complianceModel {
    if (_complianceModel is EqualUnmodifiableListView) return _complianceModel;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_complianceModel);
  }

  @override
  String toString() {
    return 'ApproveComplianceState.success(complianceModel: $complianceModel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuccessImpl &&
            const DeepCollectionEquality()
                .equals(other._complianceModel, _complianceModel));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_complianceModel));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      __$$SuccessImplCopyWithImpl<_$SuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<ApproveComplianceModel> complianceModel)
        loading,
    required TResult Function(List<ApproveComplianceModel> complianceModel)
        content,
    required TResult Function(List<ApproveComplianceModel> complianceModel)
        success,
    required TResult Function(
            List<ApproveComplianceModel> complianceModel, String msg)
        failed,
  }) {
    return success(complianceModel);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<ApproveComplianceModel> complianceModel)? loading,
    TResult? Function(List<ApproveComplianceModel> complianceModel)? content,
    TResult? Function(List<ApproveComplianceModel> complianceModel)? success,
    TResult? Function(List<ApproveComplianceModel> complianceModel, String msg)?
        failed,
  }) {
    return success?.call(complianceModel);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<ApproveComplianceModel> complianceModel)? loading,
    TResult Function(List<ApproveComplianceModel> complianceModel)? content,
    TResult Function(List<ApproveComplianceModel> complianceModel)? success,
    TResult Function(List<ApproveComplianceModel> complianceModel, String msg)?
        failed,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(complianceModel);
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

abstract class _Success implements ApproveComplianceState {
  const factory _Success(final List<ApproveComplianceModel> complianceModel) =
      _$SuccessImpl;

  @override
  List<ApproveComplianceModel> get complianceModel;
  @override
  @JsonKey(ignore: true)
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FailedImplCopyWith<$Res>
    implements $ApproveComplianceStateCopyWith<$Res> {
  factory _$$FailedImplCopyWith(
          _$FailedImpl value, $Res Function(_$FailedImpl) then) =
      __$$FailedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<ApproveComplianceModel> complianceModel, String msg});
}

/// @nodoc
class __$$FailedImplCopyWithImpl<$Res>
    extends _$ApproveComplianceStateCopyWithImpl<$Res, _$FailedImpl>
    implements _$$FailedImplCopyWith<$Res> {
  __$$FailedImplCopyWithImpl(
      _$FailedImpl _value, $Res Function(_$FailedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? complianceModel = null,
    Object? msg = null,
  }) {
    return _then(_$FailedImpl(
      null == complianceModel
          ? _value._complianceModel
          : complianceModel // ignore: cast_nullable_to_non_nullable
              as List<ApproveComplianceModel>,
      null == msg
          ? _value.msg
          : msg // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$FailedImpl implements _Failed {
  const _$FailedImpl(
      final List<ApproveComplianceModel> complianceModel, this.msg)
      : _complianceModel = complianceModel;

  final List<ApproveComplianceModel> _complianceModel;
  @override
  List<ApproveComplianceModel> get complianceModel {
    if (_complianceModel is EqualUnmodifiableListView) return _complianceModel;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_complianceModel);
  }

  @override
  final String msg;

  @override
  String toString() {
    return 'ApproveComplianceState.failed(complianceModel: $complianceModel, msg: $msg)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FailedImpl &&
            const DeepCollectionEquality()
                .equals(other._complianceModel, _complianceModel) &&
            (identical(other.msg, msg) || other.msg == msg));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_complianceModel), msg);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FailedImplCopyWith<_$FailedImpl> get copyWith =>
      __$$FailedImplCopyWithImpl<_$FailedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<ApproveComplianceModel> complianceModel)
        loading,
    required TResult Function(List<ApproveComplianceModel> complianceModel)
        content,
    required TResult Function(List<ApproveComplianceModel> complianceModel)
        success,
    required TResult Function(
            List<ApproveComplianceModel> complianceModel, String msg)
        failed,
  }) {
    return failed(complianceModel, msg);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<ApproveComplianceModel> complianceModel)? loading,
    TResult? Function(List<ApproveComplianceModel> complianceModel)? content,
    TResult? Function(List<ApproveComplianceModel> complianceModel)? success,
    TResult? Function(List<ApproveComplianceModel> complianceModel, String msg)?
        failed,
  }) {
    return failed?.call(complianceModel, msg);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<ApproveComplianceModel> complianceModel)? loading,
    TResult Function(List<ApproveComplianceModel> complianceModel)? content,
    TResult Function(List<ApproveComplianceModel> complianceModel)? success,
    TResult Function(List<ApproveComplianceModel> complianceModel, String msg)?
        failed,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed(complianceModel, msg);
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

abstract class _Failed implements ApproveComplianceState {
  const factory _Failed(final List<ApproveComplianceModel> complianceModel,
      final String msg) = _$FailedImpl;

  @override
  List<ApproveComplianceModel> get complianceModel;
  String get msg;
  @override
  @JsonKey(ignore: true)
  _$$FailedImplCopyWith<_$FailedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
