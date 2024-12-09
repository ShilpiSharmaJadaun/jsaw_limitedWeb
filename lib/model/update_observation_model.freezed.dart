// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_observation_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UpdateObservationModel _$UpdateObservationModelFromJson(
    Map<String, dynamic> json) {
  return _UpdateObservationModel.fromJson(json);
}

/// @nodoc
mixin _$UpdateObservationModel {
  String get status => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UpdateObservationModelCopyWith<UpdateObservationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateObservationModelCopyWith<$Res> {
  factory $UpdateObservationModelCopyWith(UpdateObservationModel value,
          $Res Function(UpdateObservationModel) then) =
      _$UpdateObservationModelCopyWithImpl<$Res, UpdateObservationModel>;
  @useResult
  $Res call({String status, String message});
}

/// @nodoc
class _$UpdateObservationModelCopyWithImpl<$Res,
        $Val extends UpdateObservationModel>
    implements $UpdateObservationModelCopyWith<$Res> {
  _$UpdateObservationModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UpdateObservationModelImplCopyWith<$Res>
    implements $UpdateObservationModelCopyWith<$Res> {
  factory _$$UpdateObservationModelImplCopyWith(
          _$UpdateObservationModelImpl value,
          $Res Function(_$UpdateObservationModelImpl) then) =
      __$$UpdateObservationModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String status, String message});
}

/// @nodoc
class __$$UpdateObservationModelImplCopyWithImpl<$Res>
    extends _$UpdateObservationModelCopyWithImpl<$Res,
        _$UpdateObservationModelImpl>
    implements _$$UpdateObservationModelImplCopyWith<$Res> {
  __$$UpdateObservationModelImplCopyWithImpl(
      _$UpdateObservationModelImpl _value,
      $Res Function(_$UpdateObservationModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = null,
  }) {
    return _then(_$UpdateObservationModelImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UpdateObservationModelImpl implements _UpdateObservationModel {
  const _$UpdateObservationModelImpl({this.status = "", this.message = ""});

  factory _$UpdateObservationModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UpdateObservationModelImplFromJson(json);

  @override
  @JsonKey()
  final String status;
  @override
  @JsonKey()
  final String message;

  @override
  String toString() {
    return 'UpdateObservationModel(status: $status, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateObservationModelImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, status, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateObservationModelImplCopyWith<_$UpdateObservationModelImpl>
      get copyWith => __$$UpdateObservationModelImplCopyWithImpl<
          _$UpdateObservationModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdateObservationModelImplToJson(
      this,
    );
  }
}

abstract class _UpdateObservationModel implements UpdateObservationModel {
  const factory _UpdateObservationModel(
      {final String status,
      final String message}) = _$UpdateObservationModelImpl;

  factory _UpdateObservationModel.fromJson(Map<String, dynamic> json) =
      _$UpdateObservationModelImpl.fromJson;

  @override
  String get status;
  @override
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$UpdateObservationModelImplCopyWith<_$UpdateObservationModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
