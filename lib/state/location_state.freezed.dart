// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'location_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$LocationState {
  List<LocationModel> get locationModel => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<LocationModel> locationModel) loading,
    required TResult Function(List<LocationModel> locationModel) content,
    required TResult Function(List<LocationModel> locationModel) success,
    required TResult Function(List<LocationModel> locationModel, String msg)
        failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<LocationModel> locationModel)? loading,
    TResult? Function(List<LocationModel> locationModel)? content,
    TResult? Function(List<LocationModel> locationModel)? success,
    TResult? Function(List<LocationModel> locationModel, String msg)? failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<LocationModel> locationModel)? loading,
    TResult Function(List<LocationModel> locationModel)? content,
    TResult Function(List<LocationModel> locationModel)? success,
    TResult Function(List<LocationModel> locationModel, String msg)? failed,
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
  $LocationStateCopyWith<LocationState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocationStateCopyWith<$Res> {
  factory $LocationStateCopyWith(
          LocationState value, $Res Function(LocationState) then) =
      _$LocationStateCopyWithImpl<$Res, LocationState>;
  @useResult
  $Res call({List<LocationModel> locationModel});
}

/// @nodoc
class _$LocationStateCopyWithImpl<$Res, $Val extends LocationState>
    implements $LocationStateCopyWith<$Res> {
  _$LocationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? locationModel = null,
  }) {
    return _then(_value.copyWith(
      locationModel: null == locationModel
          ? _value.locationModel
          : locationModel // ignore: cast_nullable_to_non_nullable
              as List<LocationModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res>
    implements $LocationStateCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<LocationModel> locationModel});
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$LocationStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? locationModel = null,
  }) {
    return _then(_$LoadingImpl(
      null == locationModel
          ? _value._locationModel
          : locationModel // ignore: cast_nullable_to_non_nullable
              as List<LocationModel>,
    ));
  }
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl(final List<LocationModel> locationModel)
      : _locationModel = locationModel;

  final List<LocationModel> _locationModel;
  @override
  List<LocationModel> get locationModel {
    if (_locationModel is EqualUnmodifiableListView) return _locationModel;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_locationModel);
  }

  @override
  String toString() {
    return 'LocationState.loading(locationModel: $locationModel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadingImpl &&
            const DeepCollectionEquality()
                .equals(other._locationModel, _locationModel));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_locationModel));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadingImplCopyWith<_$LoadingImpl> get copyWith =>
      __$$LoadingImplCopyWithImpl<_$LoadingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<LocationModel> locationModel) loading,
    required TResult Function(List<LocationModel> locationModel) content,
    required TResult Function(List<LocationModel> locationModel) success,
    required TResult Function(List<LocationModel> locationModel, String msg)
        failed,
  }) {
    return loading(locationModel);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<LocationModel> locationModel)? loading,
    TResult? Function(List<LocationModel> locationModel)? content,
    TResult? Function(List<LocationModel> locationModel)? success,
    TResult? Function(List<LocationModel> locationModel, String msg)? failed,
  }) {
    return loading?.call(locationModel);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<LocationModel> locationModel)? loading,
    TResult Function(List<LocationModel> locationModel)? content,
    TResult Function(List<LocationModel> locationModel)? success,
    TResult Function(List<LocationModel> locationModel, String msg)? failed,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(locationModel);
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

abstract class _Loading implements LocationState {
  const factory _Loading(final List<LocationModel> locationModel) =
      _$LoadingImpl;

  @override
  List<LocationModel> get locationModel;
  @override
  @JsonKey(ignore: true)
  _$$LoadingImplCopyWith<_$LoadingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ContentImplCopyWith<$Res>
    implements $LocationStateCopyWith<$Res> {
  factory _$$ContentImplCopyWith(
          _$ContentImpl value, $Res Function(_$ContentImpl) then) =
      __$$ContentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<LocationModel> locationModel});
}

