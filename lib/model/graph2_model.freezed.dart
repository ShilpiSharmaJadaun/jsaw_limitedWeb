// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'graph2_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Graph2Model _$Graph2ModelFromJson(Map<String, dynamic> json) {
  return _Graph2Model.fromJson(json);
}

/// @nodoc
mixin _$Graph2Model {
  String get plantDept => throw _privateConstructorUsedError;
  String get plantDeptCode => throw _privateConstructorUsedError;
  String get totalCount => throw _privateConstructorUsedError;
  List<Graph2StationModel> get stations => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $Graph2ModelCopyWith<Graph2Model> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $Graph2ModelCopyWith<$Res> {
  factory $Graph2ModelCopyWith(
          Graph2Model value, $Res Function(Graph2Model) then) =
      _$Graph2ModelCopyWithImpl<$Res, Graph2Model>;
  @useResult
  $Res call(
      {String plantDept,
      String plantDeptCode,
      String totalCount,
      List<Graph2StationModel> stations});
}

/// @nodoc
class _$Graph2ModelCopyWithImpl<$Res, $Val extends Graph2Model>
    implements $Graph2ModelCopyWith<$Res> {
  _$Graph2ModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? plantDept = null,
    Object? plantDeptCode = null,
    Object? totalCount = null,
    Object? stations = null,
  }) {
    return _then(_value.copyWith(
      plantDept: null == plantDept
          ? _value.plantDept
          : plantDept // ignore: cast_nullable_to_non_nullable
              as String,
      plantDeptCode: null == plantDeptCode
          ? _value.plantDeptCode
          : plantDeptCode // ignore: cast_nullable_to_non_nullable
              as String,
      totalCount: null == totalCount
          ? _value.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as String,
      stations: null == stations
          ? _value.stations
          : stations // ignore: cast_nullable_to_non_nullable
              as List<Graph2StationModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$Graph2ModelImplCopyWith<$Res>
    implements $Graph2ModelCopyWith<$Res> {
  factory _$$Graph2ModelImplCopyWith(
          _$Graph2ModelImpl value, $Res Function(_$Graph2ModelImpl) then) =
      __$$Graph2ModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String plantDept,
      String plantDeptCode,
      String totalCount,
      List<Graph2StationModel> stations});
}

/// @nodoc
class __$$Graph2ModelImplCopyWithImpl<$Res>
    extends _$Graph2ModelCopyWithImpl<$Res, _$Graph2ModelImpl>
    implements _$$Graph2ModelImplCopyWith<$Res> {
  __$$Graph2ModelImplCopyWithImpl(
      _$Graph2ModelImpl _value, $Res Function(_$Graph2ModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? plantDept = null,
    Object? plantDeptCode = null,
    Object? totalCount = null,
    Object? stations = null,
  }) {
    return _then(_$Graph2ModelImpl(
      plantDept: null == plantDept
          ? _value.plantDept
          : plantDept // ignore: cast_nullable_to_non_nullable
              as String,
      plantDeptCode: null == plantDeptCode
          ? _value.plantDeptCode
          : plantDeptCode // ignore: cast_nullable_to_non_nullable
              as String,
      totalCount: null == totalCount
          ? _value.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as String,
      stations: null == stations
          ? _value._stations
          : stations // ignore: cast_nullable_to_non_nullable
              as List<Graph2StationModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$Graph2ModelImpl implements _Graph2Model {
  const _$Graph2ModelImpl(
      {this.plantDept = '',
      this.plantDeptCode = '',
      this.totalCount = '',
      final List<Graph2StationModel> stations = const <Graph2StationModel>[]})
      : _stations = stations;

  factory _$Graph2ModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$Graph2ModelImplFromJson(json);

  @override
  @JsonKey()
  final String plantDept;
  @override
  @JsonKey()
  final String plantDeptCode;
  @override
  @JsonKey()
  final String totalCount;
  final List<Graph2StationModel> _stations;
  @override
  @JsonKey()
  List<Graph2StationModel> get stations {
    if (_stations is EqualUnmodifiableListView) return _stations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_stations);
  }

  @override
  String toString() {
    return 'Graph2Model(plantDept: $plantDept, plantDeptCode: $plantDeptCode, totalCount: $totalCount, stations: $stations)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Graph2ModelImpl &&
            (identical(other.plantDept, plantDept) ||
                other.plantDept == plantDept) &&
            (identical(other.plantDeptCode, plantDeptCode) ||
                other.plantDeptCode == plantDeptCode) &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount) &&
            const DeepCollectionEquality().equals(other._stations, _stations));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, plantDept, plantDeptCode,
      totalCount, const DeepCollectionEquality().hash(_stations));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$Graph2ModelImplCopyWith<_$Graph2ModelImpl> get copyWith =>
      __$$Graph2ModelImplCopyWithImpl<_$Graph2ModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$Graph2ModelImplToJson(
      this,
    );
  }
}

abstract class _Graph2Model implements Graph2Model {
  const factory _Graph2Model(
      {final String plantDept,
      final String plantDeptCode,
      final String totalCount,
      final List<Graph2StationModel> stations}) = _$Graph2ModelImpl;

  factory _Graph2Model.fromJson(Map<String, dynamic> json) =
      _$Graph2ModelImpl.fromJson;

  @override
  String get plantDept;
  @override
  String get plantDeptCode;
  @override
  String get totalCount;
  @override
  List<Graph2StationModel> get stations;
  @override
  @JsonKey(ignore: true)
  _$$Graph2ModelImplCopyWith<_$Graph2ModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
