// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'saveSafetyRemarkResponse_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SafetyRemarkResponseModel _$SafetyRemarkResponseModelFromJson(
    Map<String, dynamic> json) {
  return _SafetyRemarkResponseModel.fromJson(json);
}

/// @nodoc
mixin _$SafetyRemarkResponseModel {
  String get status => throw _privateConstructorUsedError;
  String get msg => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SafetyRemarkResponseModelCopyWith<SafetyRemarkResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SafetyRemarkResponseModelCopyWith<$Res> {
  factory $SafetyRemarkResponseModelCopyWith(SafetyRemarkResponseModel value,
          $Res Function(SafetyRemarkResponseModel) then) =
      _$SafetyRemarkResponseModelCopyWithImpl<$Res, SafetyRemarkResponseModel>;
  @useResult
  $Res call({String status, String msg});
}

/// @nodoc
class _$SafetyRemarkResponseModelCopyWithImpl<$Res,
        $Val extends SafetyRemarkResponseModel>
    implements $SafetyRemarkResponseModelCopyWith<$Res> {
  _$SafetyRemarkResponseModelCopyWithImpl(this._value, this._then);

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
abstract class _$$SafetyRemarkResponseModelImplCopyWith<$Res>
    implements $SafetyRemarkResponseModelCopyWith<$Res> {
  factory _$$SafetyRemarkResponseModelImplCopyWith(
          _$SafetyRemarkResponseModelImpl value,
          $Res Function(_$SafetyRemarkResponseModelImpl) then) =
      __$$SafetyRemarkResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String status, String msg});
}

/// @nodoc
class __$$SafetyRemarkResponseModelImplCopyWithImpl<$Res>
    extends _$SafetyRemarkResponseModelCopyWithImpl<$Res,
        _$SafetyRemarkResponseModelImpl>
    implements _$$SafetyRemarkResponseModelImplCopyWith<$Res> {
  __$$SafetyRemarkResponseModelImplCopyWithImpl(
      _$SafetyRemarkResponseModelImpl _value,
      $Res Function(_$SafetyRemarkResponseModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? msg = null,
  }) {
    return _then(_$SafetyRemarkResponseModelImpl(
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
class _$SafetyRemarkResponseModelImpl implements _SafetyRemarkResponseModel {
  const _$SafetyRemarkResponseModelImpl({this.status = "", this.msg = ""});

  factory _$SafetyRemarkResponseModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SafetyRemarkResponseModelImplFromJson(json);

  @override
  @JsonKey()
  final String status;
  @override
  @JsonKey()
  final String msg;

  @override
  String toString() {
    return 'SafetyRemarkResponseModel(status: $status, msg: $msg)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SafetyRemarkResponseModelImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.msg, msg) || other.msg == msg));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, status, msg);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SafetyRemarkResponseModelImplCopyWith<_$SafetyRemarkResponseModelImpl>
      get copyWith => __$$SafetyRemarkResponseModelImplCopyWithImpl<
          _$SafetyRemarkResponseModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SafetyRemarkResponseModelImplToJson(
      this,
    );
  }
}

abstract class _SafetyRemarkResponseModel implements SafetyRemarkResponseModel {
  const factory _SafetyRemarkResponseModel(
      {final String status,
      final String msg}) = _$SafetyRemarkResponseModelImpl;

  factory _SafetyRemarkResponseModel.fromJson(Map<String, dynamic> json) =
      _$SafetyRemarkResponseModelImpl.fromJson;

  @override
  String get status;
  @override
  String get msg;
  @override
  @JsonKey(ignore: true)
  _$$SafetyRemarkResponseModelImplCopyWith<_$SafetyRemarkResponseModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
