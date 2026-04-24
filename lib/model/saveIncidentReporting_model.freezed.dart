// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'saveIncidentReporting_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SaveIncidentReportingModel _$SaveIncidentReportingModelFromJson(
    Map<String, dynamic> json) {
  return _SaveIncidentReportingModel.fromJson(json);
}

/// @nodoc
mixin _$SaveIncidentReportingModel {
  String get status => throw _privateConstructorUsedError;
  String get error => throw _privateConstructorUsedError;
  String get path => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SaveIncidentReportingModelCopyWith<SaveIncidentReportingModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SaveIncidentReportingModelCopyWith<$Res> {
  factory $SaveIncidentReportingModelCopyWith(SaveIncidentReportingModel value,
          $Res Function(SaveIncidentReportingModel) then) =
      _$SaveIncidentReportingModelCopyWithImpl<$Res,
          SaveIncidentReportingModel>;
  @useResult
  $Res call({String status, String error, String path});
}

/// @nodoc
class _$SaveIncidentReportingModelCopyWithImpl<$Res,
        $Val extends SaveIncidentReportingModel>
    implements $SaveIncidentReportingModelCopyWith<$Res> {
  _$SaveIncidentReportingModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? error = null,
    Object? path = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SaveIncidentReportingModelImplCopyWith<$Res>
    implements $SaveIncidentReportingModelCopyWith<$Res> {
  factory _$$SaveIncidentReportingModelImplCopyWith(
          _$SaveIncidentReportingModelImpl value,
          $Res Function(_$SaveIncidentReportingModelImpl) then) =
      __$$SaveIncidentReportingModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String status, String error, String path});
}

/// @nodoc
class __$$SaveIncidentReportingModelImplCopyWithImpl<$Res>
    extends _$SaveIncidentReportingModelCopyWithImpl<$Res,
        _$SaveIncidentReportingModelImpl>
    implements _$$SaveIncidentReportingModelImplCopyWith<$Res> {
  __$$SaveIncidentReportingModelImplCopyWithImpl(
      _$SaveIncidentReportingModelImpl _value,
      $Res Function(_$SaveIncidentReportingModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? error = null,
    Object? path = null,
  }) {
    return _then(_$SaveIncidentReportingModelImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SaveIncidentReportingModelImpl implements _SaveIncidentReportingModel {
  const _$SaveIncidentReportingModelImpl(
      {this.status = "", this.error = "", this.path = ""});

  factory _$SaveIncidentReportingModelImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$SaveIncidentReportingModelImplFromJson(json);

  @override
  @JsonKey()
  final String status;
  @override
  @JsonKey()
  final String error;
  @override
  @JsonKey()
  final String path;

  @override
  String toString() {
    return 'SaveIncidentReportingModel(status: $status, error: $error, path: $path)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SaveIncidentReportingModelImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.path, path) || other.path == path));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, status, error, path);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SaveIncidentReportingModelImplCopyWith<_$SaveIncidentReportingModelImpl>
      get copyWith => __$$SaveIncidentReportingModelImplCopyWithImpl<
          _$SaveIncidentReportingModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SaveIncidentReportingModelImplToJson(
      this,
    );
  }
}

abstract class _SaveIncidentReportingModel
    implements SaveIncidentReportingModel {
  const factory _SaveIncidentReportingModel(
      {final String status,
      final String error,
      final String path}) = _$SaveIncidentReportingModelImpl;

  factory _SaveIncidentReportingModel.fromJson(Map<String, dynamic> json) =
      _$SaveIncidentReportingModelImpl.fromJson;

  @override
  String get status;
  @override
  String get error;
  @override
  String get path;
  @override
  @JsonKey(ignore: true)
  _$$SaveIncidentReportingModelImplCopyWith<_$SaveIncidentReportingModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
