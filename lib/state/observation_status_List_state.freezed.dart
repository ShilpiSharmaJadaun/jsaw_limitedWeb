// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'observation_status_List_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ObservationStatusListState {
  List<ObservationStatusListModel> get observationStatusListModel =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            List<ObservationStatusListModel> observationStatusListModel)
        loading,
    required TResult Function(
            List<ObservationStatusListModel> observationStatusListModel)
        content,
    required TResult Function(
            List<ObservationStatusListModel> observationStatusListModel)
        success,
    required TResult Function(
            List<ObservationStatusListModel> observationStatusListModel,
            String msg)
        failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            List<ObservationStatusListModel> observationStatusListModel)?
        loading,
    TResult? Function(
            List<ObservationStatusListModel> observationStatusListModel)?
        content,
    TResult? Function(
            List<ObservationStatusListModel> observationStatusListModel)?
        success,
    TResult? Function(
            List<ObservationStatusListModel> observationStatusListModel,
            String msg)?
        failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            List<ObservationStatusListModel> observationStatusListModel)?
        loading,
    TResult Function(
            List<ObservationStatusListModel> observationStatusListModel)?
        content,
    TResult Function(
            List<ObservationStatusListModel> observationStatusListModel)?
        success,
    TResult Function(
            List<ObservationStatusListModel> observationStatusListModel,
            String msg)?
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
  $ObservationStatusListStateCopyWith<ObservationStatusListState>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ObservationStatusListStateCopyWith<$Res> {
  factory $ObservationStatusListStateCopyWith(ObservationStatusListState value,
          $Res Function(ObservationStatusListState) then) =
      _$ObservationStatusListStateCopyWithImpl<$Res,
          ObservationStatusListState>;
  @useResult
  $Res call({List<ObservationStatusListModel> observationStatusListModel});
}

/// @nodoc
class _$ObservationStatusListStateCopyWithImpl<$Res,
        $Val extends ObservationStatusListState>
    implements $ObservationStatusListStateCopyWith<$Res> {
  _$ObservationStatusListStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? observationStatusListModel = null,
  }) {
    return _then(_value.copyWith(
      observationStatusListModel: null == observationStatusListModel
          ? _value.observationStatusListModel
          : observationStatusListModel // ignore: cast_nullable_to_non_nullable
              as List<ObservationStatusListModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res>
    implements $ObservationStatusListStateCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<ObservationStatusListModel> observationStatusListModel});
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$ObservationStatusListStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? observationStatusListModel = null,
  }) {
    return _then(_$LoadingImpl(
      null == observationStatusListModel
          ? _value._observationStatusListModel
          : observationStatusListModel // ignore: cast_nullable_to_non_nullable
              as List<ObservationStatusListModel>,
    ));
  }
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl(
      final List<ObservationStatusListModel> observationStatusListModel)
      : _observationStatusListModel = observationStatusListModel;

  final List<ObservationStatusListModel> _observationStatusListModel;
  @override
  List<ObservationStatusListModel> get observationStatusListModel {
    if (_observationStatusListModel is EqualUnmodifiableListView)
      return _observationStatusListModel;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_observationStatusListModel);
  }

  @override
  String toString() {
    return 'ObservationStatusListState.loading(observationStatusListModel: $observationStatusListModel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadingImpl &&
            const DeepCollectionEquality().equals(
                other._observationStatusListModel,
                _observationStatusListModel));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_observationStatusListModel));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadingImplCopyWith<_$LoadingImpl> get copyWith =>
      __$$LoadingImplCopyWithImpl<_$LoadingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            List<ObservationStatusListModel> observationStatusListModel)
        loading,
    required TResult Function(
            List<ObservationStatusListModel> observationStatusListModel)
        content,
    required TResult Function(
            List<ObservationStatusListModel> observationStatusListModel)
        success,
    required TResult Function(
            List<ObservationStatusListModel> observationStatusListModel,
            String msg)
        failed,
  }) {
    return loading(observationStatusListModel);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            List<ObservationStatusListModel> observationStatusListModel)?
        loading,
    TResult? Function(
            List<ObservationStatusListModel> observationStatusListModel)?
        content,
    TResult? Function(
            List<ObservationStatusListModel> observationStatusListModel)?
        success,
    TResult? Function(
            List<ObservationStatusListModel> observationStatusListModel,
            String msg)?
        failed,
  }) {
    return loading?.call(observationStatusListModel);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            List<ObservationStatusListModel> observationStatusListModel)?
        loading,
    TResult Function(
            List<ObservationStatusListModel> observationStatusListModel)?
        content,
    TResult Function(
            List<ObservationStatusListModel> observationStatusListModel)?
        success,
    TResult Function(
            List<ObservationStatusListModel> observationStatusListModel,
            String msg)?
        failed,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(observationStatusListModel);
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

