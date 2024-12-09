// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stationwise_graph_export.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

StationWiseGraphExportModel _$StationWiseGraphExportModelFromJson(
    Map<String, dynamic> json) {
  return _StationWiseGraphExportModel.fromJson(json);
}

/// @nodoc
mixin _$StationWiseGraphExportModel {
  String get url => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StationWiseGraphExportModelCopyWith<StationWiseGraphExportModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StationWiseGraphExportModelCopyWith<$Res> {
  factory $StationWiseGraphExportModelCopyWith(
          StationWiseGraphExportModel value,
          $Res Function(StationWiseGraphExportModel) then) =
      _$StationWiseGraphExportModelCopyWithImpl<$Res,
          StationWiseGraphExportModel>;
  @useResult
  $Res call({String url});
}

/// @nodoc
class _$StationWiseGraphExportModelCopyWithImpl<$Res,
        $Val extends StationWiseGraphExportModel>
    implements $StationWiseGraphExportModelCopyWith<$Res> {
  _$StationWiseGraphExportModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
  }) {
    return _then(_value.copyWith(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StationWiseGraphExportModelImplCopyWith<$Res>
    implements $StationWiseGraphExportModelCopyWith<$Res> {
  factory _$$StationWiseGraphExportModelImplCopyWith(
          _$StationWiseGraphExportModelImpl value,
          $Res Function(_$StationWiseGraphExportModelImpl) then) =
      __$$StationWiseGraphExportModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String url});
}

/// @nodoc
class __$$StationWiseGraphExportModelImplCopyWithImpl<$Res>
    extends _$StationWiseGraphExportModelCopyWithImpl<$Res,
        _$StationWiseGraphExportModelImpl>
    implements _$$StationWiseGraphExportModelImplCopyWith<$Res> {
  __$$StationWiseGraphExportModelImplCopyWithImpl(
      _$StationWiseGraphExportModelImpl _value,
      $Res Function(_$StationWiseGraphExportModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
  }) {
    return _then(_$StationWiseGraphExportModelImpl(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StationWiseGraphExportModelImpl
    implements _StationWiseGraphExportModel {
  const _$StationWiseGraphExportModelImpl({this.url = ""});

  factory _$StationWiseGraphExportModelImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$StationWiseGraphExportModelImplFromJson(json);

  @override
  @JsonKey()
  final String url;

  @override
  String toString() {
    return 'StationWiseGraphExportModel(url: $url)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StationWiseGraphExportModelImpl &&
            (identical(other.url, url) || other.url == url));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, url);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StationWiseGraphExportModelImplCopyWith<_$StationWiseGraphExportModelImpl>
      get copyWith => __$$StationWiseGraphExportModelImplCopyWithImpl<
          _$StationWiseGraphExportModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StationWiseGraphExportModelImplToJson(
      this,
    );
  }
}

abstract class _StationWiseGraphExportModel
    implements StationWiseGraphExportModel {
  const factory _StationWiseGraphExportModel({final String url}) =
      _$StationWiseGraphExportModelImpl;

  factory _StationWiseGraphExportModel.fromJson(Map<String, dynamic> json) =
      _$StationWiseGraphExportModelImpl.fromJson;

  @override
  String get url;
  @override
  @JsonKey(ignore: true)
  _$$StationWiseGraphExportModelImplCopyWith<_$StationWiseGraphExportModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
