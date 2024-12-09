// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'changeobservationimage_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ChangeObservationImageState {
  ChangeObservationImageModel get changeObservationImage =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            ChangeObservationImageModel changeObservationImage)
        loading,
    required TResult Function(
            ChangeObservationImageModel changeObservationImage)
        content,
    required TResult Function(
            ChangeObservationImageModel changeObservationImage, String msg)
        success,
    required TResult Function(
            ChangeObservationImageModel changeObservationImage, String msg)
        failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ChangeObservationImageModel changeObservationImage)?
        loading,
    TResult? Function(ChangeObservationImageModel changeObservationImage)?
        content,
    TResult? Function(
            ChangeObservationImageModel changeObservationImage, String msg)?
        success,
    TResult? Function(
            ChangeObservationImageModel changeObservationImage, String msg)?
        failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ChangeObservationImageModel changeObservationImage)?
        loading,
    TResult Function(ChangeObservationImageModel changeObservationImage)?
        content,
    TResult Function(
            ChangeObservationImageModel changeObservationImage, String msg)?
        success,
    TResult Function(
            ChangeObservationImageModel changeObservationImage, String msg)?
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
  $ChangeObservationImageStateCopyWith<ChangeObservationImageState>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChangeObservationImageStateCopyWith<$Res> {
  factory $ChangeObservationImageStateCopyWith(
          ChangeObservationImageState value,
          $Res Function(ChangeObservationImageState) then) =
      _$ChangeObservationImageStateCopyWithImpl<$Res,
          ChangeObservationImageState>;
  @useResult
  $Res call({ChangeObservationImageModel changeObservationImage});

  $ChangeObservationImageModelCopyWith<$Res> get changeObservationImage;
}

/// @nodoc
class _$ChangeObservationImageStateCopyWithImpl<$Res,
        $Val extends ChangeObservationImageState>
    implements $ChangeObservationImageStateCopyWith<$Res> {
  _$ChangeObservationImageStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? changeObservationImage = null,
  }) {
    return _then(_value.copyWith(
      changeObservationImage: null == changeObservationImage
          ? _value.changeObservationImage
          : changeObservationImage // ignore: cast_nullable_to_non_nullable
              as ChangeObservationImageModel,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ChangeObservationImageModelCopyWith<$Res> get changeObservationImage {
    return $ChangeObservationImageModelCopyWith<$Res>(
        _value.changeObservationImage, (value) {
      return _then(_value.copyWith(changeObservationImage: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res>
    implements $ChangeObservationImageStateCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ChangeObservationImageModel changeObservationImage});

  @override
  $ChangeObservationImageModelCopyWith<$Res> get changeObservationImage;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$ChangeObservationImageStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? changeObservationImage = null,
  }) {
    return _then(_$LoadingImpl(
      null == changeObservationImage
          ? _value.changeObservationImage
          : changeObservationImage // ignore: cast_nullable_to_non_nullable
              as ChangeObservationImageModel,
    ));
  }
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl(this.changeObservationImage);

  @override
  final ChangeObservationImageModel changeObservationImage;

  @override
  String toString() {
    return 'ChangeObservationImageState.loading(changeObservationImage: $changeObservationImage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadingImpl &&
            (identical(other.changeObservationImage, changeObservationImage) ||
                other.changeObservationImage == changeObservationImage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, changeObservationImage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadingImplCopyWith<_$LoadingImpl> get copyWith =>
      __$$LoadingImplCopyWithImpl<_$LoadingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            ChangeObservationImageModel changeObservationImage)
        loading,
    required TResult Function(
            ChangeObservationImageModel changeObservationImage)
        content,
    required TResult Function(
            ChangeObservationImageModel changeObservationImage, String msg)
        success,
    required TResult Function(
            ChangeObservationImageModel changeObservationImage, String msg)
        failed,
  }) {
    return loading(changeObservationImage);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ChangeObservationImageModel changeObservationImage)?
        loading,
    TResult? Function(ChangeObservationImageModel changeObservationImage)?
        content,
    TResult? Function(
            ChangeObservationImageModel changeObservationImage, String msg)?
        success,
    TResult? Function(
            ChangeObservationImageModel changeObservationImage, String msg)?
        failed,
  }) {
    return loading?.call(changeObservationImage);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ChangeObservationImageModel changeObservationImage)?
        loading,
    TResult Function(ChangeObservationImageModel changeObservationImage)?
        content,
    TResult Function(
            ChangeObservationImageModel changeObservationImage, String msg)?
        success,
    TResult Function(
            ChangeObservationImageModel changeObservationImage, String msg)?
        failed,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(changeObservationImage);
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

abstract class _Loading implements ChangeObservationImageState {
  const factory _Loading(
      final ChangeObservationImageModel changeObservationImage) = _$LoadingImpl;

  @override
  ChangeObservationImageModel get changeObservationImage;
  @override
  @JsonKey(ignore: true)
  _$$LoadingImplCopyWith<_$LoadingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ContentImplCopyWith<$Res>
    implements $ChangeObservationImageStateCopyWith<$Res> {
  factory _$$ContentImplCopyWith(
          _$ContentImpl value, $Res Function(_$ContentImpl) then) =
      __$$ContentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ChangeObservationImageModel changeObservationImage});

  @override
  $ChangeObservationImageModelCopyWith<$Res> get changeObservationImage;
}

