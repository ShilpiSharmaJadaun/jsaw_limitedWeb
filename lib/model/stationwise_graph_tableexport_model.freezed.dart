// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stationwise_graph_tableexport_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

StationWiseTableExportModel _$StationWiseTableExportModelFromJson(
    Map<String, dynamic> json) {
  return _StationWiseTableExportModel.fromJson(json);
}

/// @nodoc
mixin _$StationWiseTableExportModel {
  String get url => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StationWiseTableExportModelCopyWith<StationWiseTableExportModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StationWiseTableExportModelCopyWith<$Res> {
  factory $StationWiseTableExportModelCopyWith(
          StationWiseTableExportModel value,
          $Res Function(StationWiseTableExportModel) then) =
      _$StationWiseTableExportModelCopyWithImpl<$Res,
          StationWiseTableExportModel>;
  @useResult
  $Res call({String url});
}

/// @nodoc
class _$StationWiseTableExportModelCopyWithImpl<$Res,
        $Val extends StationWiseTableExportModel>
    implements $StationWiseTableExportModelCopyWith<$Res> {
  _$StationWiseTableExportModelCopyWithImpl(this._value, this._then);

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
abstract class _$$StationWiseTableExportModelImplCopyWith<$Res>
    implements $StationWiseTableExportModelCopyWith<$Res> {
  factory _$$StationWiseTableExportModelImplCopyWith(
          _$StationWiseTableExportModelImpl value,
          $Res Function(_$StationWiseTableExportModelImpl) then) =
      __$$StationWiseTableExportModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String url});
}

/// @nodoc
class __$$StationWiseTableExportModelImplCopyWithImpl<$Res>
    extends _$StationWiseTableExportModelCopyWithImpl<$Res,
        _$StationWiseTableExportModelImpl>
    implements _$$StationWiseTableExportModelImplCopyWith<$Res> {
  __$$StationWiseTableExportModelImplCopyWithImpl(
      _$StationWiseTableExportModelImpl _value,
      $Res Function(_$StationWiseTableExportModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
  }) {
    return _then(_$StationWiseTableExportModelImpl(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StationWiseTableExportModelImpl
    implements _StationWiseTableExportModel {
  const _$StationWiseTableExportModelImpl({this.url = ""});

  factory _$StationWiseTableExportModelImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$StationWiseTableExportModelImplFromJson(json);

  @override
  @JsonKey()
  final String url;

  @override
  String toString() {
    return 'StationWiseTableExportModel(url: $url)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StationWiseTableExportModelImpl &&
            (identical(other.url, url) || other.url == url));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, url);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StationWiseTableExportModelImplCopyWith<_$StationWiseTableExportModelImpl>
      get copyWith => __$$StationWiseTableExportModelImplCopyWithImpl<
          _$StationWiseTableExportModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StationWiseTableExportModelImplToJson(
      this,
    );
  }
}

abstract class _StationWiseTableExportModel
    implements StationWiseTableExportModel {
  const factory _StationWiseTableExportModel({final String url}) =
      _$StationWiseTableExportModelImpl;

  factory _StationWiseTableExportModel.fromJson(Map<String, dynamic> json) =
      _$StationWiseTableExportModelImpl.fromJson;

  @override
  String get url;
  @override
  @JsonKey(ignore: true)
  _$$StationWiseTableExportModelImplCopyWith<_$StationWiseTableExportModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
