// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'allwork_group_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AllWorkGroupModel _$AllWorkGroupModelFromJson(Map<String, dynamic> json) {
  return _AllWorkGroupModel.fromJson(json);
}

/// @nodoc
mixin _$AllWorkGroupModel {
  String get wrkGrp => throw _privateConstructorUsedError;
  String get wrkGrpDesc => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AllWorkGroupModelCopyWith<AllWorkGroupModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AllWorkGroupModelCopyWith<$Res> {
  factory $AllWorkGroupModelCopyWith(
          AllWorkGroupModel value, $Res Function(AllWorkGroupModel) then) =
      _$AllWorkGroupModelCopyWithImpl<$Res, AllWorkGroupModel>;
  @useResult
  $Res call({String wrkGrp, String wrkGrpDesc});
}

/// @nodoc
class _$AllWorkGroupModelCopyWithImpl<$Res, $Val extends AllWorkGroupModel>
    implements $AllWorkGroupModelCopyWith<$Res> {
  _$AllWorkGroupModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? wrkGrp = null,
    Object? wrkGrpDesc = null,
  }) {
    return _then(_value.copyWith(
      wrkGrp: null == wrkGrp
          ? _value.wrkGrp
          : wrkGrp // ignore: cast_nullable_to_non_nullable
              as String,
      wrkGrpDesc: null == wrkGrpDesc
          ? _value.wrkGrpDesc
          : wrkGrpDesc // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AllWorkGroupModelImplCopyWith<$Res>
    implements $AllWorkGroupModelCopyWith<$Res> {
  factory _$$AllWorkGroupModelImplCopyWith(_$AllWorkGroupModelImpl value,
          $Res Function(_$AllWorkGroupModelImpl) then) =
      __$$AllWorkGroupModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String wrkGrp, String wrkGrpDesc});
}

/// @nodoc
class __$$AllWorkGroupModelImplCopyWithImpl<$Res>
    extends _$AllWorkGroupModelCopyWithImpl<$Res, _$AllWorkGroupModelImpl>
    implements _$$AllWorkGroupModelImplCopyWith<$Res> {
  __$$AllWorkGroupModelImplCopyWithImpl(_$AllWorkGroupModelImpl _value,
      $Res Function(_$AllWorkGroupModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? wrkGrp = null,
    Object? wrkGrpDesc = null,
  }) {
    return _then(_$AllWorkGroupModelImpl(
      wrkGrp: null == wrkGrp
          ? _value.wrkGrp
          : wrkGrp // ignore: cast_nullable_to_non_nullable
              as String,
      wrkGrpDesc: null == wrkGrpDesc
          ? _value.wrkGrpDesc
          : wrkGrpDesc // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AllWorkGroupModelImpl implements _AllWorkGroupModel {
  const _$AllWorkGroupModelImpl({this.wrkGrp = "", this.wrkGrpDesc = ""});

  factory _$AllWorkGroupModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AllWorkGroupModelImplFromJson(json);

  @override
  @JsonKey()
  final String wrkGrp;
  @override
  @JsonKey()
  final String wrkGrpDesc;

  @override
  String toString() {
    return 'AllWorkGroupModel(wrkGrp: $wrkGrp, wrkGrpDesc: $wrkGrpDesc)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AllWorkGroupModelImpl &&
            (identical(other.wrkGrp, wrkGrp) || other.wrkGrp == wrkGrp) &&
            (identical(other.wrkGrpDesc, wrkGrpDesc) ||
                other.wrkGrpDesc == wrkGrpDesc));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, wrkGrp, wrkGrpDesc);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AllWorkGroupModelImplCopyWith<_$AllWorkGroupModelImpl> get copyWith =>
      __$$AllWorkGroupModelImplCopyWithImpl<_$AllWorkGroupModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AllWorkGroupModelImplToJson(
      this,
    );
  }
}

abstract class _AllWorkGroupModel implements AllWorkGroupModel {
  const factory _AllWorkGroupModel(
      {final String wrkGrp, final String wrkGrpDesc}) = _$AllWorkGroupModelImpl;

  factory _AllWorkGroupModel.fromJson(Map<String, dynamic> json) =
      _$AllWorkGroupModelImpl.fromJson;

  @override
  String get wrkGrp;
  @override
  String get wrkGrpDesc;
  @override
  @JsonKey(ignore: true)
  _$$AllWorkGroupModelImplCopyWith<_$AllWorkGroupModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
