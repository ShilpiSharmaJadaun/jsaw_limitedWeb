// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'plantHead_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PlantHeadModel _$PlantHeadModelFromJson(Map<String, dynamic> json) {
  return _PlantHeadModel.fromJson(json);
}

/// @nodoc
mixin _$PlantHeadModel {
  String get plantCode => throw _privateConstructorUsedError;
  String get plantName => throw _privateConstructorUsedError;
  String get empName => throw _privateConstructorUsedError;
  String get empUnqId => throw _privateConstructorUsedError;
  String get empEmail => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PlantHeadModelCopyWith<PlantHeadModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlantHeadModelCopyWith<$Res> {
  factory $PlantHeadModelCopyWith(
          PlantHeadModel value, $Res Function(PlantHeadModel) then) =
      _$PlantHeadModelCopyWithImpl<$Res, PlantHeadModel>;
  @useResult
  $Res call(
      {String plantCode,
      String plantName,
      String empName,
      String empUnqId,
      String empEmail});
}

/// @nodoc
class _$PlantHeadModelCopyWithImpl<$Res, $Val extends PlantHeadModel>
    implements $PlantHeadModelCopyWith<$Res> {
  _$PlantHeadModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? plantCode = null,
    Object? plantName = null,
    Object? empName = null,
    Object? empUnqId = null,
    Object? empEmail = null,
  }) {
    return _then(_value.copyWith(
      plantCode: null == plantCode
          ? _value.plantCode
          : plantCode // ignore: cast_nullable_to_non_nullable
              as String,
      plantName: null == plantName
          ? _value.plantName
          : plantName // ignore: cast_nullable_to_non_nullable
              as String,
      empName: null == empName
          ? _value.empName
          : empName // ignore: cast_nullable_to_non_nullable
              as String,
      empUnqId: null == empUnqId
          ? _value.empUnqId
          : empUnqId // ignore: cast_nullable_to_non_nullable
              as String,
      empEmail: null == empEmail
          ? _value.empEmail
          : empEmail // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PlantHeadModelImplCopyWith<$Res>
    implements $PlantHeadModelCopyWith<$Res> {
  factory _$$PlantHeadModelImplCopyWith(_$PlantHeadModelImpl value,
          $Res Function(_$PlantHeadModelImpl) then) =
      __$$PlantHeadModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String plantCode,
      String plantName,
      String empName,
      String empUnqId,
      String empEmail});
}

/// @nodoc
class __$$PlantHeadModelImplCopyWithImpl<$Res>
    extends _$PlantHeadModelCopyWithImpl<$Res, _$PlantHeadModelImpl>
    implements _$$PlantHeadModelImplCopyWith<$Res> {
  __$$PlantHeadModelImplCopyWithImpl(
      _$PlantHeadModelImpl _value, $Res Function(_$PlantHeadModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? plantCode = null,
    Object? plantName = null,
    Object? empName = null,
    Object? empUnqId = null,
    Object? empEmail = null,
  }) {
    return _then(_$PlantHeadModelImpl(
      plantCode: null == plantCode
          ? _value.plantCode
          : plantCode // ignore: cast_nullable_to_non_nullable
              as String,
      plantName: null == plantName
          ? _value.plantName
          : plantName // ignore: cast_nullable_to_non_nullable
              as String,
      empName: null == empName
          ? _value.empName
          : empName // ignore: cast_nullable_to_non_nullable
              as String,
      empUnqId: null == empUnqId
          ? _value.empUnqId
          : empUnqId // ignore: cast_nullable_to_non_nullable
              as String,
      empEmail: null == empEmail
          ? _value.empEmail
          : empEmail // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PlantHeadModelImpl implements _PlantHeadModel {
  const _$PlantHeadModelImpl(
      {this.plantCode = "",
      this.plantName = "",
      this.empName = "",
      this.empUnqId = "",
      this.empEmail = ""});

  factory _$PlantHeadModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlantHeadModelImplFromJson(json);

  @override
  @JsonKey()
  final String plantCode;
  @override
  @JsonKey()
  final String plantName;
  @override
  @JsonKey()
  final String empName;
  @override
  @JsonKey()
  final String empUnqId;
  @override
  @JsonKey()
  final String empEmail;

  @override
  String toString() {
    return 'PlantHeadModel(plantCode: $plantCode, plantName: $plantName, empName: $empName, empUnqId: $empUnqId, empEmail: $empEmail)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlantHeadModelImpl &&
            (identical(other.plantCode, plantCode) ||
                other.plantCode == plantCode) &&
            (identical(other.plantName, plantName) ||
                other.plantName == plantName) &&
            (identical(other.empName, empName) || other.empName == empName) &&
            (identical(other.empUnqId, empUnqId) ||
                other.empUnqId == empUnqId) &&
            (identical(other.empEmail, empEmail) ||
                other.empEmail == empEmail));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, plantCode, plantName, empName, empUnqId, empEmail);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PlantHeadModelImplCopyWith<_$PlantHeadModelImpl> get copyWith =>
      __$$PlantHeadModelImplCopyWithImpl<_$PlantHeadModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PlantHeadModelImplToJson(
      this,
    );
  }
}

abstract class _PlantHeadModel implements PlantHeadModel {
  const factory _PlantHeadModel(
      {final String plantCode,
      final String plantName,
      final String empName,
      final String empUnqId,
      final String empEmail}) = _$PlantHeadModelImpl;

  factory _PlantHeadModel.fromJson(Map<String, dynamic> json) =
      _$PlantHeadModelImpl.fromJson;

  @override
  String get plantCode;
  @override
  String get plantName;
  @override
  String get empName;
  @override
  String get empUnqId;
  @override
  String get empEmail;
  @override
  @JsonKey(ignore: true)
  _$$PlantHeadModelImplCopyWith<_$PlantHeadModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
