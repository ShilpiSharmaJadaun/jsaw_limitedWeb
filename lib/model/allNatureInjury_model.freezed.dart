// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'allNatureInjury_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AllNatureInjuryModel _$AllNatureInjuryModelFromJson(Map<String, dynamic> json) {
  return _AllNatureInjuryModel.fromJson(json);
}

/// @nodoc
mixin _$AllNatureInjuryModel {
  int get id => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AllNatureInjuryModelCopyWith<AllNatureInjuryModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AllNatureInjuryModelCopyWith<$Res> {
  factory $AllNatureInjuryModelCopyWith(AllNatureInjuryModel value,
          $Res Function(AllNatureInjuryModel) then) =
      _$AllNatureInjuryModelCopyWithImpl<$Res, AllNatureInjuryModel>;
  @useResult
  $Res call({int id, String description});
}

/// @nodoc
class _$AllNatureInjuryModelCopyWithImpl<$Res,
        $Val extends AllNatureInjuryModel>
    implements $AllNatureInjuryModelCopyWith<$Res> {
  _$AllNatureInjuryModelCopyWithImpl(this._value, this._then);

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
abstract class _$$AllNatureInjuryModelImplCopyWith<$Res>
    implements $AllNatureInjuryModelCopyWith<$Res> {
  factory _$$AllNatureInjuryModelImplCopyWith(_$AllNatureInjuryModelImpl value,
          $Res Function(_$AllNatureInjuryModelImpl) then) =
      __$$AllNatureInjuryModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String description});
}

/// @nodoc
class __$$AllNatureInjuryModelImplCopyWithImpl<$Res>
    extends _$AllNatureInjuryModelCopyWithImpl<$Res, _$AllNatureInjuryModelImpl>
    implements _$$AllNatureInjuryModelImplCopyWith<$Res> {
  __$$AllNatureInjuryModelImplCopyWithImpl(_$AllNatureInjuryModelImpl _value,
      $Res Function(_$AllNatureInjuryModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? description = null,
  }) {
    return _then(_$AllNatureInjuryModelImpl(
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
class _$AllNatureInjuryModelImpl implements _AllNatureInjuryModel {
  const _$AllNatureInjuryModelImpl({this.id = 0, this.description = ""});

  factory _$AllNatureInjuryModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AllNatureInjuryModelImplFromJson(json);

  @override
  @JsonKey()
  final int id;
  @override
  @JsonKey()
  final String description;

  @override
  String toString() {
    return 'AllNatureInjuryModel(id: $id, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AllNatureInjuryModelImpl &&
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
  _$$AllNatureInjuryModelImplCopyWith<_$AllNatureInjuryModelImpl>
      get copyWith =>
          __$$AllNatureInjuryModelImplCopyWithImpl<_$AllNatureInjuryModelImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AllNatureInjuryModelImplToJson(
      this,
    );
  }
}

abstract class _AllNatureInjuryModel implements AllNatureInjuryModel {
  const factory _AllNatureInjuryModel(
      {final int id, final String description}) = _$AllNatureInjuryModelImpl;

  factory _AllNatureInjuryModel.fromJson(Map<String, dynamic> json) =
      _$AllNatureInjuryModelImpl.fromJson;

  @override
  int get id;
  @override
  String get description;
  @override
  @JsonKey(ignore: true)
  _$$AllNatureInjuryModelImplCopyWith<_$AllNatureInjuryModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
