// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'generateExcel_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GenerateExcelModel _$GenerateExcelModelFromJson(Map<String, dynamic> json) {
  return _GenerateExcelModel.fromJson(json);
}

/// @nodoc
mixin _$GenerateExcelModel {
  String get url => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GenerateExcelModelCopyWith<GenerateExcelModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GenerateExcelModelCopyWith<$Res> {
  factory $GenerateExcelModelCopyWith(
          GenerateExcelModel value, $Res Function(GenerateExcelModel) then) =
      _$GenerateExcelModelCopyWithImpl<$Res, GenerateExcelModel>;
  @useResult
  $Res call({String url});
}

/// @nodoc
class _$GenerateExcelModelCopyWithImpl<$Res, $Val extends GenerateExcelModel>
    implements $GenerateExcelModelCopyWith<$Res> {
  _$GenerateExcelModelCopyWithImpl(this._value, this._then);

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
abstract class _$$GenerateExcelModelImplCopyWith<$Res>
    implements $GenerateExcelModelCopyWith<$Res> {
  factory _$$GenerateExcelModelImplCopyWith(_$GenerateExcelModelImpl value,
          $Res Function(_$GenerateExcelModelImpl) then) =
      __$$GenerateExcelModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String url});
}

/// @nodoc
class __$$GenerateExcelModelImplCopyWithImpl<$Res>
    extends _$GenerateExcelModelCopyWithImpl<$Res, _$GenerateExcelModelImpl>
    implements _$$GenerateExcelModelImplCopyWith<$Res> {
  __$$GenerateExcelModelImplCopyWithImpl(_$GenerateExcelModelImpl _value,
      $Res Function(_$GenerateExcelModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
  }) {
    return _then(_$GenerateExcelModelImpl(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GenerateExcelModelImpl implements _GenerateExcelModel {
  const _$GenerateExcelModelImpl({this.url = ""});

  factory _$GenerateExcelModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$GenerateExcelModelImplFromJson(json);

  @override
  @JsonKey()
  final String url;

  @override
  String toString() {
    return 'GenerateExcelModel(url: $url)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GenerateExcelModelImpl &&
            (identical(other.url, url) || other.url == url));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, url);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GenerateExcelModelImplCopyWith<_$GenerateExcelModelImpl> get copyWith =>
      __$$GenerateExcelModelImplCopyWithImpl<_$GenerateExcelModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GenerateExcelModelImplToJson(
      this,
    );
  }
}

abstract class _GenerateExcelModel implements GenerateExcelModel {
  const factory _GenerateExcelModel({final String url}) =
      _$GenerateExcelModelImpl;

  factory _GenerateExcelModel.fromJson(Map<String, dynamic> json) =
      _$GenerateExcelModelImpl.fromJson;

  @override
  String get url;
  @override
  @JsonKey(ignore: true)
  _$$GenerateExcelModelImplCopyWith<_$GenerateExcelModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
