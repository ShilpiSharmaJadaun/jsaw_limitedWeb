// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_password_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UpdatePasswordModel _$UpdatePasswordModelFromJson(Map<String, dynamic> json) {
  return _UpdatePasswordModel.fromJson(json);
}

/// @nodoc
mixin _$UpdatePasswordModel {
  String get status => throw _privateConstructorUsedError;
  String get msg => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UpdatePasswordModelCopyWith<UpdatePasswordModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdatePasswordModelCopyWith<$Res> {
  factory $UpdatePasswordModelCopyWith(
          UpdatePasswordModel value, $Res Function(UpdatePasswordModel) then) =
      _$UpdatePasswordModelCopyWithImpl<$Res, UpdatePasswordModel>;
  @useResult
  $Res call({String status, String msg});
}

/// @nodoc
class _$UpdatePasswordModelCopyWithImpl<$Res, $Val extends UpdatePasswordModel>
    implements $UpdatePasswordModelCopyWith<$Res> {
  _$UpdatePasswordModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? msg = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      msg: null == msg
          ? _value.msg
          : msg // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UpdatePasswordModelImplCopyWith<$Res>
    implements $UpdatePasswordModelCopyWith<$Res> {
  factory _$$UpdatePasswordModelImplCopyWith(_$UpdatePasswordModelImpl value,
          $Res Function(_$UpdatePasswordModelImpl) then) =
      __$$UpdatePasswordModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String status, String msg});
}

/// @nodoc
class __$$UpdatePasswordModelImplCopyWithImpl<$Res>
    extends _$UpdatePasswordModelCopyWithImpl<$Res, _$UpdatePasswordModelImpl>
    implements _$$UpdatePasswordModelImplCopyWith<$Res> {
  __$$UpdatePasswordModelImplCopyWithImpl(_$UpdatePasswordModelImpl _value,
      $Res Function(_$UpdatePasswordModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? msg = null,
  }) {
    return _then(_$UpdatePasswordModelImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      msg: null == msg
          ? _value.msg
          : msg // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UpdatePasswordModelImpl implements _UpdatePasswordModel {
  const _$UpdatePasswordModelImpl({this.status = "", this.msg = ""});

  factory _$UpdatePasswordModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UpdatePasswordModelImplFromJson(json);

  @override
  @JsonKey()
  final String status;
  @override
  @JsonKey()
  final String msg;

  @override
  String toString() {
    return 'UpdatePasswordModel(status: $status, msg: $msg)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdatePasswordModelImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.msg, msg) || other.msg == msg));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, status, msg);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdatePasswordModelImplCopyWith<_$UpdatePasswordModelImpl> get copyWith =>
      __$$UpdatePasswordModelImplCopyWithImpl<_$UpdatePasswordModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdatePasswordModelImplToJson(
      this,
    );
  }
}

abstract class _UpdatePasswordModel implements UpdatePasswordModel {
  const factory _UpdatePasswordModel({final String status, final String msg}) =
      _$UpdatePasswordModelImpl;

  factory _UpdatePasswordModel.fromJson(Map<String, dynamic> json) =
      _$UpdatePasswordModelImpl.fromJson;

  @override
  String get status;
  @override
  String get msg;
  @override
  @JsonKey(ignore: true)
  _$$UpdatePasswordModelImplCopyWith<_$UpdatePasswordModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