/// @nodoc
class __$$ContentImplCopyWithImpl<$Res>
    extends _$ChangeObservationImageStateCopyWithImpl<$Res, _$ContentImpl>
    implements _$$ContentImplCopyWith<$Res> {
  __$$ContentImplCopyWithImpl(
      _$ContentImpl _value, $Res Function(_$ContentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? changeObservationImage = null,
  }) {
    return _then(_$ContentImpl(
      null == changeObservationImage
          ? _value.changeObservationImage
          : changeObservationImage // ignore: cast_nullable_to_non_nullable
              as ChangeObservationImageModel,
    ));
  }
}

/// @nodoc

class _$ContentImpl implements _Content {
  const _$ContentImpl(this.changeObservationImage);

  @override
  final ChangeObservationImageModel changeObservationImage;

  @override
  String toString() {
    return 'ChangeObservationImageState.content(changeObservationImage: $changeObservationImage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContentImpl &&
            (identical(other.changeObservationImage, changeObservationImage) ||
                other.changeObservationImage == changeObservationImage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, changeObservationImage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ContentImplCopyWith<_$ContentImpl> get copyWith =>
      __$$ContentImplCopyWithImpl<_$ContentImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            ChangeObservationImageModel changeObservationImage)
        loading,
    required TResult Function(
            ChangeObservationImageModel changeObservationImage)
        content,
    required TResult Function(
            ChangeObservationImageModel changeObservationImage, String msg)
        success,
    required TResult Function(
            ChangeObservationImageModel changeObservationImage, String msg)
        failed,
  }) {
    return content(changeObservationImage);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ChangeObservationImageModel changeObservationImage)?
        loading,
    TResult? Function(ChangeObservationImageModel changeObservationImage)?
        content,
    TResult? Function(
            ChangeObservationImageModel changeObservationImage, String msg)?
        success,
    TResult? Function(
            ChangeObservationImageModel changeObservationImage, String msg)?
        failed,
  }) {
    return content?.call(changeObservationImage);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ChangeObservationImageModel changeObservationImage)?
        loading,
    TResult Function(ChangeObservationImageModel changeObservationImage)?
        content,
    TResult Function(
            ChangeObservationImageModel changeObservationImage, String msg)?
        success,
    TResult Function(
            ChangeObservationImageModel changeObservationImage, String msg)?
        failed,
    required TResult orElse(),
  }) {
    if (content != null) {
      return content(changeObservationImage);
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

abstract class _Content implements ChangeObservationImageState {
  const factory _Content(
      final ChangeObservationImageModel changeObservationImage) = _$ContentImpl;

  @override
  ChangeObservationImageModel get changeObservationImage;
  @override
  @JsonKey(ignore: true)
  _$$ContentImplCopyWith<_$ContentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SuccessImplCopyWith<$Res>
    implements $ChangeObservationImageStateCopyWith<$Res> {
  factory _$$SuccessImplCopyWith(
          _$SuccessImpl value, $Res Function(_$SuccessImpl) then) =
      __$$SuccessImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ChangeObservationImageModel changeObservationImage, String msg});

  @override
  $ChangeObservationImageModelCopyWith<$Res> get changeObservationImage;
}

/// @nodoc
class __$$SuccessImplCopyWithImpl<$Res>
    extends _$ChangeObservationImageStateCopyWithImpl<$Res, _$SuccessImpl>
    implements _$$SuccessImplCopyWith<$Res> {
  __$$SuccessImplCopyWithImpl(
      _$SuccessImpl _value, $Res Function(_$SuccessImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? changeObservationImage = null,
    Object? msg = null,
  }) {
    return _then(_$SuccessImpl(
      null == changeObservationImage
          ? _value.changeObservationImage
          : changeObservationImage // ignore: cast_nullable_to_non_nullable
              as ChangeObservationImageModel,
      null == msg
          ? _value.msg
          : msg // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SuccessImpl implements _Success {
  const _$SuccessImpl(this.changeObservationImage, this.msg);

  @override
  final ChangeObservationImageModel changeObservationImage;
  @override
  final String msg;

  @override
  String toString() {
    return 'ChangeObservationImageState.success(changeObservationImage: $changeObservationImage, msg: $msg)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuccessImpl &&
            (identical(other.changeObservationImage, changeObservationImage) ||
                other.changeObservationImage == changeObservationImage) &&
            (identical(other.msg, msg) || other.msg == msg));
  }

  @override
  int get hashCode => Object.hash(runtimeType, changeObservationImage, msg);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      __$$SuccessImplCopyWithImpl<_$SuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            ChangeObservationImageModel changeObservationImage)
        loading,
    required TResult Function(
            ChangeObservationImageModel changeObservationImage)
        content,
    required TResult Function(
            ChangeObservationImageModel changeObservationImage, String msg)
        success,
    required TResult Function(
            ChangeObservationImageModel changeObservationImage, String msg)
        failed,
  }) {
    return success(changeObservationImage, msg);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ChangeObservationImageModel changeObservationImage)?
        loading,
    TResult? Function(ChangeObservationImageModel changeObservationImage)?
        content,
    TResult? Function(
            ChangeObservationImageModel changeObservationImage, String msg)?
        success,
    TResult? Function(
            ChangeObservationImageModel changeObservationImage, String msg)?
        failed,
  }) {
    return success?.call(changeObservationImage, msg);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ChangeObservationImageModel changeObservationImage)?
        loading,
    TResult Function(ChangeObservationImageModel changeObservationImage)?
        content,
    TResult Function(
            ChangeObservationImageModel changeObservationImage, String msg)?
        success,
    TResult Function(
            ChangeObservationImageModel changeObservationImage, String msg)?
        failed,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(changeObservationImage, msg);
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

