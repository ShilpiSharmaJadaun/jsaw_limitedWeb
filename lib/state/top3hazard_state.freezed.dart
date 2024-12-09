// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'top3hazard_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Top3HazardState {
  List<Top3HazardModel> get top3HazardModel =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<Top3HazardModel> top3HazardModel) loading,
    required TResult Function(List<Top3HazardModel> top3HazardModel) content,
    required TResult Function(List<Top3HazardModel> top3HazardModel) success,
    required TResult Function(List<Top3HazardModel> top3HazardModel, String msg)
        failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<Top3HazardModel> top3HazardModel)? loading,
    TResult? Function(List<Top3HazardModel> top3HazardModel)? content,
    TResult? Function(List<Top3HazardModel> top3HazardModel)? success,
    TResult? Function(List<Top3HazardModel> top3HazardModel, String msg)?
        failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<Top3HazardModel> top3HazardModel)? loading,
    TResult Function(List<Top3HazardModel> top3HazardModel)? content,
    TResult Function(List<Top3HazardModel> top3HazardModel)? success,
    TResult Function(List<Top3HazardModel> top3HazardModel, String msg)? failed,
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
  $Top3HazardStateCopyWith<Top3HazardState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $Top3HazardStateCopyWith<$Res> {
  factory $Top3HazardStateCopyWith(
          Top3HazardState value, $Res Function(Top3HazardState) then) =
      _$Top3HazardStateCopyWithImpl<$Res, Top3HazardState>;
  @useResult
  $Res call({List<Top3HazardModel> top3HazardModel});
}

/// @nodoc
class _$Top3HazardStateCopyWithImpl<$Res, $Val extends Top3HazardState>
    implements $Top3HazardStateCopyWith<$Res> {
  _$Top3HazardStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? top3HazardModel = null,
  }) {
    return _then(_value.copyWith(
      top3HazardModel: null == top3HazardModel
          ? _value.top3HazardModel
          : top3HazardModel // ignore: cast_nullable_to_non_nullable
              as List<Top3HazardModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res>
    implements $Top3HazardStateCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Top3HazardModel> top3HazardModel});
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$Top3HazardStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? top3HazardModel = null,
  }) {
    return _then(_$LoadingImpl(
      null == top3HazardModel
          ? _value._top3HazardModel
          : top3HazardModel // ignore: cast_nullable_to_non_nullable
              as List<Top3HazardModel>,
    ));
  }
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl(final List<Top3HazardModel> top3HazardModel)
      : _top3HazardModel = top3HazardModel;

  final List<Top3HazardModel> _top3HazardModel;
  @override
  List<Top3HazardModel> get top3HazardModel {
    if (_top3HazardModel is EqualUnmodifiableListView) return _top3HazardModel;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_top3HazardModel);
  }

  @override
  String toString() {
    return 'Top3HazardState.loading(top3HazardModel: $top3HazardModel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadingImpl &&
            const DeepCollectionEquality()
                .equals(other._top3HazardModel, _top3HazardModel));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_top3HazardModel));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadingImplCopyWith<_$LoadingImpl> get copyWith =>
      __$$LoadingImplCopyWithImpl<_$LoadingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<Top3HazardModel> top3HazardModel) loading,
    required TResult Function(List<Top3HazardModel> top3HazardModel) content,
    required TResult Function(List<Top3HazardModel> top3HazardModel) success,
    required TResult Function(List<Top3HazardModel> top3HazardModel, String msg)
        failed,
  }) {
    return loading(top3HazardModel);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<Top3HazardModel> top3HazardModel)? loading,
    TResult? Function(List<Top3HazardModel> top3HazardModel)? content,
    TResult? Function(List<Top3HazardModel> top3HazardModel)? success,
    TResult? Function(List<Top3HazardModel> top3HazardModel, String msg)?
        failed,
  }) {
    return loading?.call(top3HazardModel);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<Top3HazardModel> top3HazardModel)? loading,
    TResult Function(List<Top3HazardModel> top3HazardModel)? content,
    TResult Function(List<Top3HazardModel> top3HazardModel)? success,
    TResult Function(List<Top3HazardModel> top3HazardModel, String msg)? failed,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(top3HazardModel);
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

abstract class _Loading implements Top3HazardState {
  const factory _Loading(final List<Top3HazardModel> top3HazardModel) =
      _$LoadingImpl;

  @override
  List<Top3HazardModel> get top3HazardModel;
  @override
  @JsonKey(ignore: true)
  _$$LoadingImplCopyWith<_$LoadingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ContentImplCopyWith<$Res>
    implements $Top3HazardStateCopyWith<$Res> {
  factory _$$ContentImplCopyWith(
          _$ContentImpl value, $Res Function(_$ContentImpl) then) =
      __$$ContentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Top3HazardModel> top3HazardModel});
}

