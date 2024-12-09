// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'observation_status_List_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ObservationStatusListModel _$ObservationStatusListModelFromJson(
    Map<String, dynamic> json) {
  return _ObservationStatusListModel.fromJson(json);
}

/// @nodoc
mixin _$ObservationStatusListModel {
  double get percentage => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ObservationStatusListModelCopyWith<ObservationStatusListModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ObservationStatusListModelCopyWith<$Res> {
  factory $ObservationStatusListModelCopyWith(ObservationStatusListModel value,
          $Res Function(ObservationStatusListModel) then) =
      _$ObservationStatusListModelCopyWithImpl<$Res,
          ObservationStatusListModel>;
  @useResult
  $Res call({double percentage, int count, String name});
}

/// @nodoc
class _$ObservationStatusListModelCopyWithImpl<$Res,
        $Val extends ObservationStatusListModel>
    implements $ObservationStatusListModelCopyWith<$Res> {
  _$ObservationStatusListModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? percentage = null,
    Object? count = null,
    Object? name = null,
  }) {
    return _then(_value.copyWith(
      percentage: null == percentage
          ? _value.percentage
          : percentage // ignore: cast_nullable_to_non_nullable
              as double,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ObservationStatusListModelImplCopyWith<$Res>
    implements $ObservationStatusListModelCopyWith<$Res> {
  factory _$$ObservationStatusListModelImplCopyWith(
          _$ObservationStatusListModelImpl value,
          $Res Function(_$ObservationStatusListModelImpl) then) =
      __$$ObservationStatusListModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double percentage, int count, String name});
}

/// @nodoc
class __$$ObservationStatusListModelImplCopyWithImpl<$Res>
    extends _$ObservationStatusListModelCopyWithImpl<$Res,
        _$ObservationStatusListModelImpl>
    implements _$$ObservationStatusListModelImplCopyWith<$Res> {
  __$$ObservationStatusListModelImplCopyWithImpl(
      _$ObservationStatusListModelImpl _value,
      $Res Function(_$ObservationStatusListModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? percentage = null,
    Object? count = null,
    Object? name = null,
  }) {
    return _then(_$ObservationStatusListModelImpl(
      percentage: null == percentage
          ? _value.percentage
          : percentage // ignore: cast_nullable_to_non_nullable
              as double,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ObservationStatusListModelImpl implements _ObservationStatusListModel {
  const _$ObservationStatusListModelImpl(
      {this.percentage = 0.0, this.count = 0, this.name = ""});

  factory _$ObservationStatusListModelImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$ObservationStatusListModelImplFromJson(json);

  @override
  @JsonKey()
  final double percentage;
  @override
  @JsonKey()
  final int count;
  @override
  @JsonKey()
  final String name;

  @override
  String toString() {
    return 'ObservationStatusListModel(percentage: $percentage, count: $count, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ObservationStatusListModelImpl &&
            (identical(other.percentage, percentage) ||
                other.percentage == percentage) &&
            (identical(other.count, count) || other.count == count) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, percentage, count, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ObservationStatusListModelImplCopyWith<_$ObservationStatusListModelImpl>
      get copyWith => __$$ObservationStatusListModelImplCopyWithImpl<
          _$ObservationStatusListModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ObservationStatusListModelImplToJson(
      this,
    );
  }
}

abstract class _ObservationStatusListModel
    implements ObservationStatusListModel {
  const factory _ObservationStatusListModel(
      {final double percentage,
      final int count,
      final String name}) = _$ObservationStatusListModelImpl;

  factory _ObservationStatusListModel.fromJson(Map<String, dynamic> json) =
      _$ObservationStatusListModelImpl.fromJson;

  @override
  double get percentage;
  @override
  int get count;
  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$$ObservationStatusListModelImplCopyWith<_$ObservationStatusListModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
