// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'allplant_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AllPlantModel _$AllPlantModelFromJson(Map<String, dynamic> json) {
  return _AllPlantModel.fromJson(json);
}

/// @nodoc
mixin _$AllPlantModel {
  String get deptCode => throw _privateConstructorUsedError;
  String get deptName => throw _privateConstructorUsedError;
  int get unitCode => throw _privateConstructorUsedError;
  String get workGroup => throw _privateConstructorUsedError;
  String get location => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AllPlantModelCopyWith<AllPlantModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AllPlantModelCopyWith<$Res> {
  factory $AllPlantModelCopyWith(
          AllPlantModel value, $Res Function(AllPlantModel) then) =
      _$AllPlantModelCopyWithImpl<$Res, AllPlantModel>;
  @useResult
  $Res call(
      {String deptCode,
      String deptName,
      int unitCode,
      String workGroup,
      String location});
}

/// @nodoc
class _$AllPlantModelCopyWithImpl<$Res, $Val extends AllPlantModel>
    implements $AllPlantModelCopyWith<$Res> {
  _$AllPlantModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? deptCode = null,
    Object? deptName = null,
    Object? unitCode = null,
    Object? workGroup = null,
    Object? location = null,
  }) {
    return _then(_value.copyWith(
      deptCode: null == deptCode
          ? _value.deptCode
          : deptCode // ignore: cast_nullable_to_non_nullable
              as String,
      deptName: null == deptName
          ? _value.deptName
          : deptName // ignore: cast_nullable_to_non_nullable
              as String,
      unitCode: null == unitCode
          ? _value.unitCode
          : unitCode // ignore: cast_nullable_to_non_nullable
              as int,
      workGroup: null == workGroup
          ? _value.workGroup
          : workGroup // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AllPlantModelImplCopyWith<$Res>
    implements $AllPlantModelCopyWith<$Res> {
  factory _$$AllPlantModelImplCopyWith(
          _$AllPlantModelImpl value, $Res Function(_$AllPlantModelImpl) then) =
      __$$AllPlantModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String deptCode,
      String deptName,
      int unitCode,
      String workGroup,
      String location});
}

/// @nodoc
class __$$AllPlantModelImplCopyWithImpl<$Res>
    extends _$AllPlantModelCopyWithImpl<$Res, _$AllPlantModelImpl>
    implements _$$AllPlantModelImplCopyWith<$Res> {
  __$$AllPlantModelImplCopyWithImpl(
      _$AllPlantModelImpl _value, $Res Function(_$AllPlantModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? deptCode = null,
    Object? deptName = null,
    Object? unitCode = null,
    Object? workGroup = null,
    Object? location = null,
  }) {
    return _then(_$AllPlantModelImpl(
      deptCode: null == deptCode
          ? _value.deptCode
          : deptCode // ignore: cast_nullable_to_non_nullable
              as String,
      deptName: null == deptName
          ? _value.deptName
          : deptName // ignore: cast_nullable_to_non_nullable
              as String,
      unitCode: null == unitCode
          ? _value.unitCode
          : unitCode // ignore: cast_nullable_to_non_nullable
              as int,
      workGroup: null == workGroup
          ? _value.workGroup
          : workGroup // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AllPlantModelImpl extends _AllPlantModel {
  const _$AllPlantModelImpl(
      {this.deptCode = '',
      this.deptName = '',
      this.unitCode = 0,
      this.workGroup = '',
      this.location = ''})
      : super._();

  factory _$AllPlantModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AllPlantModelImplFromJson(json);

  @override
  @JsonKey()
  final String deptCode;
  @override
  @JsonKey()
  final String deptName;
  @override
  @JsonKey()
  final int unitCode;
  @override
  @JsonKey()
  final String workGroup;
  @override
  @JsonKey()
  final String location;

  @override
  String toString() {
    return 'AllPlantModel(deptCode: $deptCode, deptName: $deptName, unitCode: $unitCode, workGroup: $workGroup, location: $location)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AllPlantModelImpl &&
            (identical(other.deptCode, deptCode) ||
                other.deptCode == deptCode) &&
            (identical(other.deptName, deptName) ||
                other.deptName == deptName) &&
            (identical(other.unitCode, unitCode) ||
                other.unitCode == unitCode) &&
            (identical(other.workGroup, workGroup) ||
                other.workGroup == workGroup) &&
            (identical(other.location, location) ||
                other.location == location));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, deptCode, deptName, unitCode, workGroup, location);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AllPlantModelImplCopyWith<_$AllPlantModelImpl> get copyWith =>
      __$$AllPlantModelImplCopyWithImpl<_$AllPlantModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AllPlantModelImplToJson(
      this,
    );
  }
}

abstract class _AllPlantModel extends AllPlantModel {
  const factory _AllPlantModel(
      {final String deptCode,
      final String deptName,
      final int unitCode,
      final String workGroup,
      final String location}) = _$AllPlantModelImpl;
  const _AllPlantModel._() : super._();

  factory _AllPlantModel.fromJson(Map<String, dynamic> json) =
      _$AllPlantModelImpl.fromJson;

  @override
  String get deptCode;
  @override
  String get deptName;
  @override
  int get unitCode;
  @override
  String get workGroup;
  @override
  String get location;
  @override
  @JsonKey(ignore: true)
  _$$AllPlantModelImplCopyWith<_$AllPlantModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
