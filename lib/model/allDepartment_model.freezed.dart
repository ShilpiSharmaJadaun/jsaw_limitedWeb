// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'allDepartment_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AllDepartmentModel _$AllDepartmentModelFromJson(Map<String, dynamic> json) {
  return _AllDepartmentModel.fromJson(json);
}

/// @nodoc
mixin _$AllDepartmentModel {
  String get wrkGrp => throw _privateConstructorUsedError;
  String get deptCode => throw _privateConstructorUsedError;
  String get statCode => throw _privateConstructorUsedError;
  String get statName => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AllDepartmentModelCopyWith<AllDepartmentModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AllDepartmentModelCopyWith<$Res> {
  factory $AllDepartmentModelCopyWith(
          AllDepartmentModel value, $Res Function(AllDepartmentModel) then) =
      _$AllDepartmentModelCopyWithImpl<$Res, AllDepartmentModel>;
  @useResult
  $Res call({String wrkGrp, String deptCode, String statCode, String statName});
}

/// @nodoc
class _$AllDepartmentModelCopyWithImpl<$Res, $Val extends AllDepartmentModel>
    implements $AllDepartmentModelCopyWith<$Res> {
  _$AllDepartmentModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? wrkGrp = null,
    Object? deptCode = null,
    Object? statCode = null,
    Object? statName = null,
  }) {
    return _then(_value.copyWith(
      wrkGrp: null == wrkGrp
          ? _value.wrkGrp
          : wrkGrp // ignore: cast_nullable_to_non_nullable
              as String,
      deptCode: null == deptCode
          ? _value.deptCode
          : deptCode // ignore: cast_nullable_to_non_nullable
              as String,
      statCode: null == statCode
          ? _value.statCode
          : statCode // ignore: cast_nullable_to_non_nullable
              as String,
      statName: null == statName
          ? _value.statName
          : statName // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AllDepartmentModelImplCopyWith<$Res>
    implements $AllDepartmentModelCopyWith<$Res> {
  factory _$$AllDepartmentModelImplCopyWith(_$AllDepartmentModelImpl value,
          $Res Function(_$AllDepartmentModelImpl) then) =
      __$$AllDepartmentModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String wrkGrp, String deptCode, String statCode, String statName});
}

/// @nodoc
class __$$AllDepartmentModelImplCopyWithImpl<$Res>
    extends _$AllDepartmentModelCopyWithImpl<$Res, _$AllDepartmentModelImpl>
    implements _$$AllDepartmentModelImplCopyWith<$Res> {
  __$$AllDepartmentModelImplCopyWithImpl(_$AllDepartmentModelImpl _value,
      $Res Function(_$AllDepartmentModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? wrkGrp = null,
    Object? deptCode = null,
    Object? statCode = null,
    Object? statName = null,
  }) {
    return _then(_$AllDepartmentModelImpl(
      wrkGrp: null == wrkGrp
          ? _value.wrkGrp
          : wrkGrp // ignore: cast_nullable_to_non_nullable
              as String,
      deptCode: null == deptCode
          ? _value.deptCode
          : deptCode // ignore: cast_nullable_to_non_nullable
              as String,
      statCode: null == statCode
          ? _value.statCode
          : statCode // ignore: cast_nullable_to_non_nullable
              as String,
      statName: null == statName
          ? _value.statName
          : statName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AllDepartmentModelImpl implements _AllDepartmentModel {
  const _$AllDepartmentModelImpl(
      {this.wrkGrp = "",
      this.deptCode = "",
      this.statCode = "",
      this.statName = ""});

  factory _$AllDepartmentModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AllDepartmentModelImplFromJson(json);

  @override
  @JsonKey()
  final String wrkGrp;
  @override
  @JsonKey()
  final String deptCode;
  @override
  @JsonKey()
  final String statCode;
  @override
  @JsonKey()
  final String statName;

  @override
  String toString() {
    return 'AllDepartmentModel(wrkGrp: $wrkGrp, deptCode: $deptCode, statCode: $statCode, statName: $statName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AllDepartmentModelImpl &&
            (identical(other.wrkGrp, wrkGrp) || other.wrkGrp == wrkGrp) &&
            (identical(other.deptCode, deptCode) ||
                other.deptCode == deptCode) &&
            (identical(other.statCode, statCode) ||
                other.statCode == statCode) &&
            (identical(other.statName, statName) ||
                other.statName == statName));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, wrkGrp, deptCode, statCode, statName);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AllDepartmentModelImplCopyWith<_$AllDepartmentModelImpl> get copyWith =>
      __$$AllDepartmentModelImplCopyWithImpl<_$AllDepartmentModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AllDepartmentModelImplToJson(
      this,
    );
  }
}

abstract class _AllDepartmentModel implements AllDepartmentModel {
  const factory _AllDepartmentModel(
      {final String wrkGrp,
      final String deptCode,
      final String statCode,
      final String statName}) = _$AllDepartmentModelImpl;

  factory _AllDepartmentModel.fromJson(Map<String, dynamic> json) =
      _$AllDepartmentModelImpl.fromJson;

  @override
  String get wrkGrp;
  @override
  String get deptCode;
  @override
  String get statCode;
  @override
  String get statName;
  @override
  @JsonKey(ignore: true)
  _$$AllDepartmentModelImplCopyWith<_$AllDepartmentModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
