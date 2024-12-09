// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'changepassword_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ChangepasswordModel _$ChangepasswordModelFromJson(Map<String, dynamic> json) {
  return _ChangepasswordModel.fromJson(json);
}

/// @nodoc
mixin _$ChangepasswordModel {
  String get status => throw _privateConstructorUsedError;
  String get msg => throw _privateConstructorUsedError;
  int get model => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChangepasswordModelCopyWith<ChangepasswordModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChangepasswordModelCopyWith<$Res> {
  factory $ChangepasswordModelCopyWith(
          ChangepasswordModel value, $Res Function(ChangepasswordModel) then) =
      _$ChangepasswordModelCopyWithImpl<$Res, ChangepasswordModel>;
  @useResult
  $Res call({String status, String msg, int model});
}

/// @nodoc
class _$ChangepasswordModelCopyWithImpl<$Res, $Val extends ChangepasswordModel>
    implements $ChangepasswordModelCopyWith<$Res> {
  _$ChangepasswordModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? msg = null,
    Object? model = null,
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
      model: null == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChangepasswordModelImplCopyWith<$Res>
    implements $ChangepasswordModelCopyWith<$Res> {
  factory _$$ChangepasswordModelImplCopyWith(_$ChangepasswordModelImpl value,
          $Res Function(_$ChangepasswordModelImpl) then) =
      __$$ChangepasswordModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String status, String msg, int model});
}

/// @nodoc
class __$$ChangepasswordModelImplCopyWithImpl<$Res>
    extends _$ChangepasswordModelCopyWithImpl<$Res, _$ChangepasswordModelImpl>
    implements _$$ChangepasswordModelImplCopyWith<$Res> {
  __$$ChangepasswordModelImplCopyWithImpl(_$ChangepasswordModelImpl _value,
      $Res Function(_$ChangepasswordModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? msg = null,
    Object? model = null,
  }) {
    return _then(_$ChangepasswordModelImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      msg: null == msg
          ? _value.msg
          : msg // ignore: cast_nullable_to_non_nullable
              as String,
      model: null == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChangepasswordModelImpl implements _ChangepasswordModel {
  const _$ChangepasswordModelImpl(
      {this.status = "", this.msg = "", this.model = 0});

  factory _$ChangepasswordModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChangepasswordModelImplFromJson(json);

  @override
  @JsonKey()
  final String status;
  @override
  @JsonKey()
  final String msg;
  @override
  @JsonKey()
  final int model;

  @override
  String toString() {
    return 'ChangepasswordModel(status: $status, msg: $msg, model: $model)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChangepasswordModelImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.msg, msg) || other.msg == msg) &&
            (identical(other.model, model) || other.model == model));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, status, msg, model);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChangepasswordModelImplCopyWith<_$ChangepasswordModelImpl> get copyWith =>
      __$$ChangepasswordModelImplCopyWithImpl<_$ChangepasswordModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChangepasswordModelImplToJson(
      this,
    );
  }
}

abstract class _ChangepasswordModel implements ChangepasswordModel {
  const factory _ChangepasswordModel(
      {final String status,
      final String msg,
      final int model}) = _$ChangepasswordModelImpl;

  factory _ChangepasswordModel.fromJson(Map<String, dynamic> json) =
      _$ChangepasswordModelImpl.fromJson;

  @override
  String get status;
  @override
  String get msg;
  @override
  int get model;
  @override
  @JsonKey(ignore: true)
  _$$ChangepasswordModelImplCopyWith<_$ChangepasswordModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
