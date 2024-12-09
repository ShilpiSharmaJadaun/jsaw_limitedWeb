// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hazardGraphExport_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

HazardGraphExportModel _$HazardGraphExportModelFromJson(
    Map<String, dynamic> json) {
  return _HazardGraphExportModel.fromJson(json);
}

/// @nodoc
mixin _$HazardGraphExportModel {
  String get url => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HazardGraphExportModelCopyWith<HazardGraphExportModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HazardGraphExportModelCopyWith<$Res> {
  factory $HazardGraphExportModelCopyWith(HazardGraphExportModel value,
          $Res Function(HazardGraphExportModel) then) =
      _$HazardGraphExportModelCopyWithImpl<$Res, HazardGraphExportModel>;
  @useResult
  $Res call({String url});
}

/// @nodoc
class _$HazardGraphExportModelCopyWithImpl<$Res,
        $Val extends HazardGraphExportModel>
    implements $HazardGraphExportModelCopyWith<$Res> {
  _$HazardGraphExportModelCopyWithImpl(this._value, this._then);

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
abstract class _$$HazardGraphExportModelImplCopyWith<$Res>
    implements $HazardGraphExportModelCopyWith<$Res> {
  factory _$$HazardGraphExportModelImplCopyWith(
          _$HazardGraphExportModelImpl value,
          $Res Function(_$HazardGraphExportModelImpl) then) =
      __$$HazardGraphExportModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String url});
}

/// @nodoc
class __$$HazardGraphExportModelImplCopyWithImpl<$Res>
    extends _$HazardGraphExportModelCopyWithImpl<$Res,
        _$HazardGraphExportModelImpl>
    implements _$$HazardGraphExportModelImplCopyWith<$Res> {
  __$$HazardGraphExportModelImplCopyWithImpl(
      _$HazardGraphExportModelImpl _value,
      $Res Function(_$HazardGraphExportModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
  }) {
    return _then(_$HazardGraphExportModelImpl(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HazardGraphExportModelImpl implements _HazardGraphExportModel {
  const _$HazardGraphExportModelImpl({this.url = ""});

  factory _$HazardGraphExportModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$HazardGraphExportModelImplFromJson(json);

  @override
  @JsonKey()
  final String url;

  @override
  String toString() {
    return 'HazardGraphExportModel(url: $url)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HazardGraphExportModelImpl &&
            (identical(other.url, url) || other.url == url));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, url);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HazardGraphExportModelImplCopyWith<_$HazardGraphExportModelImpl>
      get copyWith => __$$HazardGraphExportModelImplCopyWithImpl<
          _$HazardGraphExportModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HazardGraphExportModelImplToJson(
      this,
    );
  }
}

abstract class _HazardGraphExportModel implements HazardGraphExportModel {
  const factory _HazardGraphExportModel({final String url}) =
      _$HazardGraphExportModelImpl;

  factory _HazardGraphExportModel.fromJson(Map<String, dynamic> json) =
      _$HazardGraphExportModelImpl.fromJson;

  @override
  String get url;
  @override
  @JsonKey(ignore: true)
  _$$HazardGraphExportModelImplCopyWith<_$HazardGraphExportModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
