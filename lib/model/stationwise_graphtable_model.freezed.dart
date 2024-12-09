// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stationwise_graphtable_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

StationWiseGraphTableModel _$StationWiseGraphTableModelFromJson(
    Map<String, dynamic> json) {
  return _StationWiseGraphTableModel.fromJson(json);
}

/// @nodoc
mixin _$StationWiseGraphTableModel {
  String get stationName => throw _privateConstructorUsedError;
  int get totalRaised => throw _privateConstructorUsedError;
  int get totalReceived => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StationWiseGraphTableModelCopyWith<StationWiseGraphTableModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StationWiseGraphTableModelCopyWith<$Res> {
  factory $StationWiseGraphTableModelCopyWith(StationWiseGraphTableModel value,
          $Res Function(StationWiseGraphTableModel) then) =
      _$StationWiseGraphTableModelCopyWithImpl<$Res,
          StationWiseGraphTableModel>;
  @useResult
  $Res call({String stationName, int totalRaised, int totalReceived});
}

/// @nodoc
class _$StationWiseGraphTableModelCopyWithImpl<$Res,
        $Val extends StationWiseGraphTableModel>
    implements $StationWiseGraphTableModelCopyWith<$Res> {
  _$StationWiseGraphTableModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stationName = null,
    Object? totalRaised = null,
    Object? totalReceived = null,
  }) {
    return _then(_value.copyWith(
      stationName: null == stationName
          ? _value.stationName
          : stationName // ignore: cast_nullable_to_non_nullable
              as String,
      totalRaised: null == totalRaised
          ? _value.totalRaised
          : totalRaised // ignore: cast_nullable_to_non_nullable
              as int,
      totalReceived: null == totalReceived
          ? _value.totalReceived
          : totalReceived // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StationWiseGraphTableModelImplCopyWith<$Res>
    implements $StationWiseGraphTableModelCopyWith<$Res> {
  factory _$$StationWiseGraphTableModelImplCopyWith(
          _$StationWiseGraphTableModelImpl value,
          $Res Function(_$StationWiseGraphTableModelImpl) then) =
      __$$StationWiseGraphTableModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String stationName, int totalRaised, int totalReceived});
}

/// @nodoc
class __$$StationWiseGraphTableModelImplCopyWithImpl<$Res>
    extends _$StationWiseGraphTableModelCopyWithImpl<$Res,
        _$StationWiseGraphTableModelImpl>
    implements _$$StationWiseGraphTableModelImplCopyWith<$Res> {
  __$$StationWiseGraphTableModelImplCopyWithImpl(
      _$StationWiseGraphTableModelImpl _value,
      $Res Function(_$StationWiseGraphTableModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stationName = null,
    Object? totalRaised = null,
    Object? totalReceived = null,
  }) {
    return _then(_$StationWiseGraphTableModelImpl(
      stationName: null == stationName
          ? _value.stationName
          : stationName // ignore: cast_nullable_to_non_nullable
              as String,
      totalRaised: null == totalRaised
          ? _value.totalRaised
          : totalRaised // ignore: cast_nullable_to_non_nullable
              as int,
      totalReceived: null == totalReceived
          ? _value.totalReceived
          : totalReceived // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StationWiseGraphTableModelImpl implements _StationWiseGraphTableModel {
  const _$StationWiseGraphTableModelImpl(
      {this.stationName = "", this.totalRaised = 0, this.totalReceived = 0});

  factory _$StationWiseGraphTableModelImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$StationWiseGraphTableModelImplFromJson(json);

  @override
  @JsonKey()
  final String stationName;
  @override
  @JsonKey()
  final int totalRaised;
  @override
  @JsonKey()
  final int totalReceived;

  @override
  String toString() {
    return 'StationWiseGraphTableModel(stationName: $stationName, totalRaised: $totalRaised, totalReceived: $totalReceived)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StationWiseGraphTableModelImpl &&
            (identical(other.stationName, stationName) ||
                other.stationName == stationName) &&
            (identical(other.totalRaised, totalRaised) ||
                other.totalRaised == totalRaised) &&
            (identical(other.totalReceived, totalReceived) ||
                other.totalReceived == totalReceived));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, stationName, totalRaised, totalReceived);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StationWiseGraphTableModelImplCopyWith<_$StationWiseGraphTableModelImpl>
      get copyWith => __$$StationWiseGraphTableModelImplCopyWithImpl<
          _$StationWiseGraphTableModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StationWiseGraphTableModelImplToJson(
      this,
    );
  }
}

abstract class _StationWiseGraphTableModel
    implements StationWiseGraphTableModel {
  const factory _StationWiseGraphTableModel(
      {final String stationName,
      final int totalRaised,
      final int totalReceived}) = _$StationWiseGraphTableModelImpl;

  factory _StationWiseGraphTableModel.fromJson(Map<String, dynamic> json) =
      _$StationWiseGraphTableModelImpl.fromJson;

  @override
  String get stationName;
  @override
  int get totalRaised;
  @override
  int get totalReceived;
  @override
  @JsonKey(ignore: true)
  _$$StationWiseGraphTableModelImplCopyWith<_$StationWiseGraphTableModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
