// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hazardGraphExport_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$HazardGraphExportState {
  HazardGraphExportModel get hazardGraphExport =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(HazardGraphExportModel hazardGraphExport) loading,
    required TResult Function(HazardGraphExportModel hazardGraphExport) content,
    required TResult Function(
            HazardGraphExportModel hazardGraphExport, String? url)
        success,
    required TResult Function(
            HazardGraphExportModel hazardGraphExport, String message)
        failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(HazardGraphExportModel hazardGraphExport)? loading,
    TResult? Function(HazardGraphExportModel hazardGraphExport)? content,
    TResult? Function(HazardGraphExportModel hazardGraphExport, String? url)?
        success,
    TResult? Function(HazardGraphExportModel hazardGraphExport, String message)?
        failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(HazardGraphExportModel hazardGraphExport)? loading,
    TResult Function(HazardGraphExportModel hazardGraphExport)? content,
    TResult Function(HazardGraphExportModel hazardGraphExport, String? url)?
        success,
    TResult Function(HazardGraphExportModel hazardGraphExport, String message)?
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
  $HazardGraphExportStateCopyWith<HazardGraphExportState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HazardGraphExportStateCopyWith<$Res> {
  factory $HazardGraphExportStateCopyWith(HazardGraphExportState value,
          $Res Function(HazardGraphExportState) then) =
      _$HazardGraphExportStateCopyWithImpl<$Res, HazardGraphExportState>;
  @useResult
  $Res call({HazardGraphExportModel hazardGraphExport});

  $HazardGraphExportModelCopyWith<$Res> get hazardGraphExport;
}

