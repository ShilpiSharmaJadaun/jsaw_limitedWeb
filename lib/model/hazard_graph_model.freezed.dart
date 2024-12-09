// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hazard_graph_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

HazardGraphModel _$HazardGraphModelFromJson(Map<String, dynamic> json) {
  return _HazardGraphModel.fromJson(json);
}

/// @nodoc
mixin _$HazardGraphModel {
  String get hazardCategory => throw _privateConstructorUsedError;
  int get observationCount => throw _privateConstructorUsedError;
  int get percentage => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HazardGraphModelCopyWith<HazardGraphModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HazardGraphModelCopyWith<$Res> {
  factory $HazardGraphModelCopyWith(
          HazardGraphModel value, $Res Function(HazardGraphModel) then) =
      _$HazardGraphModelCopyWithImpl<$Res, HazardGraphModel>;
  @useResult
  $Res call({String hazardCategory, int observationCount, int percentage});
}

/// @nodoc
class _$HazardGraphModelCopyWithImpl<$Res, $Val extends HazardGraphModel>
    implements $HazardGraphModelCopyWith<$Res> {
  _$HazardGraphModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hazardCategory = null,
    Object? observationCount = null,
    Object? percentage = null,
  }) {
    return _then(_value.copyWith(
      hazardCategory: null == hazardCategory
          ? _value.hazardCategory
          : hazardCategory // ignore: cast_nullable_to_non_nullable
              as String,
      observationCount: null == observationCount
          ? _value.observationCount
          : observationCount // ignore: cast_nullable_to_non_nullable
              as int,
      percentage: null == percentage
          ? _value.percentage
          : percentage // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HazardGraphModelImplCopyWith<$Res>
    implements $HazardGraphModelCopyWith<$Res> {
  factory _$$HazardGraphModelImplCopyWith(_$HazardGraphModelImpl value,
          $Res Function(_$HazardGraphModelImpl) then) =
      __$$HazardGraphModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String hazardCategory, int observationCount, int percentage});
}

/// @nodoc
class __$$HazardGraphModelImplCopyWithImpl<$Res>
    extends _$HazardGraphModelCopyWithImpl<$Res, _$HazardGraphModelImpl>
    implements _$$HazardGraphModelImplCopyWith<$Res> {
  __$$HazardGraphModelImplCopyWithImpl(_$HazardGraphModelImpl _value,
      $Res Function(_$HazardGraphModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hazardCategory = null,
    Object? observationCount = null,
    Object? percentage = null,
  }) {
    return _then(_$HazardGraphModelImpl(
      hazardCategory: null == hazardCategory
          ? _value.hazardCategory
          : hazardCategory // ignore: cast_nullable_to_non_nullable
              as String,
      observationCount: null == observationCount
          ? _value.observationCount
          : observationCount // ignore: cast_nullable_to_non_nullable
              as int,
      percentage: null == percentage
          ? _value.percentage
          : percentage // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HazardGraphModelImpl implements _HazardGraphModel {
  const _$HazardGraphModelImpl(
      {this.hazardCategory = '',
      this.observationCount = 0,
      this.percentage = 0});

  factory _$HazardGraphModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$HazardGraphModelImplFromJson(json);

  @override
  @JsonKey()
  final String hazardCategory;
  @override
  @JsonKey()
  final int observationCount;
  @override
  @JsonKey()
  final int percentage;

  @override
  String toString() {
    return 'HazardGraphModel(hazardCategory: $hazardCategory, observationCount: $observationCount, percentage: $percentage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HazardGraphModelImpl &&
            (identical(other.hazardCategory, hazardCategory) ||
                other.hazardCategory == hazardCategory) &&
            (identical(other.observationCount, observationCount) ||
                other.observationCount == observationCount) &&
            (identical(other.percentage, percentage) ||
                other.percentage == percentage));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, hazardCategory, observationCount, percentage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HazardGraphModelImplCopyWith<_$HazardGraphModelImpl> get copyWith =>
      __$$HazardGraphModelImplCopyWithImpl<_$HazardGraphModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HazardGraphModelImplToJson(
      this,
    );
  }
}

abstract class _HazardGraphModel implements HazardGraphModel {
  const factory _HazardGraphModel(
      {final String hazardCategory,
      final int observationCount,
      final int percentage}) = _$HazardGraphModelImpl;

  factory _HazardGraphModel.fromJson(Map<String, dynamic> json) =
      _$HazardGraphModelImpl.fromJson;

  @override
  String get hazardCategory;
  @override
  int get observationCount;
  @override
  int get percentage;
  @override
  @JsonKey(ignore: true)
  _$$HazardGraphModelImplCopyWith<_$HazardGraphModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
