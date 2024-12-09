// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'changeEmail_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ChangeEmailModel _$ChangeEmailModelFromJson(Map<String, dynamic> json) {
  return _ChangeEmailModel.fromJson(json);
}

/// @nodoc
mixin _$ChangeEmailModel {
  String get status => throw _privateConstructorUsedError;
  String get msg => throw _privateConstructorUsedError;
  int get model => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChangeEmailModelCopyWith<ChangeEmailModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChangeEmailModelCopyWith<$Res> {
  factory $ChangeEmailModelCopyWith(
          ChangeEmailModel value, $Res Function(ChangeEmailModel) then) =
      _$ChangeEmailModelCopyWithImpl<$Res, ChangeEmailModel>;
  @useResult
  $Res call({String status, String msg, int model});
}

/// @nodoc
class _$ChangeEmailModelCopyWithImpl<$Res, $Val extends ChangeEmailModel>
    implements $ChangeEmailModelCopyWith<$Res> {
  _$ChangeEmailModelCopyWithImpl(this._value, this._then);

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
abstract class _$$ChangeEmailModelImplCopyWith<$Res>
    implements $ChangeEmailModelCopyWith<$Res> {
  factory _$$ChangeEmailModelImplCopyWith(_$ChangeEmailModelImpl value,
          $Res Function(_$ChangeEmailModelImpl) then) =
      __$$ChangeEmailModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String status, String msg, int model});
}

/// @nodoc
class __$$ChangeEmailModelImplCopyWithImpl<$Res>
    extends _$ChangeEmailModelCopyWithImpl<$Res, _$ChangeEmailModelImpl>
    implements _$$ChangeEmailModelImplCopyWith<$Res> {
  __$$ChangeEmailModelImplCopyWithImpl(_$ChangeEmailModelImpl _value,
      $Res Function(_$ChangeEmailModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? msg = null,
    Object? model = null,
  }) {
    return _then(_$ChangeEmailModelImpl(
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
class _$ChangeEmailModelImpl implements _ChangeEmailModel {
  const _$ChangeEmailModelImpl(
      {this.status = "", this.msg = "", this.model = 0});

  factory _$ChangeEmailModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChangeEmailModelImplFromJson(json);

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
    return 'ChangeEmailModel(status: $status, msg: $msg, model: $model)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChangeEmailModelImpl &&
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
  _$$ChangeEmailModelImplCopyWith<_$ChangeEmailModelImpl> get copyWith =>
      __$$ChangeEmailModelImplCopyWithImpl<_$ChangeEmailModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChangeEmailModelImplToJson(
      this,
    );
  }
}

abstract class _ChangeEmailModel implements ChangeEmailModel {
  const factory _ChangeEmailModel(
      {final String status,
      final String msg,
      final int model}) = _$ChangeEmailModelImpl;

  factory _ChangeEmailModel.fromJson(Map<String, dynamic> json) =
      _$ChangeEmailModelImpl.fromJson;

  @override
  String get status;
  @override
  String get msg;
  @override
  int get model;
  @override
  @JsonKey(ignore: true)
  _$$ChangeEmailModelImplCopyWith<_$ChangeEmailModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
