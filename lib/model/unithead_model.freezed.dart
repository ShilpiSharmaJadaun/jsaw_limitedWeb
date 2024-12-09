// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'unithead_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UnitHeadModel _$UnitHeadModelFromJson(Map<String, dynamic> json) {
  return _UnitHeadModel.fromJson(json);
}

/// @nodoc
mixin _$UnitHeadModel {
  String get unitPlantCode => throw _privateConstructorUsedError;
  String get unitPlantName => throw _privateConstructorUsedError;
  String get unitEmpName => throw _privateConstructorUsedError;
  String get unitEmpUnqId => throw _privateConstructorUsedError;
  String get unitEmpEmail => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UnitHeadModelCopyWith<UnitHeadModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UnitHeadModelCopyWith<$Res> {
  factory $UnitHeadModelCopyWith(
          UnitHeadModel value, $Res Function(UnitHeadModel) then) =
      _$UnitHeadModelCopyWithImpl<$Res, UnitHeadModel>;
  @useResult
  $Res call(
      {String unitPlantCode,
      String unitPlantName,
      String unitEmpName,
      String unitEmpUnqId,
      String unitEmpEmail});
}

/// @nodoc
class _$UnitHeadModelCopyWithImpl<$Res, $Val extends UnitHeadModel>
    implements $UnitHeadModelCopyWith<$Res> {
  _$UnitHeadModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? unitPlantCode = null,
    Object? unitPlantName = null,
    Object? unitEmpName = null,
    Object? unitEmpUnqId = null,
    Object? unitEmpEmail = null,
  }) {
    return _then(_value.copyWith(
      unitPlantCode: null == unitPlantCode
          ? _value.unitPlantCode
          : unitPlantCode // ignore: cast_nullable_to_non_nullable
              as String,
      unitPlantName: null == unitPlantName
          ? _value.unitPlantName
          : unitPlantName // ignore: cast_nullable_to_non_nullable
              as String,
      unitEmpName: null == unitEmpName
          ? _value.unitEmpName
          : unitEmpName // ignore: cast_nullable_to_non_nullable
              as String,
      unitEmpUnqId: null == unitEmpUnqId
          ? _value.unitEmpUnqId
          : unitEmpUnqId // ignore: cast_nullable_to_non_nullable
              as String,
      unitEmpEmail: null == unitEmpEmail
          ? _value.unitEmpEmail
          : unitEmpEmail // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UnitHeadModelImplCopyWith<$Res>
    implements $UnitHeadModelCopyWith<$Res> {
  factory _$$UnitHeadModelImplCopyWith(
          _$UnitHeadModelImpl value, $Res Function(_$UnitHeadModelImpl) then) =
      __$$UnitHeadModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String unitPlantCode,
      String unitPlantName,
      String unitEmpName,
      String unitEmpUnqId,
      String unitEmpEmail});
}

/// @nodoc
class __$$UnitHeadModelImplCopyWithImpl<$Res>
    extends _$UnitHeadModelCopyWithImpl<$Res, _$UnitHeadModelImpl>
    implements _$$UnitHeadModelImplCopyWith<$Res> {
  __$$UnitHeadModelImplCopyWithImpl(
      _$UnitHeadModelImpl _value, $Res Function(_$UnitHeadModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? unitPlantCode = null,
    Object? unitPlantName = null,
    Object? unitEmpName = null,
    Object? unitEmpUnqId = null,
    Object? unitEmpEmail = null,
  }) {
    return _then(_$UnitHeadModelImpl(
      unitPlantCode: null == unitPlantCode
          ? _value.unitPlantCode
          : unitPlantCode // ignore: cast_nullable_to_non_nullable
              as String,
      unitPlantName: null == unitPlantName
          ? _value.unitPlantName
          : unitPlantName // ignore: cast_nullable_to_non_nullable
              as String,
      unitEmpName: null == unitEmpName
          ? _value.unitEmpName
          : unitEmpName // ignore: cast_nullable_to_non_nullable
              as String,
      unitEmpUnqId: null == unitEmpUnqId
          ? _value.unitEmpUnqId
          : unitEmpUnqId // ignore: cast_nullable_to_non_nullable
              as String,
      unitEmpEmail: null == unitEmpEmail
          ? _value.unitEmpEmail
          : unitEmpEmail // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UnitHeadModelImpl implements _UnitHeadModel {
  const _$UnitHeadModelImpl(
      {this.unitPlantCode = "",
      this.unitPlantName = "",
      this.unitEmpName = "",
      this.unitEmpUnqId = "",
      this.unitEmpEmail = ""});

  factory _$UnitHeadModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UnitHeadModelImplFromJson(json);

  @override
  @JsonKey()
  final String unitPlantCode;
  @override
  @JsonKey()
  final String unitPlantName;
  @override
  @JsonKey()
  final String unitEmpName;
  @override
  @JsonKey()
  final String unitEmpUnqId;
  @override
  @JsonKey()
  final String unitEmpEmail;

  @override
  String toString() {
    return 'UnitHeadModel(unitPlantCode: $unitPlantCode, unitPlantName: $unitPlantName, unitEmpName: $unitEmpName, unitEmpUnqId: $unitEmpUnqId, unitEmpEmail: $unitEmpEmail)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnitHeadModelImpl &&
            (identical(other.unitPlantCode, unitPlantCode) ||
                other.unitPlantCode == unitPlantCode) &&
            (identical(other.unitPlantName, unitPlantName) ||
                other.unitPlantName == unitPlantName) &&
            (identical(other.unitEmpName, unitEmpName) ||
                other.unitEmpName == unitEmpName) &&
            (identical(other.unitEmpUnqId, unitEmpUnqId) ||
                other.unitEmpUnqId == unitEmpUnqId) &&
            (identical(other.unitEmpEmail, unitEmpEmail) ||
                other.unitEmpEmail == unitEmpEmail));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, unitPlantCode, unitPlantName,
      unitEmpName, unitEmpUnqId, unitEmpEmail);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UnitHeadModelImplCopyWith<_$UnitHeadModelImpl> get copyWith =>
      __$$UnitHeadModelImplCopyWithImpl<_$UnitHeadModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UnitHeadModelImplToJson(
      this,
    );
  }
}

abstract class _UnitHeadModel implements UnitHeadModel {
  const factory _UnitHeadModel(
      {final String unitPlantCode,
      final String unitPlantName,
      final String unitEmpName,
      final String unitEmpUnqId,
      final String unitEmpEmail}) = _$UnitHeadModelImpl;

  factory _UnitHeadModel.fromJson(Map<String, dynamic> json) =
      _$UnitHeadModelImpl.fromJson;

  @override
  String get unitPlantCode;
  @override
  String get unitPlantName;
  @override
  String get unitEmpName;
  @override
  String get unitEmpUnqId;
  @override
  String get unitEmpEmail;
  @override
  @JsonKey(ignore: true)
  _$$UnitHeadModelImplCopyWith<_$UnitHeadModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
