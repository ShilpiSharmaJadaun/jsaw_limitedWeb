// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'allplant_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AllPlantState {
  List<AllPlantModel> get allPlantModel => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<AllPlantModel> allPlantModel) loading,
    required TResult Function(List<AllPlantModel> allPlantModel) content,
    required TResult Function(List<AllPlantModel> allPlantModel) success,
    required TResult Function(List<AllPlantModel> allPlantModel, String msg)
        failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<AllPlantModel> allPlantModel)? loading,
    TResult? Function(List<AllPlantModel> allPlantModel)? content,
    TResult? Function(List<AllPlantModel> allPlantModel)? success,
    TResult? Function(List<AllPlantModel> allPlantModel, String msg)? failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<AllPlantModel> allPlantModel)? loading,
    TResult Function(List<AllPlantModel> allPlantModel)? content,
    TResult Function(List<AllPlantModel> allPlantModel)? success,
    TResult Function(List<AllPlantModel> allPlantModel, String msg)? failed,
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
  $AllPlantStateCopyWith<AllPlantState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AllPlantStateCopyWith<$Res> {
  factory $AllPlantStateCopyWith(
          AllPlantState value, $Res Function(AllPlantState) then) =
      _$AllPlantStateCopyWithImpl<$Res, AllPlantState>;
  @useResult
  $Res call({List<AllPlantModel> allPlantModel});
}

/// @nodoc
class _$AllPlantStateCopyWithImpl<$Res, $Val extends AllPlantState>
    implements $AllPlantStateCopyWith<$Res> {
  _$AllPlantStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? allPlantModel = null,
  }) {
    return _then(_value.copyWith(
      allPlantModel: null == allPlantModel
          ? _value.allPlantModel
          : allPlantModel // ignore: cast_nullable_to_non_nullable
              as List<AllPlantModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res>
    implements $AllPlantStateCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<AllPlantModel> allPlantModel});
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$AllPlantStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? allPlantModel = null,
  }) {
    return _then(_$LoadingImpl(
      null == allPlantModel
          ? _value._allPlantModel
          : allPlantModel // ignore: cast_nullable_to_non_nullable
              as List<AllPlantModel>,
    ));
  }
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl(final List<AllPlantModel> allPlantModel)
      : _allPlantModel = allPlantModel;

  final List<AllPlantModel> _allPlantModel;
  @override
  List<AllPlantModel> get allPlantModel {
    if (_allPlantModel is EqualUnmodifiableListView) return _allPlantModel;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allPlantModel);
  }

  @override
  String toString() {
    return 'AllPlantState.loading(allPlantModel: $allPlantModel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadingImpl &&
            const DeepCollectionEquality()
                .equals(other._allPlantModel, _allPlantModel));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_allPlantModel));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadingImplCopyWith<_$LoadingImpl> get copyWith =>
      __$$LoadingImplCopyWithImpl<_$LoadingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<AllPlantModel> allPlantModel) loading,
    required TResult Function(List<AllPlantModel> allPlantModel) content,
    required TResult Function(List<AllPlantModel> allPlantModel) success,
    required TResult Function(List<AllPlantModel> allPlantModel, String msg)
        failed,
  }) {
    return loading(allPlantModel);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<AllPlantModel> allPlantModel)? loading,
    TResult? Function(List<AllPlantModel> allPlantModel)? content,
    TResult? Function(List<AllPlantModel> allPlantModel)? success,
    TResult? Function(List<AllPlantModel> allPlantModel, String msg)? failed,
  }) {
    return loading?.call(allPlantModel);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<AllPlantModel> allPlantModel)? loading,
    TResult Function(List<AllPlantModel> allPlantModel)? content,
    TResult Function(List<AllPlantModel> allPlantModel)? success,
    TResult Function(List<AllPlantModel> allPlantModel, String msg)? failed,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(allPlantModel);
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

abstract class _Loading implements AllPlantState {
  const factory _Loading(final List<AllPlantModel> allPlantModel) =
      _$LoadingImpl;

  @override
  List<AllPlantModel> get allPlantModel;
  @override
  @JsonKey(ignore: true)
  _$$LoadingImplCopyWith<_$LoadingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ContentImplCopyWith<$Res>
    implements $AllPlantStateCopyWith<$Res> {
  factory _$$ContentImplCopyWith(
          _$ContentImpl value, $Res Function(_$ContentImpl) then) =
      __$$ContentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<AllPlantModel> allPlantModel});
}