abstract class _Loading implements ObservationStatusListState {
  const factory _Loading(
          final List<ObservationStatusListModel> observationStatusListModel) =
      _$LoadingImpl;

  @override
  List<ObservationStatusListModel> get observationStatusListModel;
  @override
  @JsonKey(ignore: true)
  _$$LoadingImplCopyWith<_$LoadingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ContentImplCopyWith<$Res>
    implements $ObservationStatusListStateCopyWith<$Res> {
  factory _$$ContentImplCopyWith(
          _$ContentImpl value, $Res Function(_$ContentImpl) then) =
      __$$ContentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<ObservationStatusListModel> observationStatusListModel});
}

/// @nodoc
class __$$ContentImplCopyWithImpl<$Res>
    extends _$ObservationStatusListStateCopyWithImpl<$Res, _$ContentImpl>
    implements _$$ContentImplCopyWith<$Res> {
  __$$ContentImplCopyWithImpl(
      _$ContentImpl _value, $Res Function(_$ContentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? observationStatusListModel = null,
  }) {
    return _then(_$ContentImpl(
      null == observationStatusListModel
          ? _value._observationStatusListModel
          : observationStatusListModel // ignore: cast_nullable_to_non_nullable
              as List<ObservationStatusListModel>,
    ));
  }
}

/// @nodoc

class _$ContentImpl implements _Content {
  const _$ContentImpl(
      final List<ObservationStatusListModel> observationStatusListModel)
      : _observationStatusListModel = observationStatusListModel;

