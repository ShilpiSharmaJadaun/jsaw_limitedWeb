// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'allhazard_cat_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AllHazardCatModel _$AllHazardCatModelFromJson(Map<String, dynamic> json) {
  return _AllHazardCatModel.fromJson(json);
}

/// @nodoc
mixin _$AllHazardCatModel {
  String get hazardCategoryName => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AllHazardCatModelCopyWith<AllHazardCatModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AllHazardCatModelCopyWith<$Res> {
  factory $AllHazardCatModelCopyWith(
          AllHazardCatModel value, $Res Function(AllHazardCatModel) then) =
      _$AllHazardCatModelCopyWithImpl<$Res, AllHazardCatModel>;
  @useResult
  $Res call({String hazardCategoryName});
}

/// @nodoc
class _$AllHazardCatModelCopyWithImpl<$Res, $Val extends AllHazardCatModel>
    implements $AllHazardCatModelCopyWith<$Res> {
  _$AllHazardCatModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hazardCategoryName = null,
  }) {
    return _then(_value.copyWith(
      hazardCategoryName: null == hazardCategoryName
          ? _value.hazardCategoryName
          : hazardCategoryName // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AllHazardCatModelImplCopyWith<$Res>
    implements $AllHazardCatModelCopyWith<$Res> {
  factory _$$AllHazardCatModelImplCopyWith(_$AllHazardCatModelImpl value,
          $Res Function(_$AllHazardCatModelImpl) then) =
      __$$AllHazardCatModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String hazardCategoryName});
}

/// @nodoc
class __$$AllHazardCatModelImplCopyWithImpl<$Res>
    extends _$AllHazardCatModelCopyWithImpl<$Res, _$AllHazardCatModelImpl>
    implements _$$AllHazardCatModelImplCopyWith<$Res> {
  __$$AllHazardCatModelImplCopyWithImpl(_$AllHazardCatModelImpl _value,
      $Res Function(_$AllHazardCatModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hazardCategoryName = null,
  }) {
    return _then(_$AllHazardCatModelImpl(
      hazardCategoryName: null == hazardCategoryName
          ? _value.hazardCategoryName
          : hazardCategoryName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AllHazardCatModelImpl implements _AllHazardCatModel {
  const _$AllHazardCatModelImpl({this.hazardCategoryName = ""});

  factory _$AllHazardCatModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AllHazardCatModelImplFromJson(json);

  @override
  @JsonKey()
  final String hazardCategoryName;

  @override
  String toString() {
    return 'AllHazardCatModel(hazardCategoryName: $hazardCategoryName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AllHazardCatModelImpl &&
            (identical(other.hazardCategoryName, hazardCategoryName) ||
                other.hazardCategoryName == hazardCategoryName));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, hazardCategoryName);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AllHazardCatModelImplCopyWith<_$AllHazardCatModelImpl> get copyWith =>
      __$$AllHazardCatModelImplCopyWithImpl<_$AllHazardCatModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AllHazardCatModelImplToJson(
      this,
    );
  }
}

abstract class _AllHazardCatModel implements AllHazardCatModel {
  const factory _AllHazardCatModel({final String hazardCategoryName}) =
      _$AllHazardCatModelImpl;

  factory _AllHazardCatModel.fromJson(Map<String, dynamic> json) =
      _$AllHazardCatModelImpl.fromJson;

  @override
  String get hazardCategoryName;
  @override
  @JsonKey(ignore: true)
  _$$AllHazardCatModelImplCopyWith<_$AllHazardCatModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