/// @nodoc
class __$$ContentImplCopyWithImpl<$Res>
    extends _$Top3HazardStateCopyWithImpl<$Res, _$ContentImpl>
    implements _$$ContentImplCopyWith<$Res> {
  __$$ContentImplCopyWithImpl(
      _$ContentImpl _value, $Res Function(_$ContentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? top3HazardModel = null,
  }) {
    return _then(_$ContentImpl(
      null == top3HazardModel
          ? _value._top3HazardModel
          : top3HazardModel // ignore: cast_nullable_to_non_nullable
              as List<Top3HazardModel>,
    ));
  }
}

/// @nodoc

class _$ContentImpl implements _Content {
  const _$ContentImpl(final List<Top3HazardModel> top3HazardModel)
      : _top3HazardModel = top3HazardModel;

  final List<Top3HazardModel> _top3HazardModel;
  @override
  List<Top3HazardModel> get top3HazardModel {
    if (_top3HazardModel is EqualUnmodifiableListView) return _top3HazardModel;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_top3HazardModel);
  }

  @override
  String toString() {
    return 'Top3HazardState.content(top3HazardModel: $top3HazardModel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContentImpl &&
            const DeepCollectionEquality()
                .equals(other._top3HazardModel, _top3HazardModel));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_top3HazardModel));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ContentImplCopyWith<_$ContentImpl> get copyWith =>
      __$$ContentImplCopyWithImpl<_$ContentImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<Top3HazardModel> top3HazardModel) loading,
    required TResult Function(List<Top3HazardModel> top3HazardModel) content,
    required TResult Function(List<Top3HazardModel> top3HazardModel) success,
    required TResult Function(List<Top3HazardModel> top3HazardModel, String msg)
        failed,
  }) {
    return content(top3HazardModel);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<Top3HazardModel> top3HazardModel)? loading,
    TResult? Function(List<Top3HazardModel> top3HazardModel)? content,
    TResult? Function(List<Top3HazardModel> top3HazardModel)? success,
    TResult? Function(List<Top3HazardModel> top3HazardModel, String msg)?
        failed,
  }) {
    return content?.call(top3HazardModel);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<Top3HazardModel> top3HazardModel)? loading,
    TResult Function(List<Top3HazardModel> top3HazardModel)? content,
    TResult Function(List<Top3HazardModel> top3HazardModel)? success,
    TResult Function(List<Top3HazardModel> top3HazardModel, String msg)? failed,
    required TResult orElse(),
  }) {
    if (content != null) {
      return content(top3HazardModel);
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

abstract class _Content implements Top3HazardState {
  const factory _Content(final List<Top3HazardModel> top3HazardModel) =
      _$ContentImpl;

  @override
  List<Top3HazardModel> get top3HazardModel;
  @override
  @JsonKey(ignore: true)
  _$$ContentImplCopyWith<_$ContentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SuccessImplCopyWith<$Res>
    implements $Top3HazardStateCopyWith<$Res> {
  factory _$$SuccessImplCopyWith(
          _$SuccessImpl value, $Res Function(_$SuccessImpl) then) =
      __$$SuccessImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Top3HazardModel> top3HazardModel});
}

/// @nodoc
class __$$SuccessImplCopyWithImpl<$Res>
    extends _$Top3HazardStateCopyWithImpl<$Res, _$SuccessImpl>
    implements _$$SuccessImplCopyWith<$Res> {
  __$$SuccessImplCopyWithImpl(
      _$SuccessImpl _value, $Res Function(_$SuccessImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? top3HazardModel = null,
  }) {
    return _then(_$SuccessImpl(
      null == top3HazardModel
          ? _value._top3HazardModel
          : top3HazardModel // ignore: cast_nullable_to_non_nullable
              as List<Top3HazardModel>,
    ));
  }
}

/// @nodoc

class _$SuccessImpl implements _Success {
  const _$SuccessImpl(final List<Top3HazardModel> top3HazardModel)
      : _top3HazardModel = top3HazardModel;

  final List<Top3HazardModel> _top3HazardModel;
  @override
  List<Top3HazardModel> get top3HazardModel {
    if (_top3HazardModel is EqualUnmodifiableListView) return _top3HazardModel;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_top3HazardModel);
  }

  @override
  String toString() {
    return 'Top3HazardState.success(top3HazardModel: $top3HazardModel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuccessImpl &&
            const DeepCollectionEquality()
                .equals(other._top3HazardModel, _top3HazardModel));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_top3HazardModel));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      __$$SuccessImplCopyWithImpl<_$SuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<Top3HazardModel> top3HazardModel) loading,
    required TResult Function(List<Top3HazardModel> top3HazardModel) content,
    required TResult Function(List<Top3HazardModel> top3HazardModel) success,
    required TResult Function(List<Top3HazardModel> top3HazardModel, String msg)
        failed,
  }) {
    return success(top3HazardModel);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<Top3HazardModel> top3HazardModel)? loading,
    TResult? Function(List<Top3HazardModel> top3HazardModel)? content,
    TResult? Function(List<Top3HazardModel> top3HazardModel)? success,
    TResult? Function(List<Top3HazardModel> top3HazardModel, String msg)?
        failed,
  }) {
    return success?.call(top3HazardModel);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<Top3HazardModel> top3HazardModel)? loading,
    TResult Function(List<Top3HazardModel> top3HazardModel)? content,
    TResult Function(List<Top3HazardModel> top3HazardModel)? success,
    TResult Function(List<Top3HazardModel> top3HazardModel, String msg)? failed,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(top3HazardModel);
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

