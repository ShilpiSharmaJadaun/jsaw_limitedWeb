// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'allContractor_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AllContractorState {
  List<AllContractorModel> get allContractorModel =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<AllContractorModel> allContractorModel)
        loading,
    required TResult Function(List<AllContractorModel> allContractorModel)
        content,
    required TResult Function(List<AllContractorModel> allContractorModel)
        success,
    required TResult Function(
            List<AllContractorModel> allContractorModel, String msg)
        failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<AllContractorModel> allContractorModel)? loading,
    TResult? Function(List<AllContractorModel> allContractorModel)? content,
    TResult? Function(List<AllContractorModel> allContractorModel)? success,
    TResult? Function(List<AllContractorModel> allContractorModel, String msg)?
        failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<AllContractorModel> allContractorModel)? loading,
    TResult Function(List<AllContractorModel> allContractorModel)? content,
    TResult Function(List<AllContractorModel> allContractorModel)? success,
    TResult Function(List<AllContractorModel> allContractorModel, String msg)?
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
  $AllContractorStateCopyWith<AllContractorState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AllContractorStateCopyWith<$Res> {
  factory $AllContractorStateCopyWith(
          AllContractorState value, $Res Function(AllContractorState) then) =
      _$AllContractorStateCopyWithImpl<$Res, AllContractorState>;
  @useResult
  $Res call({List<AllContractorModel> allContractorModel});
}

/// @nodoc
class _$AllContractorStateCopyWithImpl<$Res, $Val extends AllContractorState>
    implements $AllContractorStateCopyWith<$Res> {
  _$AllContractorStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? allContractorModel = null,
  }) {
    return _then(_value.copyWith(
      allContractorModel: null == allContractorModel
          ? _value.allContractorModel
          : allContractorModel // ignore: cast_nullable_to_non_nullable
              as List<AllContractorModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res>
    implements $AllContractorStateCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<AllContractorModel> allContractorModel});
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$AllContractorStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? allContractorModel = null,
  }) {
    return _then(_$LoadingImpl(
      null == allContractorModel
          ? _value._allContractorModel
          : allContractorModel // ignore: cast_nullable_to_non_nullable
              as List<AllContractorModel>,
    ));
  }
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl(final List<AllContractorModel> allContractorModel)
      : _allContractorModel = allContractorModel;

  final List<AllContractorModel> _allContractorModel;
  @override
  List<AllContractorModel> get allContractorModel {
    if (_allContractorModel is EqualUnmodifiableListView)
      return _allContractorModel;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allContractorModel);
  }

  @override
  String toString() {
    return 'AllContractorState.loading(allContractorModel: $allContractorModel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadingImpl &&
            const DeepCollectionEquality()
                .equals(other._allContractorModel, _allContractorModel));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_allContractorModel));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadingImplCopyWith<_$LoadingImpl> get copyWith =>
      __$$LoadingImplCopyWithImpl<_$LoadingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<AllContractorModel> allContractorModel)
        loading,
    required TResult Function(List<AllContractorModel> allContractorModel)
        content,
    required TResult Function(List<AllContractorModel> allContractorModel)
        success,
    required TResult Function(
            List<AllContractorModel> allContractorModel, String msg)
        failed,
  }) {
    return loading(allContractorModel);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<AllContractorModel> allContractorModel)? loading,
    TResult? Function(List<AllContractorModel> allContractorModel)? content,
    TResult? Function(List<AllContractorModel> allContractorModel)? success,
    TResult? Function(List<AllContractorModel> allContractorModel, String msg)?
        failed,
  }) {
    return loading?.call(allContractorModel);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<AllContractorModel> allContractorModel)? loading,
    TResult Function(List<AllContractorModel> allContractorModel)? content,
    TResult Function(List<AllContractorModel> allContractorModel)? success,
    TResult Function(List<AllContractorModel> allContractorModel, String msg)?
        failed,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(allContractorModel);
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

abstract class _Loading implements AllContractorState {
  const factory _Loading(final List<AllContractorModel> allContractorModel) =
      _$LoadingImpl;

  @override
  List<AllContractorModel> get allContractorModel;
  @override
  @JsonKey(ignore: true)
  _$$LoadingImplCopyWith<_$LoadingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ContentImplCopyWith<$Res>
    implements $AllContractorStateCopyWith<$Res> {
  factory _$$ContentImplCopyWith(
          _$ContentImpl value, $Res Function(_$ContentImpl) then) =
      __$$ContentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<AllContractorModel> allContractorModel});
}