/// @nodoc
class __$$ContentImplCopyWithImpl<$Res>
    extends _$LocationStateCopyWithImpl<$Res, _$ContentImpl>
    implements _$$ContentImplCopyWith<$Res> {
  __$$ContentImplCopyWithImpl(
      _$ContentImpl _value, $Res Function(_$ContentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? locationModel = null,
  }) {
    return _then(_$ContentImpl(
      null == locationModel
          ? _value._locationModel
          : locationModel // ignore: cast_nullable_to_non_nullable
              as List<LocationModel>,
    ));
  }
}

/// @nodoc

class _$ContentImpl implements _Content {
  const _$ContentImpl(final List<LocationModel> locationModel)
      : _locationModel = locationModel;

  final List<LocationModel> _locationModel;
  @override
  List<LocationModel> get locationModel {
    if (_locationModel is EqualUnmodifiableListView) return _locationModel;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_locationModel);
  }

  @override
  String toString() {
    return 'LocationState.content(locationModel: $locationModel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContentImpl &&
            const DeepCollectionEquality()
                .equals(other._locationModel, _locationModel));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_locationModel));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ContentImplCopyWith<_$ContentImpl> get copyWith =>
      __$$ContentImplCopyWithImpl<_$ContentImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<LocationModel> locationModel) loading,
    required TResult Function(List<LocationModel> locationModel) content,
    required TResult Function(List<LocationModel> locationModel) success,
    required TResult Function(List<LocationModel> locationModel, String msg)
        failed,
  }) {
    return content(locationModel);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<LocationModel> locationModel)? loading,
    TResult? Function(List<LocationModel> locationModel)? content,
    TResult? Function(List<LocationModel> locationModel)? success,
    TResult? Function(List<LocationModel> locationModel, String msg)? failed,
  }) {
    return content?.call(locationModel);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<LocationModel> locationModel)? loading,
    TResult Function(List<LocationModel> locationModel)? content,
    TResult Function(List<LocationModel> locationModel)? success,
    TResult Function(List<LocationModel> locationModel, String msg)? failed,
    required TResult orElse(),
  }) {
    if (content != null) {
      return content(locationModel);
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

abstract class _Content implements LocationState {
  const factory _Content(final List<LocationModel> locationModel) =
      _$ContentImpl;

  @override
  List<LocationModel> get locationModel;
  @override
  @JsonKey(ignore: true)
  _$$ContentImplCopyWith<_$ContentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SuccessImplCopyWith<$Res>
    implements $LocationStateCopyWith<$Res> {
  factory _$$SuccessImplCopyWith(
          _$SuccessImpl value, $Res Function(_$SuccessImpl) then) =
      __$$SuccessImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<LocationModel> locationModel});
}

/// @nodoc
class __$$SuccessImplCopyWithImpl<$Res>
    extends _$LocationStateCopyWithImpl<$Res, _$SuccessImpl>
    implements _$$SuccessImplCopyWith<$Res> {
  __$$SuccessImplCopyWithImpl(
      _$SuccessImpl _value, $Res Function(_$SuccessImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? locationModel = null,
  }) {
    return _then(_$SuccessImpl(
      null == locationModel
          ? _value._locationModel
          : locationModel // ignore: cast_nullable_to_non_nullable
              as List<LocationModel>,
    ));
  }
}

/// @nodoc

class _$SuccessImpl implements _Success {
  const _$SuccessImpl(final List<LocationModel> locationModel)
      : _locationModel = locationModel;

  final List<LocationModel> _locationModel;
  @override
  List<LocationModel> get locationModel {
    if (_locationModel is EqualUnmodifiableListView) return _locationModel;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_locationModel);
  }

  @override
  String toString() {
    return 'LocationState.success(locationModel: $locationModel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuccessImpl &&
            const DeepCollectionEquality()
                .equals(other._locationModel, _locationModel));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_locationModel));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      __$$SuccessImplCopyWithImpl<_$SuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<LocationModel> locationModel) loading,
    required TResult Function(List<LocationModel> locationModel) content,
    required TResult Function(List<LocationModel> locationModel) success,
    required TResult Function(List<LocationModel> locationModel, String msg)
        failed,
  }) {
    return success(locationModel);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<LocationModel> locationModel)? loading,
    TResult? Function(List<LocationModel> locationModel)? content,
    TResult? Function(List<LocationModel> locationModel)? success,
    TResult? Function(List<LocationModel> locationModel, String msg)? failed,
  }) {
    return success?.call(locationModel);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<LocationModel> locationModel)? loading,
    TResult Function(List<LocationModel> locationModel)? content,
    TResult Function(List<LocationModel> locationModel)? success,
    TResult Function(List<LocationModel> locationModel, String msg)? failed,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(locationModel);
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

