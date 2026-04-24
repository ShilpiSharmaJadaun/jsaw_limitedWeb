// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'allBodyParts_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AllBodyPartsModel _$AllBodyPartsModelFromJson(Map<String, dynamic> json) {
  return _AllBodyPartsModel.fromJson(json);
}

/// @nodoc
mixin _$AllBodyPartsModel {
  int get id => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AllBodyPartsModelCopyWith<AllBodyPartsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AllBodyPartsModelCopyWith<$Res> {
  factory $AllBodyPartsModelCopyWith(
          AllBodyPartsModel value, $Res Function(AllBodyPartsModel) then) =
      _$AllBodyPartsModelCopyWithImpl<$Res, AllBodyPartsModel>;
  @useResult
  $Res call({int id, String description});
}

/// @nodoc
class _$AllBodyPartsModelCopyWithImpl<$Res, $Val extends AllBodyPartsModel>
    implements $AllBodyPartsModelCopyWith<$Res> {
  _$AllBodyPartsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? description = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AllBodyPartsModelImplCopyWith<$Res>
    implements $AllBodyPartsModelCopyWith<$Res> {
  factory _$$AllBodyPartsModelImplCopyWith(_$AllBodyPartsModelImpl value,
          $Res Function(_$AllBodyPartsModelImpl) then) =
      __$$AllBodyPartsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String description});
}

/// @nodoc
class __$$AllBodyPartsModelImplCopyWithImpl<$Res>
    extends _$AllBodyPartsModelCopyWithImpl<$Res, _$AllBodyPartsModelImpl>
    implements _$$AllBodyPartsModelImplCopyWith<$Res> {
  __$$AllBodyPartsModelImplCopyWithImpl(_$AllBodyPartsModelImpl _value,
      $Res Function(_$AllBodyPartsModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? description = null,
  }) {
    return _then(_$AllBodyPartsModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AllBodyPartsModelImpl implements _AllBodyPartsModel {
  const _$AllBodyPartsModelImpl({this.id = 0, this.description = ""});

  factory _$AllBodyPartsModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AllBodyPartsModelImplFromJson(json);

  @override
  @JsonKey()
  final int id;
  @override
  @JsonKey()
  final String description;

  @override
  String toString() {
    return 'AllBodyPartsModel(id: $id, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AllBodyPartsModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, description);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AllBodyPartsModelImplCopyWith<_$AllBodyPartsModelImpl> get copyWith =>
      __$$AllBodyPartsModelImplCopyWithImpl<_$AllBodyPartsModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AllBodyPartsModelImplToJson(
      this,
    );
  }
}

abstract class _AllBodyPartsModel implements AllBodyPartsModel {
  const factory _AllBodyPartsModel({final int id, final String description}) =
      _$AllBodyPartsModelImpl;

  factory _AllBodyPartsModel.fromJson(Map<String, dynamic> json) =
      _$AllBodyPartsModelImpl.fromJson;

  @override
  int get id;
  @override
  String get description;
  @override
  @JsonKey(ignore: true)
  _$$AllBodyPartsModelImplCopyWith<_$AllBodyPartsModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