  final List<ObservationStatusListModel> _observationStatusListModel;
  @override
  List<ObservationStatusListModel> get observationStatusListModel {
    if (_observationStatusListModel is EqualUnmodifiableListView)
      return _observationStatusListModel;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_observationStatusListModel);
  }

  @override
  String toString() {
    return 'ObservationStatusListState.content(observationStatusListModel: $observationStatusListModel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContentImpl &&
            const DeepCollectionEquality().equals(
                other._observationStatusListModel,
                _observationStatusListModel));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_observationStatusListModel));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ContentImplCopyWith<_$ContentImpl> get copyWith =>
      __$$ContentImplCopyWithImpl<_$ContentImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            List<ObservationStatusListModel> observationStatusListModel)
        loading,
    required TResult Function(
            List<ObservationStatusListModel> observationStatusListModel)
        content,
    required TResult Function(
            List<ObservationStatusListModel> observationStatusListModel)
        success,
    required TResult Function(
            List<ObservationStatusListModel> observationStatusListModel,
            String msg)
        failed,
  }) {
    return content(observationStatusListModel);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            List<ObservationStatusListModel> observationStatusListModel)?
        loading,
    TResult? Function(
            List<ObservationStatusListModel> observationStatusListModel)?
        content,
    TResult? Function(
            List<ObservationStatusListModel> observationStatusListModel)?
        success,
    TResult? Function(
            List<ObservationStatusListModel> observationStatusListModel,
            String msg)?
        failed,
  }) {
    return content?.call(observationStatusListModel);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            List<ObservationStatusListModel> observationStatusListModel)?
        loading,
    TResult Function(
            List<ObservationStatusListModel> observationStatusListModel)?
        content,
    TResult Function(
            List<ObservationStatusListModel> observationStatusListModel)?
        success,
    TResult Function(
            List<ObservationStatusListModel> observationStatusListModel,
            String msg)?
        failed,
    required TResult orElse(),
  }) {
    if (content != null) {
      return content(observationStatusListModel);
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

abstract class _Content implements ObservationStatusListState {
  const factory _Content(
          final List<ObservationStatusListModel> observationStatusListModel) =
      _$ContentImpl;

  @override
  List<ObservationStatusListModel> get observationStatusListModel;
  @override
  @JsonKey(ignore: true)
  _$$ContentImplCopyWith<_$ContentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SuccessImplCopyWith<$Res>
    implements $ObservationStatusListStateCopyWith<$Res> {
  factory _$$SuccessImplCopyWith(
          _$SuccessImpl value, $Res Function(_$SuccessImpl) then) =
      __$$SuccessImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<ObservationStatusListModel> observationStatusListModel});
}

/// @nodoc
class __$$SuccessImplCopyWithImpl<$Res>
    extends _$ObservationStatusListStateCopyWithImpl<$Res, _$SuccessImpl>
    implements _$$SuccessImplCopyWith<$Res> {
  __$$SuccessImplCopyWithImpl(
      _$SuccessImpl _value, $Res Function(_$SuccessImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? observationStatusListModel = null,
  }) {
    return _then(_$SuccessImpl(
      null == observationStatusListModel
          ? _value._observationStatusListModel
          : observationStatusListModel // ignore: cast_nullable_to_non_nullable
              as List<ObservationStatusListModel>,
    ));
  }
}

/// @nodoc

class _$SuccessImpl implements _Success {
  const _$SuccessImpl(
      final List<ObservationStatusListModel> observationStatusListModel)
      : _observationStatusListModel = observationStatusListModel;

  final List<ObservationStatusListModel> _observationStatusListModel;
  @override
  List<ObservationStatusListModel> get observationStatusListModel {
    if (_observationStatusListModel is EqualUnmodifiableListView)
      return _observationStatusListModel;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_observationStatusListModel);
  }

  @override
  String toString() {
    return 'ObservationStatusListState.success(observationStatusListModel: $observationStatusListModel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuccessImpl &&
            const DeepCollectionEquality().equals(
                other._observationStatusListModel,
                _observationStatusListModel));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_observationStatusListModel));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      __$$SuccessImplCopyWithImpl<_$SuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            List<ObservationStatusListModel> observationStatusListModel)
        loading,
    required TResult Function(
            List<ObservationStatusListModel> observationStatusListModel)
        content,
    required TResult Function(
            List<ObservationStatusListModel> observationStatusListModel)
        success,
    required TResult Function(
            List<ObservationStatusListModel> observationStatusListModel,
            String msg)
        failed,
  }) {
    return success(observationStatusListModel);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            List<ObservationStatusListModel> observationStatusListModel)?
        loading,
    TResult? Function(
            List<ObservationStatusListModel> observationStatusListModel)?
        content,
    TResult? Function(
            List<ObservationStatusListModel> observationStatusListModel)?
        success,
    TResult? Function(
            List<ObservationStatusListModel> observationStatusListModel,
            String msg)?
        failed,
  }) {
    return success?.call(observationStatusListModel);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            List<ObservationStatusListModel> observationStatusListModel)?
        loading,
    TResult Function(
            List<ObservationStatusListModel> observationStatusListModel)?
        content,
    TResult Function(
            List<ObservationStatusListModel> observationStatusListModel)?
        success,
    TResult Function(
            List<ObservationStatusListModel> observationStatusListModel,
            String msg)?
        failed,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(observationStatusListModel);
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

