// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'allhazard_cat_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AllHazardCatState {
  List<AllHazardCatModel> get allHazardCategory =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<AllHazardCatModel> allHazardCategory)
        loading,
    required TResult Function(List<AllHazardCatModel> allHazardCategory)
        content,
    required TResult Function(List<AllHazardCatModel> allHazardCategory)
        success,
    required TResult Function(
            List<AllHazardCatModel> allHazardCategory, String msg)
        failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<AllHazardCatModel> allHazardCategory)? loading,
    TResult? Function(List<AllHazardCatModel> allHazardCategory)? content,
    TResult? Function(List<AllHazardCatModel> allHazardCategory)? success,
    TResult? Function(List<AllHazardCatModel> allHazardCategory, String msg)?
        failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<AllHazardCatModel> allHazardCategory)? loading,
    TResult Function(List<AllHazardCatModel> allHazardCategory)? content,
    TResult Function(List<AllHazardCatModel> allHazardCategory)? success,
    TResult Function(List<AllHazardCatModel> allHazardCategory, String msg)?
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
  $AllHazardCatStateCopyWith<AllHazardCatState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AllHazardCatStateCopyWith<$Res> {
  factory $AllHazardCatStateCopyWith(
          AllHazardCatState value, $Res Function(AllHazardCatState) then) =
      _$AllHazardCatStateCopyWithImpl<$Res, AllHazardCatState>;
  @useResult
  $Res call({List<AllHazardCatModel> allHazardCategory});
}

/// @nodoc
class _$AllHazardCatStateCopyWithImpl<$Res, $Val extends AllHazardCatState>
    implements $AllHazardCatStateCopyWith<$Res> {
  _$AllHazardCatStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? allHazardCategory = null,
  }) {
    return _then(_value.copyWith(
      allHazardCategory: null == allHazardCategory
          ? _value.allHazardCategory
          : allHazardCategory // ignore: cast_nullable_to_non_nullable
              as List<AllHazardCatModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res>
    implements $AllHazardCatStateCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<AllHazardCatModel> allHazardCategory});
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$AllHazardCatStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? allHazardCategory = null,
  }) {
    return _then(_$LoadingImpl(
      null == allHazardCategory
          ? _value._allHazardCategory
          : allHazardCategory // ignore: cast_nullable_to_non_nullable
              as List<AllHazardCatModel>,
    ));
  }
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl(final List<AllHazardCatModel> allHazardCategory)
      : _allHazardCategory = allHazardCategory;

  final List<AllHazardCatModel> _allHazardCategory;
  @override
  List<AllHazardCatModel> get allHazardCategory {
    if (_allHazardCategory is EqualUnmodifiableListView)
      return _allHazardCategory;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allHazardCategory);
  }

  @override
  String toString() {
    return 'AllHazardCatState.loading(allHazardCategory: $allHazardCategory)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadingImpl &&
            const DeepCollectionEquality()
                .equals(other._allHazardCategory, _allHazardCategory));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_allHazardCategory));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadingImplCopyWith<_$LoadingImpl> get copyWith =>
      __$$LoadingImplCopyWithImpl<_$LoadingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<AllHazardCatModel> allHazardCategory)
        loading,
    required TResult Function(List<AllHazardCatModel> allHazardCategory)
        content,
    required TResult Function(List<AllHazardCatModel> allHazardCategory)
        success,
    required TResult Function(
            List<AllHazardCatModel> allHazardCategory, String msg)
        failed,
  }) {
    return loading(allHazardCategory);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<AllHazardCatModel> allHazardCategory)? loading,
    TResult? Function(List<AllHazardCatModel> allHazardCategory)? content,
    TResult? Function(List<AllHazardCatModel> allHazardCategory)? success,
    TResult? Function(List<AllHazardCatModel> allHazardCategory, String msg)?
        failed,
  }) {
    return loading?.call(allHazardCategory);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<AllHazardCatModel> allHazardCategory)? loading,
    TResult Function(List<AllHazardCatModel> allHazardCategory)? content,
    TResult Function(List<AllHazardCatModel> allHazardCategory)? success,
    TResult Function(List<AllHazardCatModel> allHazardCategory, String msg)?
        failed,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(allHazardCategory);
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

abstract class _Loading implements AllHazardCatState {
  const factory _Loading(final List<AllHazardCatModel> allHazardCategory) =
      _$LoadingImpl;

  @override
  List<AllHazardCatModel> get allHazardCategory;
  @override
  @JsonKey(ignore: true)
  _$$LoadingImplCopyWith<_$LoadingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ContentImplCopyWith<$Res>
    implements $AllHazardCatStateCopyWith<$Res> {
  factory _$$ContentImplCopyWith(
          _$ContentImpl value, $Res Function(_$ContentImpl) then) =
      __$$ContentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<AllHazardCatModel> allHazardCategory});
}

