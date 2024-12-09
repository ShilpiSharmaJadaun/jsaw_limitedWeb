// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'employeeAppReporting_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$EmployeeFromAppReportingState {
  List<EmployeeFromAppReportingModel> get appReporting =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<EmployeeFromAppReportingModel> appReporting)
        loading,
    required TResult Function(List<EmployeeFromAppReportingModel> appReporting)
        content,
    required TResult Function(List<EmployeeFromAppReportingModel> appReporting)
        success,
    required TResult Function(
            List<EmployeeFromAppReportingModel> appReporting, String msg)
        failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<EmployeeFromAppReportingModel> appReporting)?
        loading,
    TResult? Function(List<EmployeeFromAppReportingModel> appReporting)?
        content,
    TResult? Function(List<EmployeeFromAppReportingModel> appReporting)?
        success,
    TResult? Function(
            List<EmployeeFromAppReportingModel> appReporting, String msg)?
        failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<EmployeeFromAppReportingModel> appReporting)? loading,
    TResult Function(List<EmployeeFromAppReportingModel> appReporting)? content,
    TResult Function(List<EmployeeFromAppReportingModel> appReporting)? success,
    TResult Function(
            List<EmployeeFromAppReportingModel> appReporting, String msg)?
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
  $EmployeeFromAppReportingStateCopyWith<EmployeeFromAppReportingState>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmployeeFromAppReportingStateCopyWith<$Res> {
  factory $EmployeeFromAppReportingStateCopyWith(
          EmployeeFromAppReportingState value,
          $Res Function(EmployeeFromAppReportingState) then) =
      _$EmployeeFromAppReportingStateCopyWithImpl<$Res,
          EmployeeFromAppReportingState>;
  @useResult
  $Res call({List<EmployeeFromAppReportingModel> appReporting});
}

/// @nodoc
class _$EmployeeFromAppReportingStateCopyWithImpl<$Res,
        $Val extends EmployeeFromAppReportingState>
    implements $EmployeeFromAppReportingStateCopyWith<$Res> {
  _$EmployeeFromAppReportingStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? appReporting = null,
  }) {
    return _then(_value.copyWith(
      appReporting: null == appReporting
          ? _value.appReporting
          : appReporting // ignore: cast_nullable_to_non_nullable
              as List<EmployeeFromAppReportingModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res>
    implements $EmployeeFromAppReportingStateCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<EmployeeFromAppReportingModel> appReporting});
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$EmployeeFromAppReportingStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? appReporting = null,
  }) {
    return _then(_$LoadingImpl(
      null == appReporting
          ? _value._appReporting
          : appReporting // ignore: cast_nullable_to_non_nullable
              as List<EmployeeFromAppReportingModel>,
    ));
  }
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl(final List<EmployeeFromAppReportingModel> appReporting)
      : _appReporting = appReporting;

  final List<EmployeeFromAppReportingModel> _appReporting;
  @override
  List<EmployeeFromAppReportingModel> get appReporting {
    if (_appReporting is EqualUnmodifiableListView) return _appReporting;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_appReporting);
  }

  @override
  String toString() {
    return 'EmployeeFromAppReportingState.loading(appReporting: $appReporting)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadingImpl &&
            const DeepCollectionEquality()
                .equals(other._appReporting, _appReporting));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_appReporting));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadingImplCopyWith<_$LoadingImpl> get copyWith =>
      __$$LoadingImplCopyWithImpl<_$LoadingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<EmployeeFromAppReportingModel> appReporting)
        loading,
    required TResult Function(List<EmployeeFromAppReportingModel> appReporting)
        content,
    required TResult Function(List<EmployeeFromAppReportingModel> appReporting)
        success,
    required TResult Function(
            List<EmployeeFromAppReportingModel> appReporting, String msg)
        failed,
  }) {
    return loading(appReporting);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<EmployeeFromAppReportingModel> appReporting)?
        loading,
    TResult? Function(List<EmployeeFromAppReportingModel> appReporting)?
        content,
    TResult? Function(List<EmployeeFromAppReportingModel> appReporting)?
        success,
    TResult? Function(
            List<EmployeeFromAppReportingModel> appReporting, String msg)?
        failed,
  }) {
    return loading?.call(appReporting);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<EmployeeFromAppReportingModel> appReporting)? loading,
    TResult Function(List<EmployeeFromAppReportingModel> appReporting)? content,
    TResult Function(List<EmployeeFromAppReportingModel> appReporting)? success,
    TResult Function(
            List<EmployeeFromAppReportingModel> appReporting, String msg)?
        failed,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(appReporting);
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

abstract class _Loading implements EmployeeFromAppReportingState {
  const factory _Loading(
      final List<EmployeeFromAppReportingModel> appReporting) = _$LoadingImpl;

