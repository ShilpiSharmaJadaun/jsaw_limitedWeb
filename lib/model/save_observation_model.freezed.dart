// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'save_observation_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SaveObservationModel _$SaveObservationModelFromJson(Map<String, dynamic> json) {
  return _SaveObservationModel.fromJson(json);
}

/// @nodoc
mixin _$SaveObservationModel {
  String get timestamp => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String get error => throw _privateConstructorUsedError;
  String get path => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SaveObservationModelCopyWith<SaveObservationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SaveObservationModelCopyWith<$Res> {
  factory $SaveObservationModelCopyWith(SaveObservationModel value,
          $Res Function(SaveObservationModel) then) =
      _$SaveObservationModelCopyWithImpl<$Res, SaveObservationModel>;
  @useResult
  $Res call({String timestamp, String status, String error, String path});
}

/// @nodoc
class _$SaveObservationModelCopyWithImpl<$Res,
        $Val extends SaveObservationModel>
    implements $SaveObservationModelCopyWith<$Res> {
  _$SaveObservationModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timestamp = null,
    Object? status = null,
    Object? error = null,
    Object? path = null,
  }) {
    return _then(_value.copyWith(
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as String,
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
abstract class _$$SaveObservationModelImplCopyWith<$Res>
    implements $SaveObservationModelCopyWith<$Res> {
  factory _$$SaveObservationModelImplCopyWith(_$SaveObservationModelImpl value,
          $Res Function(_$SaveObservationModelImpl) then) =
      __$$SaveObservationModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String timestamp, String status, String error, String path});
}

/// @nodoc
class __$$SaveObservationModelImplCopyWithImpl<$Res>
    extends _$SaveObservationModelCopyWithImpl<$Res, _$SaveObservationModelImpl>
    implements _$$SaveObservationModelImplCopyWith<$Res> {
  __$$SaveObservationModelImplCopyWithImpl(_$SaveObservationModelImpl _value,
      $Res Function(_$SaveObservationModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timestamp = null,
    Object? status = null,
    Object? error = null,
    Object? path = null,
  }) {
    return _then(_$SaveObservationModelImpl(
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as String,
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
class _$SaveObservationModelImpl implements _SaveObservationModel {
  const _$SaveObservationModelImpl(
      {this.timestamp = "", this.status = "", this.error = "", this.path = ""});

  factory _$SaveObservationModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SaveObservationModelImplFromJson(json);

  @override
  @JsonKey()
  final String timestamp;
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
    return 'SaveObservationModel(timestamp: $timestamp, status: $status, error: $error, path: $path)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SaveObservationModelImpl &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.path, path) || other.path == path));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, timestamp, status, error, path);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SaveObservationModelImplCopyWith<_$SaveObservationModelImpl>
      get copyWith =>
          __$$SaveObservationModelImplCopyWithImpl<_$SaveObservationModelImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SaveObservationModelImplToJson(
      this,
    );
  }
}

abstract class _SaveObservationModel implements SaveObservationModel {
  const factory _SaveObservationModel(
      {final String timestamp,
      final String status,
      final String error,
      final String path}) = _$SaveObservationModelImpl;

  factory _SaveObservationModel.fromJson(Map<String, dynamic> json) =
      _$SaveObservationModelImpl.fromJson;

  @override
  String get timestamp;
  @override
  String get status;
  @override
  String get error;
  @override
  String get path;
  @override
  @JsonKey(ignore: true)
  _$$SaveObservationModelImplCopyWith<_$SaveObservationModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