/// @nodoc
class __$$ContentImplCopyWithImpl<$Res>
    extends _$AllHazardCatStateCopyWithImpl<$Res, _$ContentImpl>
    implements _$$ContentImplCopyWith<$Res> {
  __$$ContentImplCopyWithImpl(
      _$ContentImpl _value, $Res Function(_$ContentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? allHazardCategory = null,
  }) {
    return _then(_$ContentImpl(
      null == allHazardCategory
          ? _value._allHazardCategory
          : allHazardCategory // ignore: cast_nullable_to_non_nullable
              as List<AllHazardCatModel>,
    ));
  }
}

/// @nodoc

class _$ContentImpl implements _Content {
  const _$ContentImpl(final List<AllHazardCatModel> allHazardCategory)
      : _allHazardCategory = allHazardCategory;

  final List<AllHazardCatModel> _allHazardCategory;
  @override
  List<AllHazardCatModel> get allHazardCategory {
    if (_allHazardCategory is EqualUnmodifiableListView)
      return _allHazardCategory;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allHazardCategory);
  }

  @override
  String toString() {
    return 'AllHazardCatState.content(allHazardCategory: $allHazardCategory)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContentImpl &&
            const DeepCollectionEquality()
                .equals(other._allHazardCategory, _allHazardCategory));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_allHazardCategory));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ContentImplCopyWith<_$ContentImpl> get copyWith =>
      __$$ContentImplCopyWithImpl<_$ContentImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<AllHazardCatModel> allHazardCategory)
        loading,
    required TResult Function(List<AllHazardCatModel> allHazardCategory)
        content,
    required TResult Function(List<AllHazardCatModel> allHazardCategory)
        success,
    required TResult Function(
            List<AllHazardCatModel> allHazardCategory, String msg)
        failed,
  }) {
    return content(allHazardCategory);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<AllHazardCatModel> allHazardCategory)? loading,
    TResult? Function(List<AllHazardCatModel> allHazardCategory)? content,
    TResult? Function(List<AllHazardCatModel> allHazardCategory)? success,
    TResult? Function(List<AllHazardCatModel> allHazardCategory, String msg)?
        failed,
  }) {
    return content?.call(allHazardCategory);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<AllHazardCatModel> allHazardCategory)? loading,
    TResult Function(List<AllHazardCatModel> allHazardCategory)? content,
    TResult Function(List<AllHazardCatModel> allHazardCategory)? success,
    TResult Function(List<AllHazardCatModel> allHazardCategory, String msg)?
        failed,
    required TResult orElse(),
  }) {
    if (content != null) {
      return content(allHazardCategory);
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

abstract class _Content implements AllHazardCatState {
  const factory _Content(final List<AllHazardCatModel> allHazardCategory) =
      _$ContentImpl;

  @override
  List<AllHazardCatModel> get allHazardCategory;
  @override
  @JsonKey(ignore: true)
  _$$ContentImplCopyWith<_$ContentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SuccessImplCopyWith<$Res>
    implements $AllHazardCatStateCopyWith<$Res> {
  factory _$$SuccessImplCopyWith(
          _$SuccessImpl value, $Res Function(_$SuccessImpl) then) =
      __$$SuccessImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<AllHazardCatModel> allHazardCategory});
}

/// @nodoc
class __$$SuccessImplCopyWithImpl<$Res>
    extends _$AllHazardCatStateCopyWithImpl<$Res, _$SuccessImpl>
    implements _$$SuccessImplCopyWith<$Res> {
  __$$SuccessImplCopyWithImpl(
      _$SuccessImpl _value, $Res Function(_$SuccessImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? allHazardCategory = null,
  }) {
    return _then(_$SuccessImpl(
      null == allHazardCategory
          ? _value._allHazardCategory
          : allHazardCategory // ignore: cast_nullable_to_non_nullable
              as List<AllHazardCatModel>,
    ));
  }
}

/// @nodoc

class _$SuccessImpl implements _Success {
  const _$SuccessImpl(final List<AllHazardCatModel> allHazardCategory)
      : _allHazardCategory = allHazardCategory;

  final List<AllHazardCatModel> _allHazardCategory;
  @override
  List<AllHazardCatModel> get allHazardCategory {
    if (_allHazardCategory is EqualUnmodifiableListView)
      return _allHazardCategory;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allHazardCategory);
  }

  @override
  String toString() {
    return 'AllHazardCatState.success(allHazardCategory: $allHazardCategory)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuccessImpl &&
            const DeepCollectionEquality()
                .equals(other._allHazardCategory, _allHazardCategory));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_allHazardCategory));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      __$$SuccessImplCopyWithImpl<_$SuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<AllHazardCatModel> allHazardCategory)
        loading,
    required TResult Function(List<AllHazardCatModel> allHazardCategory)
        content,
    required TResult Function(List<AllHazardCatModel> allHazardCategory)
        success,
    required TResult Function(
            List<AllHazardCatModel> allHazardCategory, String msg)
        failed,
  }) {
    return success(allHazardCategory);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<AllHazardCatModel> allHazardCategory)? loading,
    TResult? Function(List<AllHazardCatModel> allHazardCategory)? content,
    TResult? Function(List<AllHazardCatModel> allHazardCategory)? success,
    TResult? Function(List<AllHazardCatModel> allHazardCategory, String msg)?
        failed,
  }) {
    return success?.call(allHazardCategory);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<AllHazardCatModel> allHazardCategory)? loading,
    TResult Function(List<AllHazardCatModel> allHazardCategory)? content,
    TResult Function(List<AllHazardCatModel> allHazardCategory)? success,
    TResult Function(List<AllHazardCatModel> allHazardCategory, String msg)?
        failed,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(allHazardCategory);
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