abstract class _Success implements LocationState {
  const factory _Success(final List<LocationModel> locationModel) =
      _$SuccessImpl;

  @override
  List<LocationModel> get locationModel;
  @override
  @JsonKey(ignore: true)
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FailedImplCopyWith<$Res>
    implements $LocationStateCopyWith<$Res> {
  factory _$$FailedImplCopyWith(
          _$FailedImpl value, $Res Function(_$FailedImpl) then) =
      __$$FailedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<LocationModel> locationModel, String msg});
}

/// @nodoc
class __$$FailedImplCopyWithImpl<$Res>
    extends _$LocationStateCopyWithImpl<$Res, _$FailedImpl>
    implements _$$FailedImplCopyWith<$Res> {
  __$$FailedImplCopyWithImpl(
      _$FailedImpl _value, $Res Function(_$FailedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? locationModel = null,
    Object? msg = null,
  }) {
    return _then(_$FailedImpl(
      null == locationModel
          ? _value._locationModel
          : locationModel // ignore: cast_nullable_to_non_nullable
              as List<LocationModel>,
      null == msg
          ? _value.msg
          : msg // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$FailedImpl implements _Failed {
  const _$FailedImpl(final List<LocationModel> locationModel, this.msg)
      : _locationModel = locationModel;

  final List<LocationModel> _locationModel;
  @override
  List<LocationModel> get locationModel {
    if (_locationModel is EqualUnmodifiableListView) return _locationModel;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_locationModel);
  }

  @override
  final String msg;

  @override
  String toString() {
    return 'LocationState.failed(locationModel: $locationModel, msg: $msg)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FailedImpl &&
            const DeepCollectionEquality()
                .equals(other._locationModel, _locationModel) &&
            (identical(other.msg, msg) || other.msg == msg));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_locationModel), msg);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FailedImplCopyWith<_$FailedImpl> get copyWith =>
      __$$FailedImplCopyWithImpl<_$FailedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<LocationModel> locationModel) loading,
    required TResult Function(List<LocationModel> locationModel) content,
    required TResult Function(List<LocationModel> locationModel) success,
    required TResult Function(List<LocationModel> locationModel, String msg)
        failed,
  }) {
    return failed(locationModel, msg);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<LocationModel> locationModel)? loading,
    TResult? Function(List<LocationModel> locationModel)? content,
    TResult? Function(List<LocationModel> locationModel)? success,
    TResult? Function(List<LocationModel> locationModel, String msg)? failed,
  }) {
    return failed?.call(locationModel, msg);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<LocationModel> locationModel)? loading,
    TResult Function(List<LocationModel> locationModel)? content,
    TResult Function(List<LocationModel> locationModel)? success,
    TResult Function(List<LocationModel> locationModel, String msg)? failed,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed(locationModel, msg);
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

abstract class _Failed implements LocationState {
  const factory _Failed(
      final List<LocationModel> locationModel, final String msg) = _$FailedImpl;

  @override
  List<LocationModel> get locationModel;
  String get msg;
  @override
  @JsonKey(ignore: true)
  _$$FailedImplCopyWith<_$FailedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