/// @nodoc
class __$$ContentImplCopyWithImpl<$Res>
    extends _$AllPlantStateCopyWithImpl<$Res, _$ContentImpl>
    implements _$$ContentImplCopyWith<$Res> {
  __$$ContentImplCopyWithImpl(
      _$ContentImpl _value, $Res Function(_$ContentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? allPlantModel = null,
  }) {
    return _then(_$ContentImpl(
      null == allPlantModel
          ? _value._allPlantModel
          : allPlantModel // ignore: cast_nullable_to_non_nullable
              as List<AllPlantModel>,
    ));
  }
}

/// @nodoc

class _$ContentImpl implements _Content {
  const _$ContentImpl(final List<AllPlantModel> allPlantModel)
      : _allPlantModel = allPlantModel;

  final List<AllPlantModel> _allPlantModel;
  @override
  List<AllPlantModel> get allPlantModel {
    if (_allPlantModel is EqualUnmodifiableListView) return _allPlantModel;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allPlantModel);
  }

  @override
  String toString() {
    return 'AllPlantState.content(allPlantModel: $allPlantModel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContentImpl &&
            const DeepCollectionEquality()
                .equals(other._allPlantModel, _allPlantModel));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_allPlantModel));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ContentImplCopyWith<_$ContentImpl> get copyWith =>
      __$$ContentImplCopyWithImpl<_$ContentImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<AllPlantModel> allPlantModel) loading,
    required TResult Function(List<AllPlantModel> allPlantModel) content,
    required TResult Function(List<AllPlantModel> allPlantModel) success,
    required TResult Function(List<AllPlantModel> allPlantModel, String msg)
        failed,
  }) {
    return content(allPlantModel);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<AllPlantModel> allPlantModel)? loading,
    TResult? Function(List<AllPlantModel> allPlantModel)? content,
    TResult? Function(List<AllPlantModel> allPlantModel)? success,
    TResult? Function(List<AllPlantModel> allPlantModel, String msg)? failed,
  }) {
    return content?.call(allPlantModel);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<AllPlantModel> allPlantModel)? loading,
    TResult Function(List<AllPlantModel> allPlantModel)? content,
    TResult Function(List<AllPlantModel> allPlantModel)? success,
    TResult Function(List<AllPlantModel> allPlantModel, String msg)? failed,
    required TResult orElse(),
  }) {
    if (content != null) {
      return content(allPlantModel);
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

abstract class _Content implements AllPlantState {
  const factory _Content(final List<AllPlantModel> allPlantModel) =
      _$ContentImpl;

  @override
  List<AllPlantModel> get allPlantModel;
  @override
  @JsonKey(ignore: true)
  _$$ContentImplCopyWith<_$ContentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SuccessImplCopyWith<$Res>
    implements $AllPlantStateCopyWith<$Res> {
  factory _$$SuccessImplCopyWith(
          _$SuccessImpl value, $Res Function(_$SuccessImpl) then) =
      __$$SuccessImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<AllPlantModel> allPlantModel});
}

/// @nodoc
class __$$SuccessImplCopyWithImpl<$Res>
    extends _$AllPlantStateCopyWithImpl<$Res, _$SuccessImpl>
    implements _$$SuccessImplCopyWith<$Res> {
  __$$SuccessImplCopyWithImpl(
      _$SuccessImpl _value, $Res Function(_$SuccessImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? allPlantModel = null,
  }) {
    return _then(_$SuccessImpl(
      null == allPlantModel
          ? _value._allPlantModel
          : allPlantModel // ignore: cast_nullable_to_non_nullable
              as List<AllPlantModel>,
    ));
  }
}

/// @nodoc

class _$SuccessImpl implements _Success {
  const _$SuccessImpl(final List<AllPlantModel> allPlantModel)
      : _allPlantModel = allPlantModel;

  final List<AllPlantModel> _allPlantModel;
  @override
  List<AllPlantModel> get allPlantModel {
    if (_allPlantModel is EqualUnmodifiableListView) return _allPlantModel;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allPlantModel);
  }

  @override
  String toString() {
    return 'AllPlantState.success(allPlantModel: $allPlantModel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuccessImpl &&
            const DeepCollectionEquality()
                .equals(other._allPlantModel, _allPlantModel));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_allPlantModel));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      __$$SuccessImplCopyWithImpl<_$SuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<AllPlantModel> allPlantModel) loading,
    required TResult Function(List<AllPlantModel> allPlantModel) content,
    required TResult Function(List<AllPlantModel> allPlantModel) success,
    required TResult Function(List<AllPlantModel> allPlantModel, String msg)
        failed,
  }) {
    return success(allPlantModel);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<AllPlantModel> allPlantModel)? loading,
    TResult? Function(List<AllPlantModel> allPlantModel)? content,
    TResult? Function(List<AllPlantModel> allPlantModel)? success,
    TResult? Function(List<AllPlantModel> allPlantModel, String msg)? failed,
  }) {
    return success?.call(allPlantModel);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<AllPlantModel> allPlantModel)? loading,
    TResult Function(List<AllPlantModel> allPlantModel)? content,
    TResult Function(List<AllPlantModel> allPlantModel)? success,
    TResult Function(List<AllPlantModel> allPlantModel, String msg)? failed,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(allPlantModel);
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

