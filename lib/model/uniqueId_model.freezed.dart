// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'uniqueId_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UniqueIdModel _$UniqueIdModelFromJson(Map<String, dynamic> json) {
  return _UniqueIdModel.fromJson(json);
}

/// @nodoc
mixin _$UniqueIdModel {
  String get uniqueIdentificationNumber => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UniqueIdModelCopyWith<UniqueIdModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UniqueIdModelCopyWith<$Res> {
  factory $UniqueIdModelCopyWith(
          UniqueIdModel value, $Res Function(UniqueIdModel) then) =
      _$UniqueIdModelCopyWithImpl<$Res, UniqueIdModel>;
  @useResult
  $Res call({String uniqueIdentificationNumber});
}

/// @nodoc
class _$UniqueIdModelCopyWithImpl<$Res, $Val extends UniqueIdModel>
    implements $UniqueIdModelCopyWith<$Res> {
  _$UniqueIdModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uniqueIdentificationNumber = null,
  }) {
    return _then(_value.copyWith(
      uniqueIdentificationNumber: null == uniqueIdentificationNumber
          ? _value.uniqueIdentificationNumber
          : uniqueIdentificationNumber // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UniqueIdModelImplCopyWith<$Res>
    implements $UniqueIdModelCopyWith<$Res> {
  factory _$$UniqueIdModelImplCopyWith(
          _$UniqueIdModelImpl value, $Res Function(_$UniqueIdModelImpl) then) =
      __$$UniqueIdModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String uniqueIdentificationNumber});
}

/// @nodoc
class __$$UniqueIdModelImplCopyWithImpl<$Res>
    extends _$UniqueIdModelCopyWithImpl<$Res, _$UniqueIdModelImpl>
    implements _$$UniqueIdModelImplCopyWith<$Res> {
  __$$UniqueIdModelImplCopyWithImpl(
      _$UniqueIdModelImpl _value, $Res Function(_$UniqueIdModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uniqueIdentificationNumber = null,
  }) {
    return _then(_$UniqueIdModelImpl(
      uniqueIdentificationNumber: null == uniqueIdentificationNumber
          ? _value.uniqueIdentificationNumber
          : uniqueIdentificationNumber // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UniqueIdModelImpl implements _UniqueIdModel {
  const _$UniqueIdModelImpl({this.uniqueIdentificationNumber = ""});

  factory _$UniqueIdModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UniqueIdModelImplFromJson(json);

  @override
  @JsonKey()
  final String uniqueIdentificationNumber;

  @override
  String toString() {
    return 'UniqueIdModel(uniqueIdentificationNumber: $uniqueIdentificationNumber)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UniqueIdModelImpl &&
            (identical(other.uniqueIdentificationNumber,
                    uniqueIdentificationNumber) ||
                other.uniqueIdentificationNumber ==
                    uniqueIdentificationNumber));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, uniqueIdentificationNumber);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UniqueIdModelImplCopyWith<_$UniqueIdModelImpl> get copyWith =>
      __$$UniqueIdModelImplCopyWithImpl<_$UniqueIdModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UniqueIdModelImplToJson(
      this,
    );
  }
}

abstract class _UniqueIdModel implements UniqueIdModel {
  const factory _UniqueIdModel({final String uniqueIdentificationNumber}) =
      _$UniqueIdModelImpl;

  factory _UniqueIdModel.fromJson(Map<String, dynamic> json) =
      _$UniqueIdModelImpl.fromJson;

  @override
  String get uniqueIdentificationNumber;
  @override
  @JsonKey(ignore: true)
  _$$UniqueIdModelImplCopyWith<_$UniqueIdModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
