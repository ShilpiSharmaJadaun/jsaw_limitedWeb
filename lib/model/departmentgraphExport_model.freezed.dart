// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'departmentgraphExport_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DepartmentgraphExportModel _$DepartmentgraphExportModelFromJson(
    Map<String, dynamic> json) {
  return _DepartmentgraphExportModel.fromJson(json);
}

/// @nodoc
mixin _$DepartmentgraphExportModel {
  String get url => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DepartmentgraphExportModelCopyWith<DepartmentgraphExportModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DepartmentgraphExportModelCopyWith<$Res> {
  factory $DepartmentgraphExportModelCopyWith(DepartmentgraphExportModel value,
          $Res Function(DepartmentgraphExportModel) then) =
      _$DepartmentgraphExportModelCopyWithImpl<$Res,
          DepartmentgraphExportModel>;
  @useResult
  $Res call({String url});
}

/// @nodoc
class _$DepartmentgraphExportModelCopyWithImpl<$Res,
        $Val extends DepartmentgraphExportModel>
    implements $DepartmentgraphExportModelCopyWith<$Res> {
  _$DepartmentgraphExportModelCopyWithImpl(this._value, this._then);

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
abstract class _$$DepartmentgraphExportModelImplCopyWith<$Res>
    implements $DepartmentgraphExportModelCopyWith<$Res> {
  factory _$$DepartmentgraphExportModelImplCopyWith(
          _$DepartmentgraphExportModelImpl value,
          $Res Function(_$DepartmentgraphExportModelImpl) then) =
      __$$DepartmentgraphExportModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String url});
}

/// @nodoc
class __$$DepartmentgraphExportModelImplCopyWithImpl<$Res>
    extends _$DepartmentgraphExportModelCopyWithImpl<$Res,
        _$DepartmentgraphExportModelImpl>
    implements _$$DepartmentgraphExportModelImplCopyWith<$Res> {
  __$$DepartmentgraphExportModelImplCopyWithImpl(
      _$DepartmentgraphExportModelImpl _value,
      $Res Function(_$DepartmentgraphExportModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
  }) {
    return _then(_$DepartmentgraphExportModelImpl(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DepartmentgraphExportModelImpl implements _DepartmentgraphExportModel {
  const _$DepartmentgraphExportModelImpl({this.url = ""});

  factory _$DepartmentgraphExportModelImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$DepartmentgraphExportModelImplFromJson(json);

  @override
  @JsonKey()
  final String url;

  @override
  String toString() {
    return 'DepartmentgraphExportModel(url: $url)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DepartmentgraphExportModelImpl &&
            (identical(other.url, url) || other.url == url));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, url);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DepartmentgraphExportModelImplCopyWith<_$DepartmentgraphExportModelImpl>
      get copyWith => __$$DepartmentgraphExportModelImplCopyWithImpl<
          _$DepartmentgraphExportModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DepartmentgraphExportModelImplToJson(
      this,
    );
  }
}

abstract class _DepartmentgraphExportModel
    implements DepartmentgraphExportModel {
  const factory _DepartmentgraphExportModel({final String url}) =
      _$DepartmentgraphExportModelImpl;

  factory _DepartmentgraphExportModel.fromJson(Map<String, dynamic> json) =
      _$DepartmentgraphExportModelImpl.fromJson;

  @override
  String get url;
  @override
  @JsonKey(ignore: true)
  _$$DepartmentgraphExportModelImplCopyWith<_$DepartmentgraphExportModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
