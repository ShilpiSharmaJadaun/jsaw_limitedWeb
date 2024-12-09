// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'top3hazard_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Top3HazardModel _$Top3HazardModelFromJson(Map<String, dynamic> json) {
  return _Top3HazardModel.fromJson(json);
}

/// @nodoc
mixin _$Top3HazardModel {
  String get hazardCategory => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $Top3HazardModelCopyWith<Top3HazardModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $Top3HazardModelCopyWith<$Res> {
  factory $Top3HazardModelCopyWith(
          Top3HazardModel value, $Res Function(Top3HazardModel) then) =
      _$Top3HazardModelCopyWithImpl<$Res, Top3HazardModel>;
  @useResult
  $Res call({String hazardCategory, int count});
}

/// @nodoc
class _$Top3HazardModelCopyWithImpl<$Res, $Val extends Top3HazardModel>
    implements $Top3HazardModelCopyWith<$Res> {
  _$Top3HazardModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hazardCategory = null,
    Object? count = null,
  }) {
    return _then(_value.copyWith(
      hazardCategory: null == hazardCategory
          ? _value.hazardCategory
          : hazardCategory // ignore: cast_nullable_to_non_nullable
              as String,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$Top3HazardModelImplCopyWith<$Res>
    implements $Top3HazardModelCopyWith<$Res> {
  factory _$$Top3HazardModelImplCopyWith(_$Top3HazardModelImpl value,
          $Res Function(_$Top3HazardModelImpl) then) =
      __$$Top3HazardModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String hazardCategory, int count});
}

/// @nodoc
class __$$Top3HazardModelImplCopyWithImpl<$Res>
    extends _$Top3HazardModelCopyWithImpl<$Res, _$Top3HazardModelImpl>
    implements _$$Top3HazardModelImplCopyWith<$Res> {
  __$$Top3HazardModelImplCopyWithImpl(
      _$Top3HazardModelImpl _value, $Res Function(_$Top3HazardModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hazardCategory = null,
    Object? count = null,
  }) {
    return _then(_$Top3HazardModelImpl(
      hazardCategory: null == hazardCategory
          ? _value.hazardCategory
          : hazardCategory // ignore: cast_nullable_to_non_nullable
              as String,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$Top3HazardModelImpl implements _Top3HazardModel {
  const _$Top3HazardModelImpl({this.hazardCategory = "", this.count = 0});

  factory _$Top3HazardModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$Top3HazardModelImplFromJson(json);

  @override
  @JsonKey()
  final String hazardCategory;
  @override
  @JsonKey()
  final int count;

  @override
  String toString() {
    return 'Top3HazardModel(hazardCategory: $hazardCategory, count: $count)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Top3HazardModelImpl &&
            (identical(other.hazardCategory, hazardCategory) ||
                other.hazardCategory == hazardCategory) &&
            (identical(other.count, count) || other.count == count));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, hazardCategory, count);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$Top3HazardModelImplCopyWith<_$Top3HazardModelImpl> get copyWith =>
      __$$Top3HazardModelImplCopyWithImpl<_$Top3HazardModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$Top3HazardModelImplToJson(
      this,
    );
  }
}

abstract class _Top3HazardModel implements Top3HazardModel {
  const factory _Top3HazardModel(
      {final String hazardCategory, final int count}) = _$Top3HazardModelImpl;

  factory _Top3HazardModel.fromJson(Map<String, dynamic> json) =
      _$Top3HazardModelImpl.fromJson;

  @override
  String get hazardCategory;
  @override
  int get count;
  @override
  @JsonKey(ignore: true)
  _$$Top3HazardModelImplCopyWith<_$Top3HazardModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
