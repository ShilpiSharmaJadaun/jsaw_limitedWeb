// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'allTypeIncident_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AllTypeIncidentModel _$AllTypeIncidentModelFromJson(Map<String, dynamic> json) {
  return _AllTypeIncidentModel.fromJson(json);
}

/// @nodoc
mixin _$AllTypeIncidentModel {
  int get id => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AllTypeIncidentModelCopyWith<AllTypeIncidentModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AllTypeIncidentModelCopyWith<$Res> {
  factory $AllTypeIncidentModelCopyWith(AllTypeIncidentModel value,
          $Res Function(AllTypeIncidentModel) then) =
      _$AllTypeIncidentModelCopyWithImpl<$Res, AllTypeIncidentModel>;
  @useResult
  $Res call({int id, String description});
}

/// @nodoc
class _$AllTypeIncidentModelCopyWithImpl<$Res,
        $Val extends AllTypeIncidentModel>
    implements $AllTypeIncidentModelCopyWith<$Res> {
  _$AllTypeIncidentModelCopyWithImpl(this._value, this._then);

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
abstract class _$$AllTypeIncidentModelImplCopyWith<$Res>
    implements $AllTypeIncidentModelCopyWith<$Res> {
  factory _$$AllTypeIncidentModelImplCopyWith(_$AllTypeIncidentModelImpl value,
          $Res Function(_$AllTypeIncidentModelImpl) then) =
      __$$AllTypeIncidentModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String description});
}

/// @nodoc
class __$$AllTypeIncidentModelImplCopyWithImpl<$Res>
    extends _$AllTypeIncidentModelCopyWithImpl<$Res, _$AllTypeIncidentModelImpl>
    implements _$$AllTypeIncidentModelImplCopyWith<$Res> {
  __$$AllTypeIncidentModelImplCopyWithImpl(_$AllTypeIncidentModelImpl _value,
      $Res Function(_$AllTypeIncidentModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? description = null,
  }) {
    return _then(_$AllTypeIncidentModelImpl(
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
class _$AllTypeIncidentModelImpl implements _AllTypeIncidentModel {
  const _$AllTypeIncidentModelImpl({this.id = 0, this.description = ""});

  factory _$AllTypeIncidentModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AllTypeIncidentModelImplFromJson(json);

  @override
  @JsonKey()
  final int id;
  @override
  @JsonKey()
  final String description;

  @override
  String toString() {
    return 'AllTypeIncidentModel(id: $id, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AllTypeIncidentModelImpl &&
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
  _$$AllTypeIncidentModelImplCopyWith<_$AllTypeIncidentModelImpl>
      get copyWith =>
          __$$AllTypeIncidentModelImplCopyWithImpl<_$AllTypeIncidentModelImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AllTypeIncidentModelImplToJson(
      this,
    );
  }
}

abstract class _AllTypeIncidentModel implements AllTypeIncidentModel {
  const factory _AllTypeIncidentModel(
      {final int id, final String description}) = _$AllTypeIncidentModelImpl;

  factory _AllTypeIncidentModel.fromJson(Map<String, dynamic> json) =
      _$AllTypeIncidentModelImpl.fromJson;

  @override
  int get id;
  @override
  String get description;
  @override
  @JsonKey(ignore: true)
  _$$AllTypeIncidentModelImplCopyWith<_$AllTypeIncidentModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