  @override
  List<EmployeeFromAppReportingModel> get appReporting;
  @override
  @JsonKey(ignore: true)
  _$$LoadingImplCopyWith<_$LoadingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ContentImplCopyWith<$Res>
    implements $EmployeeFromAppReportingStateCopyWith<$Res> {
  factory _$$ContentImplCopyWith(
          _$ContentImpl value, $Res Function(_$ContentImpl) then) =
      __$$ContentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<EmployeeFromAppReportingModel> appReporting});
}

/// @nodoc
class __$$ContentImplCopyWithImpl<$Res>
    extends _$EmployeeFromAppReportingStateCopyWithImpl<$Res, _$ContentImpl>
    implements _$$ContentImplCopyWith<$Res> {
  __$$ContentImplCopyWithImpl(
      _$ContentImpl _value, $Res Function(_$ContentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? appReporting = null,
  }) {
    return _then(_$ContentImpl(
      null == appReporting
          ? _value._appReporting
          : appReporting // ignore: cast_nullable_to_non_nullable
              as List<EmployeeFromAppReportingModel>,
    ));
  }
}

/// @nodoc

class _$ContentImpl implements _Content {
  const _$ContentImpl(final List<EmployeeFromAppReportingModel> appReporting)
      : _appReporting = appReporting;

  final List<EmployeeFromAppReportingModel> _appReporting;
  @override
  List<EmployeeFromAppReportingModel> get appReporting {
    if (_appReporting is EqualUnmodifiableListView) return _appReporting;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_appReporting);
  }

  @override
  String toString() {
    return 'EmployeeFromAppReportingState.content(appReporting: $appReporting)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContentImpl &&
            const DeepCollectionEquality()
                .equals(other._appReporting, _appReporting));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_appReporting));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ContentImplCopyWith<_$ContentImpl> get copyWith =>
      __$$ContentImplCopyWithImpl<_$ContentImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<EmployeeFromAppReportingModel> appReporting)
        loading,
    required TResult Function(List<EmployeeFromAppReportingModel> appReporting)
        content,
    required TResult Function(List<EmployeeFromAppReportingModel> appReporting)
        success,
    required TResult Function(
            List<EmployeeFromAppReportingModel> appReporting, String msg)
        failed,
  }) {
    return content(appReporting);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<EmployeeFromAppReportingModel> appReporting)?
        loading,
    TResult? Function(List<EmployeeFromAppReportingModel> appReporting)?
        content,
    TResult? Function(List<EmployeeFromAppReportingModel> appReporting)?
        success,
    TResult? Function(
            List<EmployeeFromAppReportingModel> appReporting, String msg)?
        failed,
  }) {
    return content?.call(appReporting);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<EmployeeFromAppReportingModel> appReporting)? loading,
    TResult Function(List<EmployeeFromAppReportingModel> appReporting)? content,
    TResult Function(List<EmployeeFromAppReportingModel> appReporting)? success,
    TResult Function(
            List<EmployeeFromAppReportingModel> appReporting, String msg)?
        failed,
    required TResult orElse(),
  }) {
    if (content != null) {
      return content(appReporting);
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

abstract class _Content implements EmployeeFromAppReportingState {
  const factory _Content(
      final List<EmployeeFromAppReportingModel> appReporting) = _$ContentImpl;

  @override
  List<EmployeeFromAppReportingModel> get appReporting;
  @override
  @JsonKey(ignore: true)
  _$$ContentImplCopyWith<_$ContentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SuccessImplCopyWith<$Res>
    implements $EmployeeFromAppReportingStateCopyWith<$Res> {
  factory _$$SuccessImplCopyWith(
          _$SuccessImpl value, $Res Function(_$SuccessImpl) then) =
      __$$SuccessImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<EmployeeFromAppReportingModel> appReporting});
}

/// @nodoc
class __$$SuccessImplCopyWithImpl<$Res>
    extends _$EmployeeFromAppReportingStateCopyWithImpl<$Res, _$SuccessImpl>
    implements _$$SuccessImplCopyWith<$Res> {
  __$$SuccessImplCopyWithImpl(
      _$SuccessImpl _value, $Res Function(_$SuccessImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? appReporting = null,
  }) {
    return _then(_$SuccessImpl(
      null == appReporting
          ? _value._appReporting
          : appReporting // ignore: cast_nullable_to_non_nullable
              as List<EmployeeFromAppReportingModel>,
    ));
  }
}

/// @nodoc

class _$SuccessImpl implements _Success {
  const _$SuccessImpl(final List<EmployeeFromAppReportingModel> appReporting)
      : _appReporting = appReporting;

  final List<EmployeeFromAppReportingModel> _appReporting;
  @override
  List<EmployeeFromAppReportingModel> get appReporting {
    if (_appReporting is EqualUnmodifiableListView) return _appReporting;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_appReporting);
  }

  @override
  String toString() {
    return 'EmployeeFromAppReportingState.success(appReporting: $appReporting)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuccessImpl &&
            const DeepCollectionEquality()
                .equals(other._appReporting, _appReporting));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_appReporting));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      __$$SuccessImplCopyWithImpl<_$SuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<EmployeeFromAppReportingModel> appReporting)
        loading,
    required TResult Function(List<EmployeeFromAppReportingModel> appReporting)
        content,
    required TResult Function(List<EmployeeFromAppReportingModel> appReporting)
        success,
    required TResult Function(
            List<EmployeeFromAppReportingModel> appReporting, String msg)
        failed,
  }) {
    return success(appReporting);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<EmployeeFromAppReportingModel> appReporting)?
        loading,
    TResult? Function(List<EmployeeFromAppReportingModel> appReporting)?
        content,
    TResult? Function(List<EmployeeFromAppReportingModel> appReporting)?
        success,
    TResult? Function(
            List<EmployeeFromAppReportingModel> appReporting, String msg)?
        failed,
  }) {
    return success?.call(appReporting);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<EmployeeFromAppReportingModel> appReporting)? loading,
    TResult Function(List<EmployeeFromAppReportingModel> appReporting)? content,
    TResult Function(List<EmployeeFromAppReportingModel> appReporting)? success,
    TResult Function(
            List<EmployeeFromAppReportingModel> appReporting, String msg)?
        failed,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(appReporting);
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

