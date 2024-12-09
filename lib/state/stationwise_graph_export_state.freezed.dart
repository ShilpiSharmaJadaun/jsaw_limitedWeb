// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stationwise_graph_export_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$StationWiseGraphExportState {
  StationWiseGraphExportModel get stationWiseExport =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(StationWiseGraphExportModel stationWiseExport)
        loading,
    required TResult Function(StationWiseGraphExportModel stationWiseExport)
        content,
    required TResult Function(
            StationWiseGraphExportModel stationWiseExport, String? url)
        success,
    required TResult Function(
            StationWiseGraphExportModel stationWiseExport, String message)
        failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(StationWiseGraphExportModel stationWiseExport)? loading,
    TResult? Function(StationWiseGraphExportModel stationWiseExport)? content,
    TResult? Function(
            StationWiseGraphExportModel stationWiseExport, String? url)?
        success,
    TResult? Function(
            StationWiseGraphExportModel stationWiseExport, String message)?
        failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(StationWiseGraphExportModel stationWiseExport)? loading,
    TResult Function(StationWiseGraphExportModel stationWiseExport)? content,
    TResult Function(
            StationWiseGraphExportModel stationWiseExport, String? url)?
        success,
    TResult Function(
            StationWiseGraphExportModel stationWiseExport, String message)?
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
  $StationWiseGraphExportStateCopyWith<StationWiseGraphExportState>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StationWiseGraphExportStateCopyWith<$Res> {
  factory $StationWiseGraphExportStateCopyWith(
          StationWiseGraphExportState value,
          $Res Function(StationWiseGraphExportState) then) =
      _$StationWiseGraphExportStateCopyWithImpl<$Res,
          StationWiseGraphExportState>;
  @useResult
  $Res call({StationWiseGraphExportModel stationWiseExport});

  $StationWiseGraphExportModelCopyWith<$Res> get stationWiseExport;
}

