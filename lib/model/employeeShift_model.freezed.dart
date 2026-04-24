// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'employeeShift_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

EmployeeShiftModel _$EmployeeShiftModelFromJson(Map<String, dynamic> json) {
  return _EmployeeShiftModel.fromJson(json);
}

/// @nodoc
mixin _$EmployeeShiftModel {
  String get shiftCode => throw _privateConstructorUsedError;
  int get shiftSeq => throw _privateConstructorUsedError;
  String get shiftDesc => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EmployeeShiftModelCopyWith<EmployeeShiftModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmployeeShiftModelCopyWith<$Res> {
  factory $EmployeeShiftModelCopyWith(
          EmployeeShiftModel value, $Res Function(EmployeeShiftModel) then) =
      _$EmployeeShiftModelCopyWithImpl<$Res, EmployeeShiftModel>;
  @useResult
  $Res call({String shiftCode, int shiftSeq, String shiftDesc});
}

/// @nodoc
class _$EmployeeShiftModelCopyWithImpl<$Res, $Val extends EmployeeShiftModel>
    implements $EmployeeShiftModelCopyWith<$Res> {
  _$EmployeeShiftModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? shiftCode = null,
    Object? shiftSeq = null,
    Object? shiftDesc = null,
  }) {
    return _then(_value.copyWith(
      shiftCode: null == shiftCode
          ? _value.shiftCode
          : shiftCode // ignore: cast_nullable_to_non_nullable
              as String,
      shiftSeq: null == shiftSeq
          ? _value.shiftSeq
          : shiftSeq // ignore: cast_nullable_to_non_nullable
              as int,
      shiftDesc: null == shiftDesc
          ? _value.shiftDesc
          : shiftDesc // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EmployeeShiftModelImplCopyWith<$Res>
    implements $EmployeeShiftModelCopyWith<$Res> {
  factory _$$EmployeeShiftModelImplCopyWith(_$EmployeeShiftModelImpl value,
          $Res Function(_$EmployeeShiftModelImpl) then) =
      __$$EmployeeShiftModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String shiftCode, int shiftSeq, String shiftDesc});
}

/// @nodoc
class __$$EmployeeShiftModelImplCopyWithImpl<$Res>
    extends _$EmployeeShiftModelCopyWithImpl<$Res, _$EmployeeShiftModelImpl>
    implements _$$EmployeeShiftModelImplCopyWith<$Res> {
  __$$EmployeeShiftModelImplCopyWithImpl(_$EmployeeShiftModelImpl _value,
      $Res Function(_$EmployeeShiftModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? shiftCode = null,
    Object? shiftSeq = null,
    Object? shiftDesc = null,
  }) {
    return _then(_$EmployeeShiftModelImpl(
      shiftCode: null == shiftCode
          ? _value.shiftCode
          : shiftCode // ignore: cast_nullable_to_non_nullable
              as String,
      shiftSeq: null == shiftSeq
          ? _value.shiftSeq
          : shiftSeq // ignore: cast_nullable_to_non_nullable
              as int,
      shiftDesc: null == shiftDesc
          ? _value.shiftDesc
          : shiftDesc // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EmployeeShiftModelImpl implements _EmployeeShiftModel {
  const _$EmployeeShiftModelImpl(
      {this.shiftCode = "", this.shiftSeq = 0, this.shiftDesc = ""});

  factory _$EmployeeShiftModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$EmployeeShiftModelImplFromJson(json);

  @override
  @JsonKey()
  final String shiftCode;
  @override
  @JsonKey()
  final int shiftSeq;
  @override
  @JsonKey()
  final String shiftDesc;

  @override
  String toString() {
    return 'EmployeeShiftModel(shiftCode: $shiftCode, shiftSeq: $shiftSeq, shiftDesc: $shiftDesc)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmployeeShiftModelImpl &&
            (identical(other.shiftCode, shiftCode) ||
                other.shiftCode == shiftCode) &&
            (identical(other.shiftSeq, shiftSeq) ||
                other.shiftSeq == shiftSeq) &&
            (identical(other.shiftDesc, shiftDesc) ||
                other.shiftDesc == shiftDesc));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, shiftCode, shiftSeq, shiftDesc);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EmployeeShiftModelImplCopyWith<_$EmployeeShiftModelImpl> get copyWith =>
      __$$EmployeeShiftModelImplCopyWithImpl<_$EmployeeShiftModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EmployeeShiftModelImplToJson(
      this,
    );
  }
}

abstract class _EmployeeShiftModel implements EmployeeShiftModel {
  const factory _EmployeeShiftModel(
      {final String shiftCode,
      final int shiftSeq,
      final String shiftDesc}) = _$EmployeeShiftModelImpl;

  factory _EmployeeShiftModel.fromJson(Map<String, dynamic> json) =
      _$EmployeeShiftModelImpl.fromJson;

  @override
  String get shiftCode;
  @override
  int get shiftSeq;
  @override
  String get shiftDesc;
  @override
  @JsonKey(ignore: true)
  _$$EmployeeShiftModelImplCopyWith<_$EmployeeShiftModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
