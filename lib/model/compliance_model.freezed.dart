// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'compliance_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ComplianceModel _$ComplianceModelFromJson(Map<String, dynamic> json) {
  return _ComplianceModel.fromJson(json);
}

/// @nodoc
mixin _$ComplianceModel {
  String get status => throw _privateConstructorUsedError;
  String get msg => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ComplianceModelCopyWith<ComplianceModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ComplianceModelCopyWith<$Res> {
  factory $ComplianceModelCopyWith(
          ComplianceModel value, $Res Function(ComplianceModel) then) =
      _$ComplianceModelCopyWithImpl<$Res, ComplianceModel>;
  @useResult
  $Res call({String status, String msg});
}

/// @nodoc
class _$ComplianceModelCopyWithImpl<$Res, $Val extends ComplianceModel>
    implements $ComplianceModelCopyWith<$Res> {
  _$ComplianceModelCopyWithImpl(this._value, this._then);

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
abstract class _$$ComplianceModelImplCopyWith<$Res>
    implements $ComplianceModelCopyWith<$Res> {
  factory _$$ComplianceModelImplCopyWith(_$ComplianceModelImpl value,
          $Res Function(_$ComplianceModelImpl) then) =
      __$$ComplianceModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String status, String msg});
}

/// @nodoc
class __$$ComplianceModelImplCopyWithImpl<$Res>
    extends _$ComplianceModelCopyWithImpl<$Res, _$ComplianceModelImpl>
    implements _$$ComplianceModelImplCopyWith<$Res> {
  __$$ComplianceModelImplCopyWithImpl(
      _$ComplianceModelImpl _value, $Res Function(_$ComplianceModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? msg = null,
  }) {
    return _then(_$ComplianceModelImpl(
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
class _$ComplianceModelImpl implements _ComplianceModel {
  const _$ComplianceModelImpl({this.status = "", this.msg = ""});

  factory _$ComplianceModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ComplianceModelImplFromJson(json);

  @override
  @JsonKey()
  final String status;
  @override
  @JsonKey()
  final String msg;

  @override
  String toString() {
    return 'ComplianceModel(status: $status, msg: $msg)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ComplianceModelImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.msg, msg) || other.msg == msg));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, status, msg);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ComplianceModelImplCopyWith<_$ComplianceModelImpl> get copyWith =>
      __$$ComplianceModelImplCopyWithImpl<_$ComplianceModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ComplianceModelImplToJson(
      this,
    );
  }
}

abstract class _ComplianceModel implements ComplianceModel {
  const factory _ComplianceModel({final String status, final String msg}) =
      _$ComplianceModelImpl;

  factory _ComplianceModel.fromJson(Map<String, dynamic> json) =
      _$ComplianceModelImpl.fromJson;

  @override
  String get status;
  @override
  String get msg;
  @override
  @JsonKey(ignore: true)
  _$$ComplianceModelImplCopyWith<_$ComplianceModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
