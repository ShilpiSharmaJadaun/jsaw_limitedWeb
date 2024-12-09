// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'priorityUpdate_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PriorityUpdateModel _$PriorityUpdateModelFromJson(Map<String, dynamic> json) {
  return _PriorityUpdateModel.fromJson(json);
}

/// @nodoc
mixin _$PriorityUpdateModel {
  String get status => throw _privateConstructorUsedError;
  String get msg => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PriorityUpdateModelCopyWith<PriorityUpdateModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PriorityUpdateModelCopyWith<$Res> {
  factory $PriorityUpdateModelCopyWith(
          PriorityUpdateModel value, $Res Function(PriorityUpdateModel) then) =
      _$PriorityUpdateModelCopyWithImpl<$Res, PriorityUpdateModel>;
  @useResult
  $Res call({String status, String msg});
}

/// @nodoc
class _$PriorityUpdateModelCopyWithImpl<$Res, $Val extends PriorityUpdateModel>
    implements $PriorityUpdateModelCopyWith<$Res> {
  _$PriorityUpdateModelCopyWithImpl(this._value, this._then);

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
abstract class _$$PriorityUpdateModelImplCopyWith<$Res>
    implements $PriorityUpdateModelCopyWith<$Res> {
  factory _$$PriorityUpdateModelImplCopyWith(_$PriorityUpdateModelImpl value,
          $Res Function(_$PriorityUpdateModelImpl) then) =
      __$$PriorityUpdateModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String status, String msg});
}

/// @nodoc
class __$$PriorityUpdateModelImplCopyWithImpl<$Res>
    extends _$PriorityUpdateModelCopyWithImpl<$Res, _$PriorityUpdateModelImpl>
    implements _$$PriorityUpdateModelImplCopyWith<$Res> {
  __$$PriorityUpdateModelImplCopyWithImpl(_$PriorityUpdateModelImpl _value,
      $Res Function(_$PriorityUpdateModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? msg = null,
  }) {
    return _then(_$PriorityUpdateModelImpl(
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
class _$PriorityUpdateModelImpl implements _PriorityUpdateModel {
  const _$PriorityUpdateModelImpl({this.status = "", this.msg = ""});

  factory _$PriorityUpdateModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PriorityUpdateModelImplFromJson(json);

  @override
  @JsonKey()
  final String status;
  @override
  @JsonKey()
  final String msg;

  @override
  String toString() {
    return 'PriorityUpdateModel(status: $status, msg: $msg)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PriorityUpdateModelImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.msg, msg) || other.msg == msg));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, status, msg);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PriorityUpdateModelImplCopyWith<_$PriorityUpdateModelImpl> get copyWith =>
      __$$PriorityUpdateModelImplCopyWithImpl<_$PriorityUpdateModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PriorityUpdateModelImplToJson(
      this,
    );
  }
}

abstract class _PriorityUpdateModel implements PriorityUpdateModel {
  const factory _PriorityUpdateModel({final String status, final String msg}) =
      _$PriorityUpdateModelImpl;

  factory _PriorityUpdateModel.fromJson(Map<String, dynamic> json) =
      _$PriorityUpdateModelImpl.fromJson;

  @override
  String get status;
  @override
  String get msg;
  @override
  @JsonKey(ignore: true)
  _$$PriorityUpdateModelImplCopyWith<_$PriorityUpdateModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