/// @nodoc
class __$$ContentImplCopyWithImpl<$Res>
    extends _$AllContractorStateCopyWithImpl<$Res, _$ContentImpl>
    implements _$$ContentImplCopyWith<$Res> {
  __$$ContentImplCopyWithImpl(
      _$ContentImpl _value, $Res Function(_$ContentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? allContractorModel = null,
  }) {
    return _then(_$ContentImpl(
      null == allContractorModel
          ? _value._allContractorModel
          : allContractorModel // ignore: cast_nullable_to_non_nullable
              as List<AllContractorModel>,
    ));
  }
}

/// @nodoc

class _$ContentImpl implements _Content {
  const _$ContentImpl(final List<AllContractorModel> allContractorModel)
      : _allContractorModel = allContractorModel;

  final List<AllContractorModel> _allContractorModel;
  @override
  List<AllContractorModel> get allContractorModel {
    if (_allContractorModel is EqualUnmodifiableListView)
      return _allContractorModel;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allContractorModel);
  }

  @override
  String toString() {
    return 'AllContractorState.content(allContractorModel: $allContractorModel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContentImpl &&
            const DeepCollectionEquality()
                .equals(other._allContractorModel, _allContractorModel));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_allContractorModel));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ContentImplCopyWith<_$ContentImpl> get copyWith =>
      __$$ContentImplCopyWithImpl<_$ContentImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<AllContractorModel> allContractorModel)
        loading,
    required TResult Function(List<AllContractorModel> allContractorModel)
        content,
    required TResult Function(List<AllContractorModel> allContractorModel)
        success,
    required TResult Function(
            List<AllContractorModel> allContractorModel, String msg)
        failed,
  }) {
    return content(allContractorModel);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<AllContractorModel> allContractorModel)? loading,
    TResult? Function(List<AllContractorModel> allContractorModel)? content,
    TResult? Function(List<AllContractorModel> allContractorModel)? success,
    TResult? Function(List<AllContractorModel> allContractorModel, String msg)?
        failed,
  }) {
    return content?.call(allContractorModel);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<AllContractorModel> allContractorModel)? loading,
    TResult Function(List<AllContractorModel> allContractorModel)? content,
    TResult Function(List<AllContractorModel> allContractorModel)? success,
    TResult Function(List<AllContractorModel> allContractorModel, String msg)?
        failed,
    required TResult orElse(),
  }) {
    if (content != null) {
      return content(allContractorModel);
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

abstract class _Content implements AllContractorState {
  const factory _Content(final List<AllContractorModel> allContractorModel) =
      _$ContentImpl;

  @override
  List<AllContractorModel> get allContractorModel;
  @override
  @JsonKey(ignore: true)
  _$$ContentImplCopyWith<_$ContentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SuccessImplCopyWith<$Res>
    implements $AllContractorStateCopyWith<$Res> {
  factory _$$SuccessImplCopyWith(
          _$SuccessImpl value, $Res Function(_$SuccessImpl) then) =
      __$$SuccessImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<AllContractorModel> allContractorModel});
}

/// @nodoc
class __$$SuccessImplCopyWithImpl<$Res>
    extends _$AllContractorStateCopyWithImpl<$Res, _$SuccessImpl>
    implements _$$SuccessImplCopyWith<$Res> {
  __$$SuccessImplCopyWithImpl(
      _$SuccessImpl _value, $Res Function(_$SuccessImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? allContractorModel = null,
  }) {
    return _then(_$SuccessImpl(
      null == allContractorModel
          ? _value._allContractorModel
          : allContractorModel // ignore: cast_nullable_to_non_nullable
              as List<AllContractorModel>,
    ));
  }
}

/// @nodoc

class _$SuccessImpl implements _Success {
  const _$SuccessImpl(final List<AllContractorModel> allContractorModel)
      : _allContractorModel = allContractorModel;

  final List<AllContractorModel> _allContractorModel;
  @override
  List<AllContractorModel> get allContractorModel {
    if (_allContractorModel is EqualUnmodifiableListView)
      return _allContractorModel;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allContractorModel);
  }

  @override
  String toString() {
    return 'AllContractorState.success(allContractorModel: $allContractorModel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuccessImpl &&
            const DeepCollectionEquality()
                .equals(other._allContractorModel, _allContractorModel));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_allContractorModel));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      __$$SuccessImplCopyWithImpl<_$SuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<AllContractorModel> allContractorModel)
        loading,
    required TResult Function(List<AllContractorModel> allContractorModel)
        content,
    required TResult Function(List<AllContractorModel> allContractorModel)
        success,
    required TResult Function(
            List<AllContractorModel> allContractorModel, String msg)
        failed,
  }) {
    return success(allContractorModel);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<AllContractorModel> allContractorModel)? loading,
    TResult? Function(List<AllContractorModel> allContractorModel)? content,
    TResult? Function(List<AllContractorModel> allContractorModel)? success,
    TResult? Function(List<AllContractorModel> allContractorModel, String msg)?
        failed,
  }) {
    return success?.call(allContractorModel);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<AllContractorModel> allContractorModel)? loading,
    TResult Function(List<AllContractorModel> allContractorModel)? content,
    TResult Function(List<AllContractorModel> allContractorModel)? success,
    TResult Function(List<AllContractorModel> allContractorModel, String msg)?
        failed,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(allContractorModel);
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

