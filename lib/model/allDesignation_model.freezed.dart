// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'allDesignation_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AllDesignationModel _$AllDesignationModelFromJson(Map<String, dynamic> json) {
  return _AllDesignationModel.fromJson(json);
}

/// @nodoc
mixin _$AllDesignationModel {
  String get designation_code => throw _privateConstructorUsedError;
  String get designation_name => throw _privateConstructorUsedError;
  String get wrkGrp => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AllDesignationModelCopyWith<AllDesignationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AllDesignationModelCopyWith<$Res> {
  factory $AllDesignationModelCopyWith(
          AllDesignationModel value, $Res Function(AllDesignationModel) then) =
      _$AllDesignationModelCopyWithImpl<$Res, AllDesignationModel>;
  @useResult
  $Res call({String designation_code, String designation_name, String wrkGrp});
}

/// @nodoc
class _$AllDesignationModelCopyWithImpl<$Res, $Val extends AllDesignationModel>
    implements $AllDesignationModelCopyWith<$Res> {
  _$AllDesignationModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? designation_code = null,
    Object? designation_name = null,
    Object? wrkGrp = null,
  }) {
    return _then(_value.copyWith(
      designation_code: null == designation_code
          ? _value.designation_code
          : designation_code // ignore: cast_nullable_to_non_nullable
              as String,
      designation_name: null == designation_name
          ? _value.designation_name
          : designation_name // ignore: cast_nullable_to_non_nullable
              as String,
      wrkGrp: null == wrkGrp
          ? _value.wrkGrp
          : wrkGrp // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AllDesignationModelImplCopyWith<$Res>
    implements $AllDesignationModelCopyWith<$Res> {
  factory _$$AllDesignationModelImplCopyWith(_$AllDesignationModelImpl value,
          $Res Function(_$AllDesignationModelImpl) then) =
      __$$AllDesignationModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String designation_code, String designation_name, String wrkGrp});
}

/// @nodoc
class __$$AllDesignationModelImplCopyWithImpl<$Res>
    extends _$AllDesignationModelCopyWithImpl<$Res, _$AllDesignationModelImpl>
    implements _$$AllDesignationModelImplCopyWith<$Res> {
  __$$AllDesignationModelImplCopyWithImpl(_$AllDesignationModelImpl _value,
      $Res Function(_$AllDesignationModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? designation_code = null,
    Object? designation_name = null,
    Object? wrkGrp = null,
  }) {
    return _then(_$AllDesignationModelImpl(
      designation_code: null == designation_code
          ? _value.designation_code
          : designation_code // ignore: cast_nullable_to_non_nullable
              as String,
      designation_name: null == designation_name
          ? _value.designation_name
          : designation_name // ignore: cast_nullable_to_non_nullable
              as String,
      wrkGrp: null == wrkGrp
          ? _value.wrkGrp
          : wrkGrp // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AllDesignationModelImpl implements _AllDesignationModel {
  const _$AllDesignationModelImpl(
      {this.designation_code = "",
      this.designation_name = "",
      this.wrkGrp = ""});

  factory _$AllDesignationModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AllDesignationModelImplFromJson(json);

  @override
  @JsonKey()
  final String designation_code;
  @override
  @JsonKey()
  final String designation_name;
  @override
  @JsonKey()
  final String wrkGrp;

  @override
  String toString() {
    return 'AllDesignationModel(designation_code: $designation_code, designation_name: $designation_name, wrkGrp: $wrkGrp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AllDesignationModelImpl &&
            (identical(other.designation_code, designation_code) ||
                other.designation_code == designation_code) &&
            (identical(other.designation_name, designation_name) ||
                other.designation_name == designation_name) &&
            (identical(other.wrkGrp, wrkGrp) || other.wrkGrp == wrkGrp));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, designation_code, designation_name, wrkGrp);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AllDesignationModelImplCopyWith<_$AllDesignationModelImpl> get copyWith =>
      __$$AllDesignationModelImplCopyWithImpl<_$AllDesignationModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AllDesignationModelImplToJson(
      this,
    );
  }
}

abstract class _AllDesignationModel implements AllDesignationModel {
  const factory _AllDesignationModel(
      {final String designation_code,
      final String designation_name,
      final String wrkGrp}) = _$AllDesignationModelImpl;

  factory _AllDesignationModel.fromJson(Map<String, dynamic> json) =
      _$AllDesignationModelImpl.fromJson;

  @override
  String get designation_code;
  @override
  String get designation_name;
  @override
  String get wrkGrp;
  @override
  @JsonKey(ignore: true)
  _$$AllDesignationModelImplCopyWith<_$AllDesignationModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
