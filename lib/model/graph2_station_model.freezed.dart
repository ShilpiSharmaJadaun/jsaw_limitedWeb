// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'graph2_station_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Graph2StationModel _$Graph2StationModelFromJson(Map<String, dynamic> json) {
  return _Graph2StationModel.fromJson(json);
}

/// @nodoc
mixin _$Graph2StationModel {
  String get name => throw _privateConstructorUsedError;
  String get code => throw _privateConstructorUsedError;
  String get count => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $Graph2StationModelCopyWith<Graph2StationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $Graph2StationModelCopyWith<$Res> {
  factory $Graph2StationModelCopyWith(
          Graph2StationModel value, $Res Function(Graph2StationModel) then) =
      _$Graph2StationModelCopyWithImpl<$Res, Graph2StationModel>;
  @useResult
  $Res call({String name, String code, String count});
}

/// @nodoc
class _$Graph2StationModelCopyWithImpl<$Res, $Val extends Graph2StationModel>
    implements $Graph2StationModelCopyWith<$Res> {
  _$Graph2StationModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? code = null,
    Object? count = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$Graph2StationModelImplCopyWith<$Res>
    implements $Graph2StationModelCopyWith<$Res> {
  factory _$$Graph2StationModelImplCopyWith(_$Graph2StationModelImpl value,
          $Res Function(_$Graph2StationModelImpl) then) =
      __$$Graph2StationModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String code, String count});
}

/// @nodoc
class __$$Graph2StationModelImplCopyWithImpl<$Res>
    extends _$Graph2StationModelCopyWithImpl<$Res, _$Graph2StationModelImpl>
    implements _$$Graph2StationModelImplCopyWith<$Res> {
  __$$Graph2StationModelImplCopyWithImpl(_$Graph2StationModelImpl _value,
      $Res Function(_$Graph2StationModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? code = null,
    Object? count = null,
  }) {
    return _then(_$Graph2StationModelImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$Graph2StationModelImpl implements _Graph2StationModel {
  const _$Graph2StationModelImpl(
      {this.name = '', this.code = '', this.count = ''});

  factory _$Graph2StationModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$Graph2StationModelImplFromJson(json);

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String code;
  @override
  @JsonKey()
  final String count;

  @override
  String toString() {
    return 'Graph2StationModel(name: $name, code: $code, count: $count)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Graph2StationModelImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.count, count) || other.count == count));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, code, count);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$Graph2StationModelImplCopyWith<_$Graph2StationModelImpl> get copyWith =>
      __$$Graph2StationModelImplCopyWithImpl<_$Graph2StationModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$Graph2StationModelImplToJson(
      this,
    );
  }
}

abstract class _Graph2StationModel implements Graph2StationModel {
  const factory _Graph2StationModel(
      {final String name,
      final String code,
      final String count}) = _$Graph2StationModelImpl;

  factory _Graph2StationModel.fromJson(Map<String, dynamic> json) =
      _$Graph2StationModelImpl.fromJson;

  @override
  String get name;
  @override
  String get code;
  @override
  String get count;
  @override
  @JsonKey(ignore: true)
  _$$Graph2StationModelImplCopyWith<_$Graph2StationModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