abstract class _Success implements AllPlantState {
  const factory _Success(final List<AllPlantModel> allPlantModel) =
      _$SuccessImpl;

  @override
  List<AllPlantModel> get allPlantModel;
  @override
  @JsonKey(ignore: true)
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FailedImplCopyWith<$Res>
    implements $AllPlantStateCopyWith<$Res> {
  factory _$$FailedImplCopyWith(
          _$FailedImpl value, $Res Function(_$FailedImpl) then) =
      __$$FailedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<AllPlantModel> allPlantModel, String msg});
}

/// @nodoc
class __$$FailedImplCopyWithImpl<$Res>
    extends _$AllPlantStateCopyWithImpl<$Res, _$FailedImpl>
    implements _$$FailedImplCopyWith<$Res> {
  __$$FailedImplCopyWithImpl(
      _$FailedImpl _value, $Res Function(_$FailedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? allPlantModel = null,
    Object? msg = null,
  }) {
    return _then(_$FailedImpl(
      null == allPlantModel
          ? _value._allPlantModel
          : allPlantModel // ignore: cast_nullable_to_non_nullable
              as List<AllPlantModel>,
      null == msg
          ? _value.msg
          : msg // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$FailedImpl implements _Failed {
  const _$FailedImpl(final List<AllPlantModel> allPlantModel, this.msg)
      : _allPlantModel = allPlantModel;

  final List<AllPlantModel> _allPlantModel;
  @override
  List<AllPlantModel> get allPlantModel {
    if (_allPlantModel is EqualUnmodifiableListView) return _allPlantModel;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allPlantModel);
  }

  @override
  final String msg;

  @override
  String toString() {
    return 'AllPlantState.failed(allPlantModel: $allPlantModel, msg: $msg)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FailedImpl &&
            const DeepCollectionEquality()
                .equals(other._allPlantModel, _allPlantModel) &&
            (identical(other.msg, msg) || other.msg == msg));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_allPlantModel), msg);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FailedImplCopyWith<_$FailedImpl> get copyWith =>
      __$$FailedImplCopyWithImpl<_$FailedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<AllPlantModel> allPlantModel) loading,
    required TResult Function(List<AllPlantModel> allPlantModel) content,
    required TResult Function(List<AllPlantModel> allPlantModel) success,
    required TResult Function(List<AllPlantModel> allPlantModel, String msg)
        failed,
  }) {
    return failed(allPlantModel, msg);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<AllPlantModel> allPlantModel)? loading,
    TResult? Function(List<AllPlantModel> allPlantModel)? content,
    TResult? Function(List<AllPlantModel> allPlantModel)? success,
    TResult? Function(List<AllPlantModel> allPlantModel, String msg)? failed,
  }) {
    return failed?.call(allPlantModel, msg);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<AllPlantModel> allPlantModel)? loading,
    TResult Function(List<AllPlantModel> allPlantModel)? content,
    TResult Function(List<AllPlantModel> allPlantModel)? success,
    TResult Function(List<AllPlantModel> allPlantModel, String msg)? failed,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed(allPlantModel, msg);
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

abstract class _Failed implements AllPlantState {
  const factory _Failed(
      final List<AllPlantModel> allPlantModel, final String msg) = _$FailedImpl;

  @override
  List<AllPlantModel> get allPlantModel;
  String get msg;
  @override
  @JsonKey(ignore: true)
  _$$FailedImplCopyWith<_$FailedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
