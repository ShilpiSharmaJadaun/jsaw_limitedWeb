// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'deleteHOD_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DeleteHODModel _$DeleteHODModelFromJson(Map<String, dynamic> json) {
  return _DeleteHODModel.fromJson(json);
}

/// @nodoc
mixin _$DeleteHODModel {
  String get status => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DeleteHODModelCopyWith<DeleteHODModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeleteHODModelCopyWith<$Res> {
  factory $DeleteHODModelCopyWith(
          DeleteHODModel value, $Res Function(DeleteHODModel) then) =
      _$DeleteHODModelCopyWithImpl<$Res, DeleteHODModel>;
  @useResult
  $Res call({String status, String message});
}

/// @nodoc
class _$DeleteHODModelCopyWithImpl<$Res, $Val extends DeleteHODModel>
    implements $DeleteHODModelCopyWith<$Res> {
  _$DeleteHODModelCopyWithImpl(this._value, this._then);

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
abstract class _$$DeleteHODModelImplCopyWith<$Res>
    implements $DeleteHODModelCopyWith<$Res> {
  factory _$$DeleteHODModelImplCopyWith(_$DeleteHODModelImpl value,
          $Res Function(_$DeleteHODModelImpl) then) =
      __$$DeleteHODModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String status, String message});
}

/// @nodoc
class __$$DeleteHODModelImplCopyWithImpl<$Res>
    extends _$DeleteHODModelCopyWithImpl<$Res, _$DeleteHODModelImpl>
    implements _$$DeleteHODModelImplCopyWith<$Res> {
  __$$DeleteHODModelImplCopyWithImpl(
      _$DeleteHODModelImpl _value, $Res Function(_$DeleteHODModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = null,
  }) {
    return _then(_$DeleteHODModelImpl(
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
class _$DeleteHODModelImpl implements _DeleteHODModel {
  const _$DeleteHODModelImpl({this.status = "", this.message = ""});

  factory _$DeleteHODModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DeleteHODModelImplFromJson(json);

  @override
  @JsonKey()
  final String status;
  @override
  @JsonKey()
  final String message;

  @override
  String toString() {
    return 'DeleteHODModel(status: $status, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeleteHODModelImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, status, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DeleteHODModelImplCopyWith<_$DeleteHODModelImpl> get copyWith =>
      __$$DeleteHODModelImplCopyWithImpl<_$DeleteHODModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DeleteHODModelImplToJson(
      this,
    );
  }
}

abstract class _DeleteHODModel implements DeleteHODModel {
  const factory _DeleteHODModel({final String status, final String message}) =
      _$DeleteHODModelImpl;

  factory _DeleteHODModel.fromJson(Map<String, dynamic> json) =
      _$DeleteHODModelImpl.fromJson;

  @override
  String get status;
  @override
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$DeleteHODModelImplCopyWith<_$DeleteHODModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