abstract class _Success implements ChangeObservationImageState {
  const factory _Success(
      final ChangeObservationImageModel changeObservationImage,
      final String msg) = _$SuccessImpl;

  @override
  ChangeObservationImageModel get changeObservationImage;
  String get msg;
  @override
  @JsonKey(ignore: true)
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FailedImplCopyWith<$Res>
    implements $ChangeObservationImageStateCopyWith<$Res> {
  factory _$$FailedImplCopyWith(
          _$FailedImpl value, $Res Function(_$FailedImpl) then) =
      __$$FailedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ChangeObservationImageModel changeObservationImage, String msg});

  @override
  $ChangeObservationImageModelCopyWith<$Res> get changeObservationImage;
}

/// @nodoc
class __$$FailedImplCopyWithImpl<$Res>
    extends _$ChangeObservationImageStateCopyWithImpl<$Res, _$FailedImpl>
    implements _$$FailedImplCopyWith<$Res> {
  __$$FailedImplCopyWithImpl(
      _$FailedImpl _value, $Res Function(_$FailedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? changeObservationImage = null,
    Object? msg = null,
  }) {
    return _then(_$FailedImpl(
      null == changeObservationImage
          ? _value.changeObservationImage
          : changeObservationImage // ignore: cast_nullable_to_non_nullable
              as ChangeObservationImageModel,
      null == msg
          ? _value.msg
          : msg // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$FailedImpl implements _Failed {
  const _$FailedImpl(this.changeObservationImage, this.msg);

  @override
  final ChangeObservationImageModel changeObservationImage;
  @override
  final String msg;

  @override
  String toString() {
    return 'ChangeObservationImageState.failed(changeObservationImage: $changeObservationImage, msg: $msg)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FailedImpl &&
            (identical(other.changeObservationImage, changeObservationImage) ||
                other.changeObservationImage == changeObservationImage) &&
            (identical(other.msg, msg) || other.msg == msg));
  }

  @override
  int get hashCode => Object.hash(runtimeType, changeObservationImage, msg);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FailedImplCopyWith<_$FailedImpl> get copyWith =>
      __$$FailedImplCopyWithImpl<_$FailedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            ChangeObservationImageModel changeObservationImage)
        loading,
    required TResult Function(
            ChangeObservationImageModel changeObservationImage)
        content,
    required TResult Function(
            ChangeObservationImageModel changeObservationImage, String msg)
        success,
    required TResult Function(
            ChangeObservationImageModel changeObservationImage, String msg)
        failed,
  }) {
    return failed(changeObservationImage, msg);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ChangeObservationImageModel changeObservationImage)?
        loading,
    TResult? Function(ChangeObservationImageModel changeObservationImage)?
        content,
    TResult? Function(
            ChangeObservationImageModel changeObservationImage, String msg)?
        success,
    TResult? Function(
            ChangeObservationImageModel changeObservationImage, String msg)?
        failed,
  }) {
    return failed?.call(changeObservationImage, msg);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ChangeObservationImageModel changeObservationImage)?
        loading,
    TResult Function(ChangeObservationImageModel changeObservationImage)?
        content,
    TResult Function(
            ChangeObservationImageModel changeObservationImage, String msg)?
        success,
    TResult Function(
            ChangeObservationImageModel changeObservationImage, String msg)?
        failed,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed(changeObservationImage, msg);
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

abstract class _Failed implements ChangeObservationImageState {
  const factory _Failed(
      final ChangeObservationImageModel changeObservationImage,
      final String msg) = _$FailedImpl;

  @override
  ChangeObservationImageModel get changeObservationImage;
  String get msg;
  @override
  @JsonKey(ignore: true)
  _$$FailedImplCopyWith<_$FailedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