abstract class _Success implements AllHazardCatState {
  const factory _Success(final List<AllHazardCatModel> allHazardCategory) =
      _$SuccessImpl;

  @override
  List<AllHazardCatModel> get allHazardCategory;
  @override
  @JsonKey(ignore: true)
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FailedImplCopyWith<$Res>
    implements $AllHazardCatStateCopyWith<$Res> {
  factory _$$FailedImplCopyWith(
          _$FailedImpl value, $Res Function(_$FailedImpl) then) =
      __$$FailedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<AllHazardCatModel> allHazardCategory, String msg});
}

/// @nodoc
class __$$FailedImplCopyWithImpl<$Res>
    extends _$AllHazardCatStateCopyWithImpl<$Res, _$FailedImpl>
    implements _$$FailedImplCopyWith<$Res> {
  __$$FailedImplCopyWithImpl(
      _$FailedImpl _value, $Res Function(_$FailedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? allHazardCategory = null,
    Object? msg = null,
  }) {
    return _then(_$FailedImpl(
      null == allHazardCategory
          ? _value._allHazardCategory
          : allHazardCategory // ignore: cast_nullable_to_non_nullable
              as List<AllHazardCatModel>,
      null == msg
          ? _value.msg
          : msg // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$FailedImpl implements _Failed {
  const _$FailedImpl(final List<AllHazardCatModel> allHazardCategory, this.msg)
      : _allHazardCategory = allHazardCategory;

  final List<AllHazardCatModel> _allHazardCategory;
  @override
  List<AllHazardCatModel> get allHazardCategory {
    if (_allHazardCategory is EqualUnmodifiableListView)
      return _allHazardCategory;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allHazardCategory);
  }

  @override
  final String msg;

  @override
  String toString() {
    return 'AllHazardCatState.failed(allHazardCategory: $allHazardCategory, msg: $msg)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FailedImpl &&
            const DeepCollectionEquality()
                .equals(other._allHazardCategory, _allHazardCategory) &&
            (identical(other.msg, msg) || other.msg == msg));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_allHazardCategory), msg);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FailedImplCopyWith<_$FailedImpl> get copyWith =>
      __$$FailedImplCopyWithImpl<_$FailedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<AllHazardCatModel> allHazardCategory)
        loading,
    required TResult Function(List<AllHazardCatModel> allHazardCategory)
        content,
    required TResult Function(List<AllHazardCatModel> allHazardCategory)
        success,
    required TResult Function(
            List<AllHazardCatModel> allHazardCategory, String msg)
        failed,
  }) {
    return failed(allHazardCategory, msg);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<AllHazardCatModel> allHazardCategory)? loading,
    TResult? Function(List<AllHazardCatModel> allHazardCategory)? content,
    TResult? Function(List<AllHazardCatModel> allHazardCategory)? success,
    TResult? Function(List<AllHazardCatModel> allHazardCategory, String msg)?
        failed,
  }) {
    return failed?.call(allHazardCategory, msg);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<AllHazardCatModel> allHazardCategory)? loading,
    TResult Function(List<AllHazardCatModel> allHazardCategory)? content,
    TResult Function(List<AllHazardCatModel> allHazardCategory)? success,
    TResult Function(List<AllHazardCatModel> allHazardCategory, String msg)?
        failed,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed(allHazardCategory, msg);
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

abstract class _Failed implements AllHazardCatState {
  const factory _Failed(
          final List<AllHazardCatModel> allHazardCategory, final String msg) =
      _$FailedImpl;

  @override
  List<AllHazardCatModel> get allHazardCategory;
  String get msg;
  @override
  @JsonKey(ignore: true)
  _$$FailedImplCopyWith<_$FailedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
