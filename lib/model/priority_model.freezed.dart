// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'priority_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PriorityModel _$PriorityModelFromJson(Map<String, dynamic> json) {
  return _PriorityModel.fromJson(json);
}

/// @nodoc
mixin _$PriorityModel {
  int get id => throw _privateConstructorUsedError;
  String get priorityStatusName => throw _privateConstructorUsedError;
  String get priorityStatusColour => throw _privateConstructorUsedError;
  String get priorityStatusDeadline => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PriorityModelCopyWith<PriorityModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PriorityModelCopyWith<$Res> {
  factory $PriorityModelCopyWith(
          PriorityModel value, $Res Function(PriorityModel) then) =
      _$PriorityModelCopyWithImpl<$Res, PriorityModel>;
  @useResult
  $Res call(
      {int id,
      String priorityStatusName,
      String priorityStatusColour,
      String priorityStatusDeadline});
}

/// @nodoc
class _$PriorityModelCopyWithImpl<$Res, $Val extends PriorityModel>
    implements $PriorityModelCopyWith<$Res> {
  _$PriorityModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? priorityStatusName = null,
    Object? priorityStatusColour = null,
    Object? priorityStatusDeadline = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      priorityStatusName: null == priorityStatusName
          ? _value.priorityStatusName
          : priorityStatusName // ignore: cast_nullable_to_non_nullable
              as String,
      priorityStatusColour: null == priorityStatusColour
          ? _value.priorityStatusColour
          : priorityStatusColour // ignore: cast_nullable_to_non_nullable
              as String,
      priorityStatusDeadline: null == priorityStatusDeadline
          ? _value.priorityStatusDeadline
          : priorityStatusDeadline // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PriorityModelImplCopyWith<$Res>
    implements $PriorityModelCopyWith<$Res> {
  factory _$$PriorityModelImplCopyWith(
          _$PriorityModelImpl value, $Res Function(_$PriorityModelImpl) then) =
      __$$PriorityModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String priorityStatusName,
      String priorityStatusColour,
      String priorityStatusDeadline});
}

/// @nodoc
class __$$PriorityModelImplCopyWithImpl<$Res>
    extends _$PriorityModelCopyWithImpl<$Res, _$PriorityModelImpl>
    implements _$$PriorityModelImplCopyWith<$Res> {
  __$$PriorityModelImplCopyWithImpl(
      _$PriorityModelImpl _value, $Res Function(_$PriorityModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? priorityStatusName = null,
    Object? priorityStatusColour = null,
    Object? priorityStatusDeadline = null,
  }) {
    return _then(_$PriorityModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      priorityStatusName: null == priorityStatusName
          ? _value.priorityStatusName
          : priorityStatusName // ignore: cast_nullable_to_non_nullable
              as String,
      priorityStatusColour: null == priorityStatusColour
          ? _value.priorityStatusColour
          : priorityStatusColour // ignore: cast_nullable_to_non_nullable
              as String,
      priorityStatusDeadline: null == priorityStatusDeadline
          ? _value.priorityStatusDeadline
          : priorityStatusDeadline // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PriorityModelImpl implements _PriorityModel {
  const _$PriorityModelImpl(
      {this.id = 0,
      this.priorityStatusName = "",
      this.priorityStatusColour = "",
      this.priorityStatusDeadline = ""});

  factory _$PriorityModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PriorityModelImplFromJson(json);

  @override
  @JsonKey()
  final int id;
  @override
  @JsonKey()
  final String priorityStatusName;
  @override
  @JsonKey()
  final String priorityStatusColour;
  @override
  @JsonKey()
  final String priorityStatusDeadline;

  @override
  String toString() {
    return 'PriorityModel(id: $id, priorityStatusName: $priorityStatusName, priorityStatusColour: $priorityStatusColour, priorityStatusDeadline: $priorityStatusDeadline)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PriorityModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.priorityStatusName, priorityStatusName) ||
                other.priorityStatusName == priorityStatusName) &&
            (identical(other.priorityStatusColour, priorityStatusColour) ||
                other.priorityStatusColour == priorityStatusColour) &&
            (identical(other.priorityStatusDeadline, priorityStatusDeadline) ||
                other.priorityStatusDeadline == priorityStatusDeadline));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, priorityStatusName,
      priorityStatusColour, priorityStatusDeadline);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PriorityModelImplCopyWith<_$PriorityModelImpl> get copyWith =>
      __$$PriorityModelImplCopyWithImpl<_$PriorityModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PriorityModelImplToJson(
      this,
    );
  }
}

abstract class _PriorityModel implements PriorityModel {
  const factory _PriorityModel(
      {final int id,
      final String priorityStatusName,
      final String priorityStatusColour,
      final String priorityStatusDeadline}) = _$PriorityModelImpl;

  factory _PriorityModel.fromJson(Map<String, dynamic> json) =
      _$PriorityModelImpl.fromJson;

  @override
  int get id;
  @override
  String get priorityStatusName;
  @override
  String get priorityStatusColour;
  @override
  String get priorityStatusDeadline;
  @override
  @JsonKey(ignore: true)
  _$$PriorityModelImplCopyWith<_$PriorityModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