abstract class _Success implements Top3HazardState {
  const factory _Success(final List<Top3HazardModel> top3HazardModel) =
      _$SuccessImpl;

  @override
  List<Top3HazardModel> get top3HazardModel;
  @override
  @JsonKey(ignore: true)
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FailedImplCopyWith<$Res>
    implements $Top3HazardStateCopyWith<$Res> {
  factory _$$FailedImplCopyWith(
          _$FailedImpl value, $Res Function(_$FailedImpl) then) =
      __$$FailedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Top3HazardModel> top3HazardModel, String msg});
}

/// @nodoc
class __$$FailedImplCopyWithImpl<$Res>
    extends _$Top3HazardStateCopyWithImpl<$Res, _$FailedImpl>
    implements _$$FailedImplCopyWith<$Res> {
  __$$FailedImplCopyWithImpl(
      _$FailedImpl _value, $Res Function(_$FailedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? top3HazardModel = null,
    Object? msg = null,
  }) {
    return _then(_$FailedImpl(
      null == top3HazardModel
          ? _value._top3HazardModel
          : top3HazardModel // ignore: cast_nullable_to_non_nullable
              as List<Top3HazardModel>,
      null == msg
          ? _value.msg
          : msg // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$FailedImpl implements _Failed {
  const _$FailedImpl(final List<Top3HazardModel> top3HazardModel, this.msg)
      : _top3HazardModel = top3HazardModel;

  final List<Top3HazardModel> _top3HazardModel;
  @override
  List<Top3HazardModel> get top3HazardModel {
    if (_top3HazardModel is EqualUnmodifiableListView) return _top3HazardModel;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_top3HazardModel);
  }

  @override
  final String msg;

  @override
  String toString() {
    return 'Top3HazardState.failed(top3HazardModel: $top3HazardModel, msg: $msg)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FailedImpl &&
            const DeepCollectionEquality()
                .equals(other._top3HazardModel, _top3HazardModel) &&
            (identical(other.msg, msg) || other.msg == msg));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_top3HazardModel), msg);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FailedImplCopyWith<_$FailedImpl> get copyWith =>
      __$$FailedImplCopyWithImpl<_$FailedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<Top3HazardModel> top3HazardModel) loading,
    required TResult Function(List<Top3HazardModel> top3HazardModel) content,
    required TResult Function(List<Top3HazardModel> top3HazardModel) success,
    required TResult Function(List<Top3HazardModel> top3HazardModel, String msg)
        failed,
  }) {
    return failed(top3HazardModel, msg);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<Top3HazardModel> top3HazardModel)? loading,
    TResult? Function(List<Top3HazardModel> top3HazardModel)? content,
    TResult? Function(List<Top3HazardModel> top3HazardModel)? success,
    TResult? Function(List<Top3HazardModel> top3HazardModel, String msg)?
        failed,
  }) {
    return failed?.call(top3HazardModel, msg);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<Top3HazardModel> top3HazardModel)? loading,
    TResult Function(List<Top3HazardModel> top3HazardModel)? content,
    TResult Function(List<Top3HazardModel> top3HazardModel)? success,
    TResult Function(List<Top3HazardModel> top3HazardModel, String msg)? failed,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed(top3HazardModel, msg);
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

abstract class _Failed implements Top3HazardState {
  const factory _Failed(
          final List<Top3HazardModel> top3HazardModel, final String msg) =
      _$FailedImpl;

  @override
  List<Top3HazardModel> get top3HazardModel;
  String get msg;
  @override
  @JsonKey(ignore: true)
  _$$FailedImplCopyWith<_$FailedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