abstract class _Success implements AllContractorState {
  const factory _Success(final List<AllContractorModel> allContractorModel) =
      _$SuccessImpl;

  @override
  List<AllContractorModel> get allContractorModel;
  @override
  @JsonKey(ignore: true)
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FailedImplCopyWith<$Res>
    implements $AllContractorStateCopyWith<$Res> {
  factory _$$FailedImplCopyWith(
          _$FailedImpl value, $Res Function(_$FailedImpl) then) =
      __$$FailedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<AllContractorModel> allContractorModel, String msg});
}

/// @nodoc
class __$$FailedImplCopyWithImpl<$Res>
    extends _$AllContractorStateCopyWithImpl<$Res, _$FailedImpl>
    implements _$$FailedImplCopyWith<$Res> {
  __$$FailedImplCopyWithImpl(
      _$FailedImpl _value, $Res Function(_$FailedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? allContractorModel = null,
    Object? msg = null,
  }) {
    return _then(_$FailedImpl(
      null == allContractorModel
          ? _value._allContractorModel
          : allContractorModel // ignore: cast_nullable_to_non_nullable
              as List<AllContractorModel>,
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
      final List<AllContractorModel> allContractorModel, this.msg)
      : _allContractorModel = allContractorModel;

  final List<AllContractorModel> _allContractorModel;
  @override
  List<AllContractorModel> get allContractorModel {
    if (_allContractorModel is EqualUnmodifiableListView)
      return _allContractorModel;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allContractorModel);
  }

  @override
  final String msg;

  @override
  String toString() {
    return 'AllContractorState.failed(allContractorModel: $allContractorModel, msg: $msg)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FailedImpl &&
            const DeepCollectionEquality()
                .equals(other._allContractorModel, _allContractorModel) &&
            (identical(other.msg, msg) || other.msg == msg));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_allContractorModel), msg);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FailedImplCopyWith<_$FailedImpl> get copyWith =>
      __$$FailedImplCopyWithImpl<_$FailedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<AllContractorModel> allContractorModel)
        loading,
    required TResult Function(List<AllContractorModel> allContractorModel)
        content,
    required TResult Function(List<AllContractorModel> allContractorModel)
        success,
    required TResult Function(
            List<AllContractorModel> allContractorModel, String msg)
        failed,
  }) {
    return failed(allContractorModel, msg);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<AllContractorModel> allContractorModel)? loading,
    TResult? Function(List<AllContractorModel> allContractorModel)? content,
    TResult? Function(List<AllContractorModel> allContractorModel)? success,
    TResult? Function(List<AllContractorModel> allContractorModel, String msg)?
        failed,
  }) {
    return failed?.call(allContractorModel, msg);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<AllContractorModel> allContractorModel)? loading,
    TResult Function(List<AllContractorModel> allContractorModel)? content,
    TResult Function(List<AllContractorModel> allContractorModel)? success,
    TResult Function(List<AllContractorModel> allContractorModel, String msg)?
        failed,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed(allContractorModel, msg);
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

abstract class _Failed implements AllContractorState {
  const factory _Failed(
          final List<AllContractorModel> allContractorModel, final String msg) =
      _$FailedImpl;

  @override
  List<AllContractorModel> get allContractorModel;
  String get msg;
  @override
  @JsonKey(ignore: true)
  _$$FailedImplCopyWith<_$FailedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
