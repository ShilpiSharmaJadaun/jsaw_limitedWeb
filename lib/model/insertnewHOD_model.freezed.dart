// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'insertnewHOD_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

InsertNewHodModel _$InsertNewHodModelFromJson(Map<String, dynamic> json) {
  return _InsertNewHodModel.fromJson(json);
}

/// @nodoc
mixin _$InsertNewHodModel {
  String get status => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InsertNewHodModelCopyWith<InsertNewHodModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InsertNewHodModelCopyWith<$Res> {
  factory $InsertNewHodModelCopyWith(
          InsertNewHodModel value, $Res Function(InsertNewHodModel) then) =
      _$InsertNewHodModelCopyWithImpl<$Res, InsertNewHodModel>;
  @useResult
  $Res call({String status, String message});
}

/// @nodoc
class _$InsertNewHodModelCopyWithImpl<$Res, $Val extends InsertNewHodModel>
    implements $InsertNewHodModelCopyWith<$Res> {
  _$InsertNewHodModelCopyWithImpl(this._value, this._then);

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
abstract class _$$InsertNewHodModelImplCopyWith<$Res>
    implements $InsertNewHodModelCopyWith<$Res> {
  factory _$$InsertNewHodModelImplCopyWith(_$InsertNewHodModelImpl value,
          $Res Function(_$InsertNewHodModelImpl) then) =
      __$$InsertNewHodModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String status, String message});
}

/// @nodoc
class __$$InsertNewHodModelImplCopyWithImpl<$Res>
    extends _$InsertNewHodModelCopyWithImpl<$Res, _$InsertNewHodModelImpl>
    implements _$$InsertNewHodModelImplCopyWith<$Res> {
  __$$InsertNewHodModelImplCopyWithImpl(_$InsertNewHodModelImpl _value,
      $Res Function(_$InsertNewHodModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = null,
  }) {
    return _then(_$InsertNewHodModelImpl(
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
class _$InsertNewHodModelImpl implements _InsertNewHodModel {
  const _$InsertNewHodModelImpl({this.status = "", this.message = ""});

  factory _$InsertNewHodModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$InsertNewHodModelImplFromJson(json);

  @override
  @JsonKey()
  final String status;
  @override
  @JsonKey()
  final String message;

  @override
  String toString() {
    return 'InsertNewHodModel(status: $status, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InsertNewHodModelImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, status, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InsertNewHodModelImplCopyWith<_$InsertNewHodModelImpl> get copyWith =>
      __$$InsertNewHodModelImplCopyWithImpl<_$InsertNewHodModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InsertNewHodModelImplToJson(
      this,
    );
  }
}

abstract class _InsertNewHodModel implements InsertNewHodModel {
  const factory _InsertNewHodModel(
      {final String status, final String message}) = _$InsertNewHodModelImpl;

  factory _InsertNewHodModel.fromJson(Map<String, dynamic> json) =
      _$InsertNewHodModelImpl.fromJson;

  @override
  String get status;
  @override
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$InsertNewHodModelImplCopyWith<_$InsertNewHodModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
