// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'updateHod_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UpdateHodModel _$UpdateHodModelFromJson(Map<String, dynamic> json) {
  return _UpdateHodModel.fromJson(json);
}

/// @nodoc
mixin _$UpdateHodModel {
  String get status => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UpdateHodModelCopyWith<UpdateHodModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateHodModelCopyWith<$Res> {
  factory $UpdateHodModelCopyWith(
          UpdateHodModel value, $Res Function(UpdateHodModel) then) =
      _$UpdateHodModelCopyWithImpl<$Res, UpdateHodModel>;
  @useResult
  $Res call({String status, String message});
}

/// @nodoc
class _$UpdateHodModelCopyWithImpl<$Res, $Val extends UpdateHodModel>
    implements $UpdateHodModelCopyWith<$Res> {
  _$UpdateHodModelCopyWithImpl(this._value, this._then);

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
abstract class _$$UpdateHodModelImplCopyWith<$Res>
    implements $UpdateHodModelCopyWith<$Res> {
  factory _$$UpdateHodModelImplCopyWith(_$UpdateHodModelImpl value,
          $Res Function(_$UpdateHodModelImpl) then) =
      __$$UpdateHodModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String status, String message});
}

/// @nodoc
class __$$UpdateHodModelImplCopyWithImpl<$Res>
    extends _$UpdateHodModelCopyWithImpl<$Res, _$UpdateHodModelImpl>
    implements _$$UpdateHodModelImplCopyWith<$Res> {
  __$$UpdateHodModelImplCopyWithImpl(
      _$UpdateHodModelImpl _value, $Res Function(_$UpdateHodModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = null,
  }) {
    return _then(_$UpdateHodModelImpl(
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
class _$UpdateHodModelImpl implements _UpdateHodModel {
  const _$UpdateHodModelImpl({this.status = "", this.message = ""});

  factory _$UpdateHodModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UpdateHodModelImplFromJson(json);

  @override
  @JsonKey()
  final String status;
  @override
  @JsonKey()
  final String message;

  @override
  String toString() {
    return 'UpdateHodModel(status: $status, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateHodModelImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, status, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateHodModelImplCopyWith<_$UpdateHodModelImpl> get copyWith =>
      __$$UpdateHodModelImplCopyWithImpl<_$UpdateHodModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdateHodModelImplToJson(
      this,
    );
  }
}

abstract class _UpdateHodModel implements UpdateHodModel {
  const factory _UpdateHodModel({final String status, final String message}) =
      _$UpdateHodModelImpl;

  factory _UpdateHodModel.fromJson(Map<String, dynamic> json) =
      _$UpdateHodModelImpl.fromJson;

  @override
  String get status;
  @override
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$UpdateHodModelImplCopyWith<_$UpdateHodModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