abstract class _Success implements ObservationStatusListState {
  const factory _Success(
          final List<ObservationStatusListModel> observationStatusListModel) =
      _$SuccessImpl;

  @override
  List<ObservationStatusListModel> get observationStatusListModel;
  @override
  @JsonKey(ignore: true)
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FailedImplCopyWith<$Res>
    implements $ObservationStatusListStateCopyWith<$Res> {
  factory _$$FailedImplCopyWith(
          _$FailedImpl value, $Res Function(_$FailedImpl) then) =
      __$$FailedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<ObservationStatusListModel> observationStatusListModel,
      String msg});
}

/// @nodoc
class __$$FailedImplCopyWithImpl<$Res>
    extends _$ObservationStatusListStateCopyWithImpl<$Res, _$FailedImpl>
    implements _$$FailedImplCopyWith<$Res> {
  __$$FailedImplCopyWithImpl(
      _$FailedImpl _value, $Res Function(_$FailedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? observationStatusListModel = null,
    Object? msg = null,
  }) {
    return _then(_$FailedImpl(
      null == observationStatusListModel
          ? _value._observationStatusListModel
          : observationStatusListModel // ignore: cast_nullable_to_non_nullable
              as List<ObservationStatusListModel>,
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
      final List<ObservationStatusListModel> observationStatusListModel,
      this.msg)
      : _observationStatusListModel = observationStatusListModel;

  final List<ObservationStatusListModel> _observationStatusListModel;
  @override
  List<ObservationStatusListModel> get observationStatusListModel {
    if (_observationStatusListModel is EqualUnmodifiableListView)
      return _observationStatusListModel;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_observationStatusListModel);
  }

  @override
  final String msg;

  @override
  String toString() {
    return 'ObservationStatusListState.failed(observationStatusListModel: $observationStatusListModel, msg: $msg)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FailedImpl &&
            const DeepCollectionEquality().equals(
                other._observationStatusListModel,
                _observationStatusListModel) &&
            (identical(other.msg, msg) || other.msg == msg));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_observationStatusListModel), msg);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FailedImplCopyWith<_$FailedImpl> get copyWith =>
      __$$FailedImplCopyWithImpl<_$FailedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            List<ObservationStatusListModel> observationStatusListModel)
        loading,
    required TResult Function(
            List<ObservationStatusListModel> observationStatusListModel)
        content,
    required TResult Function(
            List<ObservationStatusListModel> observationStatusListModel)
        success,
    required TResult Function(
            List<ObservationStatusListModel> observationStatusListModel,
            String msg)
        failed,
  }) {
    return failed(observationStatusListModel, msg);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            List<ObservationStatusListModel> observationStatusListModel)?
        loading,
    TResult? Function(
            List<ObservationStatusListModel> observationStatusListModel)?
        content,
    TResult? Function(
            List<ObservationStatusListModel> observationStatusListModel)?
        success,
    TResult? Function(
            List<ObservationStatusListModel> observationStatusListModel,
            String msg)?
        failed,
  }) {
    return failed?.call(observationStatusListModel, msg);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            List<ObservationStatusListModel> observationStatusListModel)?
        loading,
    TResult Function(
            List<ObservationStatusListModel> observationStatusListModel)?
        content,
    TResult Function(
            List<ObservationStatusListModel> observationStatusListModel)?
        success,
    TResult Function(
            List<ObservationStatusListModel> observationStatusListModel,
            String msg)?
        failed,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed(observationStatusListModel, msg);
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

abstract class _Failed implements ObservationStatusListState {
  const factory _Failed(
      final List<ObservationStatusListModel> observationStatusListModel,
      final String msg) = _$FailedImpl;

  @override
  List<ObservationStatusListModel> get observationStatusListModel;
  String get msg;
  @override
  @JsonKey(ignore: true)
  _$$FailedImplCopyWith<_$FailedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