abstract class _Success implements EmployeeFromAppReportingState {
  const factory _Success(
      final List<EmployeeFromAppReportingModel> appReporting) = _$SuccessImpl;

  @override
  List<EmployeeFromAppReportingModel> get appReporting;
  @override
  @JsonKey(ignore: true)
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FailedImplCopyWith<$Res>
    implements $EmployeeFromAppReportingStateCopyWith<$Res> {
  factory _$$FailedImplCopyWith(
          _$FailedImpl value, $Res Function(_$FailedImpl) then) =
      __$$FailedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<EmployeeFromAppReportingModel> appReporting, String msg});
}

/// @nodoc
class __$$FailedImplCopyWithImpl<$Res>
    extends _$EmployeeFromAppReportingStateCopyWithImpl<$Res, _$FailedImpl>
    implements _$$FailedImplCopyWith<$Res> {
  __$$FailedImplCopyWithImpl(
      _$FailedImpl _value, $Res Function(_$FailedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? appReporting = null,
    Object? msg = null,
  }) {
    return _then(_$FailedImpl(
      null == appReporting
          ? _value._appReporting
          : appReporting // ignore: cast_nullable_to_non_nullable
              as List<EmployeeFromAppReportingModel>,
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
      final List<EmployeeFromAppReportingModel> appReporting, this.msg)
      : _appReporting = appReporting;

  final List<EmployeeFromAppReportingModel> _appReporting;
  @override
  List<EmployeeFromAppReportingModel> get appReporting {
    if (_appReporting is EqualUnmodifiableListView) return _appReporting;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_appReporting);
  }

  @override
  final String msg;

  @override
  String toString() {
    return 'EmployeeFromAppReportingState.failed(appReporting: $appReporting, msg: $msg)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FailedImpl &&
            const DeepCollectionEquality()
                .equals(other._appReporting, _appReporting) &&
            (identical(other.msg, msg) || other.msg == msg));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_appReporting), msg);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FailedImplCopyWith<_$FailedImpl> get copyWith =>
      __$$FailedImplCopyWithImpl<_$FailedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<EmployeeFromAppReportingModel> appReporting)
        loading,
    required TResult Function(List<EmployeeFromAppReportingModel> appReporting)
        content,
    required TResult Function(List<EmployeeFromAppReportingModel> appReporting)
        success,
    required TResult Function(
            List<EmployeeFromAppReportingModel> appReporting, String msg)
        failed,
  }) {
    return failed(appReporting, msg);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<EmployeeFromAppReportingModel> appReporting)?
        loading,
    TResult? Function(List<EmployeeFromAppReportingModel> appReporting)?
        content,
    TResult? Function(List<EmployeeFromAppReportingModel> appReporting)?
        success,
    TResult? Function(
            List<EmployeeFromAppReportingModel> appReporting, String msg)?
        failed,
  }) {
    return failed?.call(appReporting, msg);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<EmployeeFromAppReportingModel> appReporting)? loading,
    TResult Function(List<EmployeeFromAppReportingModel> appReporting)? content,
    TResult Function(List<EmployeeFromAppReportingModel> appReporting)? success,
    TResult Function(
            List<EmployeeFromAppReportingModel> appReporting, String msg)?
        failed,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed(appReporting, msg);
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

abstract class _Failed implements EmployeeFromAppReportingState {
  const factory _Failed(final List<EmployeeFromAppReportingModel> appReporting,
      final String msg) = _$FailedImpl;

  @override
  List<EmployeeFromAppReportingModel> get appReporting;
  String get msg;
  @override
  @JsonKey(ignore: true)
  _$$FailedImplCopyWith<_$FailedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