/// @nodoc
class _$HazardGraphExportStateCopyWithImpl<$Res,
        $Val extends HazardGraphExportState>
    implements $HazardGraphExportStateCopyWith<$Res> {
  _$HazardGraphExportStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hazardGraphExport = null,
  }) {
    return _then(_value.copyWith(
      hazardGraphExport: null == hazardGraphExport
          ? _value.hazardGraphExport
          : hazardGraphExport // ignore: cast_nullable_to_non_nullable
              as HazardGraphExportModel,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $HazardGraphExportModelCopyWith<$Res> get hazardGraphExport {
    return $HazardGraphExportModelCopyWith<$Res>(_value.hazardGraphExport,
        (value) {
      return _then(_value.copyWith(hazardGraphExport: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res>
    implements $HazardGraphExportStateCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({HazardGraphExportModel hazardGraphExport});

  @override
  $HazardGraphExportModelCopyWith<$Res> get hazardGraphExport;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$HazardGraphExportStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hazardGraphExport = null,
  }) {
    return _then(_$LoadingImpl(
      null == hazardGraphExport
          ? _value.hazardGraphExport
          : hazardGraphExport // ignore: cast_nullable_to_non_nullable
              as HazardGraphExportModel,
    ));
  }
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl(this.hazardGraphExport);

  @override
  final HazardGraphExportModel hazardGraphExport;

  @override
  String toString() {
    return 'HazardGraphExportState.loading(hazardGraphExport: $hazardGraphExport)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadingImpl &&
            (identical(other.hazardGraphExport, hazardGraphExport) ||
                other.hazardGraphExport == hazardGraphExport));
  }

  @override
  int get hashCode => Object.hash(runtimeType, hazardGraphExport);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadingImplCopyWith<_$LoadingImpl> get copyWith =>
      __$$LoadingImplCopyWithImpl<_$LoadingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(HazardGraphExportModel hazardGraphExport) loading,
    required TResult Function(HazardGraphExportModel hazardGraphExport) content,
    required TResult Function(
            HazardGraphExportModel hazardGraphExport, String? url)
        success,
    required TResult Function(
            HazardGraphExportModel hazardGraphExport, String message)
        failed,
  }) {
    return loading(hazardGraphExport);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(HazardGraphExportModel hazardGraphExport)? loading,
    TResult? Function(HazardGraphExportModel hazardGraphExport)? content,
    TResult? Function(HazardGraphExportModel hazardGraphExport, String? url)?
        success,
    TResult? Function(HazardGraphExportModel hazardGraphExport, String message)?
        failed,
  }) {
    return loading?.call(hazardGraphExport);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(HazardGraphExportModel hazardGraphExport)? loading,
    TResult Function(HazardGraphExportModel hazardGraphExport)? content,
    TResult Function(HazardGraphExportModel hazardGraphExport, String? url)?
        success,
    TResult Function(HazardGraphExportModel hazardGraphExport, String message)?
        failed,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(hazardGraphExport);
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

abstract class _Loading implements HazardGraphExportState {
  const factory _Loading(final HazardGraphExportModel hazardGraphExport) =
      _$LoadingImpl;

  @override
  HazardGraphExportModel get hazardGraphExport;
  @override
  @JsonKey(ignore: true)
  _$$LoadingImplCopyWith<_$LoadingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ContentImplCopyWith<$Res>
    implements $HazardGraphExportStateCopyWith<$Res> {
  factory _$$ContentImplCopyWith(
          _$ContentImpl value, $Res Function(_$ContentImpl) then) =
      __$$ContentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({HazardGraphExportModel hazardGraphExport});

  @override
  $HazardGraphExportModelCopyWith<$Res> get hazardGraphExport;
}

/// @nodoc
class __$$ContentImplCopyWithImpl<$Res>
    extends _$HazardGraphExportStateCopyWithImpl<$Res, _$ContentImpl>
    implements _$$ContentImplCopyWith<$Res> {
  __$$ContentImplCopyWithImpl(
      _$ContentImpl _value, $Res Function(_$ContentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hazardGraphExport = null,
  }) {
    return _then(_$ContentImpl(
      null == hazardGraphExport
          ? _value.hazardGraphExport
          : hazardGraphExport // ignore: cast_nullable_to_non_nullable
              as HazardGraphExportModel,
    ));
  }
}

/// @nodoc

class _$ContentImpl implements _Content {
  const _$ContentImpl(this.hazardGraphExport);

  @override
  final HazardGraphExportModel hazardGraphExport;

  @override
  String toString() {
    return 'HazardGraphExportState.content(hazardGraphExport: $hazardGraphExport)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContentImpl &&
            (identical(other.hazardGraphExport, hazardGraphExport) ||
                other.hazardGraphExport == hazardGraphExport));
  }

  @override
  int get hashCode => Object.hash(runtimeType, hazardGraphExport);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ContentImplCopyWith<_$ContentImpl> get copyWith =>
      __$$ContentImplCopyWithImpl<_$ContentImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(HazardGraphExportModel hazardGraphExport) loading,
    required TResult Function(HazardGraphExportModel hazardGraphExport) content,
    required TResult Function(
            HazardGraphExportModel hazardGraphExport, String? url)
        success,
    required TResult Function(
            HazardGraphExportModel hazardGraphExport, String message)
        failed,
  }) {
    return content(hazardGraphExport);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(HazardGraphExportModel hazardGraphExport)? loading,
    TResult? Function(HazardGraphExportModel hazardGraphExport)? content,
    TResult? Function(HazardGraphExportModel hazardGraphExport, String? url)?
        success,
    TResult? Function(HazardGraphExportModel hazardGraphExport, String message)?
        failed,
  }) {
    return content?.call(hazardGraphExport);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(HazardGraphExportModel hazardGraphExport)? loading,
    TResult Function(HazardGraphExportModel hazardGraphExport)? content,
    TResult Function(HazardGraphExportModel hazardGraphExport, String? url)?
        success,
    TResult Function(HazardGraphExportModel hazardGraphExport, String message)?
        failed,
    required TResult orElse(),
  }) {
    if (content != null) {
      return content(hazardGraphExport);
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

abstract class _Content implements HazardGraphExportState {
  const factory _Content(final HazardGraphExportModel hazardGraphExport) =
      _$ContentImpl;

  @override
  HazardGraphExportModel get hazardGraphExport;
  @override
  @JsonKey(ignore: true)
  _$$ContentImplCopyWith<_$ContentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SuccessImplCopyWith<$Res>
    implements $HazardGraphExportStateCopyWith<$Res> {
  factory _$$SuccessImplCopyWith(
          _$SuccessImpl value, $Res Function(_$SuccessImpl) then) =
      __$$SuccessImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({HazardGraphExportModel hazardGraphExport, String? url});

  @override
  $HazardGraphExportModelCopyWith<$Res> get hazardGraphExport;
}

/// @nodoc
class __$$SuccessImplCopyWithImpl<$Res>
    extends _$HazardGraphExportStateCopyWithImpl<$Res, _$SuccessImpl>
    implements _$$SuccessImplCopyWith<$Res> {
  __$$SuccessImplCopyWithImpl(
      _$SuccessImpl _value, $Res Function(_$SuccessImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hazardGraphExport = null,
    Object? url = freezed,
  }) {
    return _then(_$SuccessImpl(
      null == hazardGraphExport
          ? _value.hazardGraphExport
          : hazardGraphExport // ignore: cast_nullable_to_non_nullable
              as HazardGraphExportModel,
      freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$SuccessImpl implements _Success {
  const _$SuccessImpl(this.hazardGraphExport, this.url);

  @override
  final HazardGraphExportModel hazardGraphExport;
  @override
  final String? url;

  @override
  String toString() {
    return 'HazardGraphExportState.success(hazardGraphExport: $hazardGraphExport, url: $url)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuccessImpl &&
            (identical(other.hazardGraphExport, hazardGraphExport) ||
                other.hazardGraphExport == hazardGraphExport) &&
            (identical(other.url, url) || other.url == url));
  }

  @override
  int get hashCode => Object.hash(runtimeType, hazardGraphExport, url);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      __$$SuccessImplCopyWithImpl<_$SuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(HazardGraphExportModel hazardGraphExport) loading,
    required TResult Function(HazardGraphExportModel hazardGraphExport) content,
    required TResult Function(
            HazardGraphExportModel hazardGraphExport, String? url)
        success,
    required TResult Function(
            HazardGraphExportModel hazardGraphExport, String message)
        failed,
  }) {
    return success(hazardGraphExport, url);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(HazardGraphExportModel hazardGraphExport)? loading,
    TResult? Function(HazardGraphExportModel hazardGraphExport)? content,
    TResult? Function(HazardGraphExportModel hazardGraphExport, String? url)?
        success,
    TResult? Function(HazardGraphExportModel hazardGraphExport, String message)?
        failed,
  }) {
    return success?.call(hazardGraphExport, url);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(HazardGraphExportModel hazardGraphExport)? loading,
    TResult Function(HazardGraphExportModel hazardGraphExport)? content,
    TResult Function(HazardGraphExportModel hazardGraphExport, String? url)?
        success,
    TResult Function(HazardGraphExportModel hazardGraphExport, String message)?
        failed,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(hazardGraphExport, url);
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

abstract class _Success implements HazardGraphExportState {
  const factory _Success(
          final HazardGraphExportModel hazardGraphExport, final String? url) =
      _$SuccessImpl;

  @override
  HazardGraphExportModel get hazardGraphExport;
  String? get url;
  @override
  @JsonKey(ignore: true)
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FailedImplCopyWith<$Res>
    implements $HazardGraphExportStateCopyWith<$Res> {
  factory _$$FailedImplCopyWith(
          _$FailedImpl value, $Res Function(_$FailedImpl) then) =
      __$$FailedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({HazardGraphExportModel hazardGraphExport, String message});

  @override
  $HazardGraphExportModelCopyWith<$Res> get hazardGraphExport;
}

/// @nodoc
class __$$FailedImplCopyWithImpl<$Res>
    extends _$HazardGraphExportStateCopyWithImpl<$Res, _$FailedImpl>
    implements _$$FailedImplCopyWith<$Res> {
  __$$FailedImplCopyWithImpl(
      _$FailedImpl _value, $Res Function(_$FailedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hazardGraphExport = null,
    Object? message = null,
  }) {
    return _then(_$FailedImpl(
      null == hazardGraphExport
          ? _value.hazardGraphExport
          : hazardGraphExport // ignore: cast_nullable_to_non_nullable
              as HazardGraphExportModel,
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$FailedImpl implements _Failed {
  const _$FailedImpl(this.hazardGraphExport, this.message);

  @override
  final HazardGraphExportModel hazardGraphExport;
  @override
  final String message;

  @override
  String toString() {
    return 'HazardGraphExportState.failed(hazardGraphExport: $hazardGraphExport, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FailedImpl &&
            (identical(other.hazardGraphExport, hazardGraphExport) ||
                other.hazardGraphExport == hazardGraphExport) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, hazardGraphExport, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FailedImplCopyWith<_$FailedImpl> get copyWith =>
      __$$FailedImplCopyWithImpl<_$FailedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(HazardGraphExportModel hazardGraphExport) loading,
    required TResult Function(HazardGraphExportModel hazardGraphExport) content,
    required TResult Function(
            HazardGraphExportModel hazardGraphExport, String? url)
        success,
    required TResult Function(
            HazardGraphExportModel hazardGraphExport, String message)
        failed,
  }) {
    return failed(hazardGraphExport, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(HazardGraphExportModel hazardGraphExport)? loading,
    TResult? Function(HazardGraphExportModel hazardGraphExport)? content,
    TResult? Function(HazardGraphExportModel hazardGraphExport, String? url)?
        success,
    TResult? Function(HazardGraphExportModel hazardGraphExport, String message)?
        failed,
  }) {
    return failed?.call(hazardGraphExport, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(HazardGraphExportModel hazardGraphExport)? loading,
    TResult Function(HazardGraphExportModel hazardGraphExport)? content,
    TResult Function(HazardGraphExportModel hazardGraphExport, String? url)?
        success,
    TResult Function(HazardGraphExportModel hazardGraphExport, String message)?
        failed,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed(hazardGraphExport, message);
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

abstract class _Failed implements HazardGraphExportState {
  const factory _Failed(final HazardGraphExportModel hazardGraphExport,
      final String message) = _$FailedImpl;

  @override
  HazardGraphExportModel get hazardGraphExport;
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$FailedImplCopyWith<_$FailedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