/// @nodoc
class _$StationWiseGraphExportStateCopyWithImpl<$Res,
        $Val extends StationWiseGraphExportState>
    implements $StationWiseGraphExportStateCopyWith<$Res> {
  _$StationWiseGraphExportStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stationWiseExport = null,
  }) {
    return _then(_value.copyWith(
      stationWiseExport: null == stationWiseExport
          ? _value.stationWiseExport
          : stationWiseExport // ignore: cast_nullable_to_non_nullable
              as StationWiseGraphExportModel,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $StationWiseGraphExportModelCopyWith<$Res> get stationWiseExport {
    return $StationWiseGraphExportModelCopyWith<$Res>(_value.stationWiseExport,
        (value) {
      return _then(_value.copyWith(stationWiseExport: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res>
    implements $StationWiseGraphExportStateCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({StationWiseGraphExportModel stationWiseExport});

  @override
  $StationWiseGraphExportModelCopyWith<$Res> get stationWiseExport;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$StationWiseGraphExportStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stationWiseExport = null,
  }) {
    return _then(_$LoadingImpl(
      null == stationWiseExport
          ? _value.stationWiseExport
          : stationWiseExport // ignore: cast_nullable_to_non_nullable
              as StationWiseGraphExportModel,
    ));
  }
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl(this.stationWiseExport);

  @override
  final StationWiseGraphExportModel stationWiseExport;

  @override
  String toString() {
    return 'StationWiseGraphExportState.loading(stationWiseExport: $stationWiseExport)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadingImpl &&
            (identical(other.stationWiseExport, stationWiseExport) ||
                other.stationWiseExport == stationWiseExport));
  }

  @override
  int get hashCode => Object.hash(runtimeType, stationWiseExport);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadingImplCopyWith<_$LoadingImpl> get copyWith =>
      __$$LoadingImplCopyWithImpl<_$LoadingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(StationWiseGraphExportModel stationWiseExport)
        loading,
    required TResult Function(StationWiseGraphExportModel stationWiseExport)
        content,
    required TResult Function(
            StationWiseGraphExportModel stationWiseExport, String? url)
        success,
    required TResult Function(
            StationWiseGraphExportModel stationWiseExport, String message)
        failed,
  }) {
    return loading(stationWiseExport);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(StationWiseGraphExportModel stationWiseExport)? loading,
    TResult? Function(StationWiseGraphExportModel stationWiseExport)? content,
    TResult? Function(
            StationWiseGraphExportModel stationWiseExport, String? url)?
        success,
    TResult? Function(
            StationWiseGraphExportModel stationWiseExport, String message)?
        failed,
  }) {
    return loading?.call(stationWiseExport);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(StationWiseGraphExportModel stationWiseExport)? loading,
    TResult Function(StationWiseGraphExportModel stationWiseExport)? content,
    TResult Function(
            StationWiseGraphExportModel stationWiseExport, String? url)?
        success,
    TResult Function(
            StationWiseGraphExportModel stationWiseExport, String message)?
        failed,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(stationWiseExport);
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

abstract class _Loading implements StationWiseGraphExportState {
  const factory _Loading(final StationWiseGraphExportModel stationWiseExport) =
      _$LoadingImpl;

  @override
  StationWiseGraphExportModel get stationWiseExport;
  @override
  @JsonKey(ignore: true)
  _$$LoadingImplCopyWith<_$LoadingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ContentImplCopyWith<$Res>
    implements $StationWiseGraphExportStateCopyWith<$Res> {
  factory _$$ContentImplCopyWith(
          _$ContentImpl value, $Res Function(_$ContentImpl) then) =
      __$$ContentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({StationWiseGraphExportModel stationWiseExport});

  @override
  $StationWiseGraphExportModelCopyWith<$Res> get stationWiseExport;
}

/// @nodoc
class __$$ContentImplCopyWithImpl<$Res>
    extends _$StationWiseGraphExportStateCopyWithImpl<$Res, _$ContentImpl>
    implements _$$ContentImplCopyWith<$Res> {
  __$$ContentImplCopyWithImpl(
      _$ContentImpl _value, $Res Function(_$ContentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stationWiseExport = null,
  }) {
    return _then(_$ContentImpl(
      null == stationWiseExport
          ? _value.stationWiseExport
          : stationWiseExport // ignore: cast_nullable_to_non_nullable
              as StationWiseGraphExportModel,
    ));
  }
}

/// @nodoc

class _$ContentImpl implements _Content {
  const _$ContentImpl(this.stationWiseExport);

  @override
  final StationWiseGraphExportModel stationWiseExport;

  @override
  String toString() {
    return 'StationWiseGraphExportState.content(stationWiseExport: $stationWiseExport)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContentImpl &&
            (identical(other.stationWiseExport, stationWiseExport) ||
                other.stationWiseExport == stationWiseExport));
  }

  @override
  int get hashCode => Object.hash(runtimeType, stationWiseExport);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ContentImplCopyWith<_$ContentImpl> get copyWith =>
      __$$ContentImplCopyWithImpl<_$ContentImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(StationWiseGraphExportModel stationWiseExport)
        loading,
    required TResult Function(StationWiseGraphExportModel stationWiseExport)
        content,
    required TResult Function(
            StationWiseGraphExportModel stationWiseExport, String? url)
        success,
    required TResult Function(
            StationWiseGraphExportModel stationWiseExport, String message)
        failed,
  }) {
    return content(stationWiseExport);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(StationWiseGraphExportModel stationWiseExport)? loading,
    TResult? Function(StationWiseGraphExportModel stationWiseExport)? content,
    TResult? Function(
            StationWiseGraphExportModel stationWiseExport, String? url)?
        success,
    TResult? Function(
            StationWiseGraphExportModel stationWiseExport, String message)?
        failed,
  }) {
    return content?.call(stationWiseExport);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(StationWiseGraphExportModel stationWiseExport)? loading,
    TResult Function(StationWiseGraphExportModel stationWiseExport)? content,
    TResult Function(
            StationWiseGraphExportModel stationWiseExport, String? url)?
        success,
    TResult Function(
            StationWiseGraphExportModel stationWiseExport, String message)?
        failed,
    required TResult orElse(),
  }) {
    if (content != null) {
      return content(stationWiseExport);
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

abstract class _Content implements StationWiseGraphExportState {
  const factory _Content(final StationWiseGraphExportModel stationWiseExport) =
      _$ContentImpl;

  @override
  StationWiseGraphExportModel get stationWiseExport;
  @override
  @JsonKey(ignore: true)
  _$$ContentImplCopyWith<_$ContentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SuccessImplCopyWith<$Res>
    implements $StationWiseGraphExportStateCopyWith<$Res> {
  factory _$$SuccessImplCopyWith(
          _$SuccessImpl value, $Res Function(_$SuccessImpl) then) =
      __$$SuccessImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({StationWiseGraphExportModel stationWiseExport, String? url});

  @override
  $StationWiseGraphExportModelCopyWith<$Res> get stationWiseExport;
}

/// @nodoc
class __$$SuccessImplCopyWithImpl<$Res>
    extends _$StationWiseGraphExportStateCopyWithImpl<$Res, _$SuccessImpl>
    implements _$$SuccessImplCopyWith<$Res> {
  __$$SuccessImplCopyWithImpl(
      _$SuccessImpl _value, $Res Function(_$SuccessImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stationWiseExport = null,
    Object? url = freezed,
  }) {
    return _then(_$SuccessImpl(
      null == stationWiseExport
          ? _value.stationWiseExport
          : stationWiseExport // ignore: cast_nullable_to_non_nullable
              as StationWiseGraphExportModel,
      freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$SuccessImpl implements _Success {
  const _$SuccessImpl(this.stationWiseExport, this.url);

  @override
  final StationWiseGraphExportModel stationWiseExport;
  @override
  final String? url;

  @override
  String toString() {
    return 'StationWiseGraphExportState.success(stationWiseExport: $stationWiseExport, url: $url)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuccessImpl &&
            (identical(other.stationWiseExport, stationWiseExport) ||
                other.stationWiseExport == stationWiseExport) &&
            (identical(other.url, url) || other.url == url));
  }

  @override
  int get hashCode => Object.hash(runtimeType, stationWiseExport, url);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      __$$SuccessImplCopyWithImpl<_$SuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(StationWiseGraphExportModel stationWiseExport)
        loading,
    required TResult Function(StationWiseGraphExportModel stationWiseExport)
        content,
    required TResult Function(
            StationWiseGraphExportModel stationWiseExport, String? url)
        success,
    required TResult Function(
            StationWiseGraphExportModel stationWiseExport, String message)
        failed,
  }) {
    return success(stationWiseExport, url);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(StationWiseGraphExportModel stationWiseExport)? loading,
    TResult? Function(StationWiseGraphExportModel stationWiseExport)? content,
    TResult? Function(
            StationWiseGraphExportModel stationWiseExport, String? url)?
        success,
    TResult? Function(
            StationWiseGraphExportModel stationWiseExport, String message)?
        failed,
  }) {
    return success?.call(stationWiseExport, url);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(StationWiseGraphExportModel stationWiseExport)? loading,
    TResult Function(StationWiseGraphExportModel stationWiseExport)? content,
    TResult Function(
            StationWiseGraphExportModel stationWiseExport, String? url)?
        success,
    TResult Function(
            StationWiseGraphExportModel stationWiseExport, String message)?
        failed,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(stationWiseExport, url);
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

abstract class _Success implements StationWiseGraphExportState {
  const factory _Success(final StationWiseGraphExportModel stationWiseExport,
      final String? url) = _$SuccessImpl;

  @override
  StationWiseGraphExportModel get stationWiseExport;
  String? get url;
  @override
  @JsonKey(ignore: true)
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FailedImplCopyWith<$Res>
    implements $StationWiseGraphExportStateCopyWith<$Res> {
  factory _$$FailedImplCopyWith(
          _$FailedImpl value, $Res Function(_$FailedImpl) then) =
      __$$FailedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({StationWiseGraphExportModel stationWiseExport, String message});

  @override
  $StationWiseGraphExportModelCopyWith<$Res> get stationWiseExport;
}

/// @nodoc
class __$$FailedImplCopyWithImpl<$Res>
    extends _$StationWiseGraphExportStateCopyWithImpl<$Res, _$FailedImpl>
    implements _$$FailedImplCopyWith<$Res> {
  __$$FailedImplCopyWithImpl(
      _$FailedImpl _value, $Res Function(_$FailedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stationWiseExport = null,
    Object? message = null,
  }) {
    return _then(_$FailedImpl(
      null == stationWiseExport
          ? _value.stationWiseExport
          : stationWiseExport // ignore: cast_nullable_to_non_nullable
              as StationWiseGraphExportModel,
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$FailedImpl implements _Failed {
  const _$FailedImpl(this.stationWiseExport, this.message);

  @override
  final StationWiseGraphExportModel stationWiseExport;
  @override
  final String message;

  @override
  String toString() {
    return 'StationWiseGraphExportState.failed(stationWiseExport: $stationWiseExport, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FailedImpl &&
            (identical(other.stationWiseExport, stationWiseExport) ||
                other.stationWiseExport == stationWiseExport) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, stationWiseExport, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FailedImplCopyWith<_$FailedImpl> get copyWith =>
      __$$FailedImplCopyWithImpl<_$FailedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(StationWiseGraphExportModel stationWiseExport)
        loading,
    required TResult Function(StationWiseGraphExportModel stationWiseExport)
        content,
    required TResult Function(
            StationWiseGraphExportModel stationWiseExport, String? url)
        success,
    required TResult Function(
            StationWiseGraphExportModel stationWiseExport, String message)
        failed,
  }) {
    return failed(stationWiseExport, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(StationWiseGraphExportModel stationWiseExport)? loading,
    TResult? Function(StationWiseGraphExportModel stationWiseExport)? content,
    TResult? Function(
            StationWiseGraphExportModel stationWiseExport, String? url)?
        success,
    TResult? Function(
            StationWiseGraphExportModel stationWiseExport, String message)?
        failed,
  }) {
    return failed?.call(stationWiseExport, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(StationWiseGraphExportModel stationWiseExport)? loading,
    TResult Function(StationWiseGraphExportModel stationWiseExport)? content,
    TResult Function(
            StationWiseGraphExportModel stationWiseExport, String? url)?
        success,
    TResult Function(
            StationWiseGraphExportModel stationWiseExport, String message)?
        failed,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed(stationWiseExport, message);
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

abstract class _Failed implements StationWiseGraphExportState {
  const factory _Failed(final StationWiseGraphExportModel stationWiseExport,
      final String message) = _$FailedImpl;

  @override
  StationWiseGraphExportModel get stationWiseExport;
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$FailedImplCopyWith<_$FailedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
