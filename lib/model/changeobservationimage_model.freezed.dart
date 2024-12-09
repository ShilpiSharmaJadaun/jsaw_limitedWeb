// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'changeobservationimage_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ChangeObservationImageModel _$ChangeObservationImageModelFromJson(
    Map<String, dynamic> json) {
  return _ChangeObservationImageModel.fromJson(json);
}

/// @nodoc
mixin _$ChangeObservationImageModel {
  String get status => throw _privateConstructorUsedError;
  String get msg => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChangeObservationImageModelCopyWith<ChangeObservationImageModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChangeObservationImageModelCopyWith<$Res> {
  factory $ChangeObservationImageModelCopyWith(
          ChangeObservationImageModel value,
          $Res Function(ChangeObservationImageModel) then) =
      _$ChangeObservationImageModelCopyWithImpl<$Res,
          ChangeObservationImageModel>;
  @useResult
  $Res call({String status, String msg, String url});
}

/// @nodoc
class _$ChangeObservationImageModelCopyWithImpl<$Res,
        $Val extends ChangeObservationImageModel>
    implements $ChangeObservationImageModelCopyWith<$Res> {
  _$ChangeObservationImageModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? msg = null,
    Object? url = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      msg: null == msg
          ? _value.msg
          : msg // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChangeObservationImageModelImplCopyWith<$Res>
    implements $ChangeObservationImageModelCopyWith<$Res> {
  factory _$$ChangeObservationImageModelImplCopyWith(
          _$ChangeObservationImageModelImpl value,
          $Res Function(_$ChangeObservationImageModelImpl) then) =
      __$$ChangeObservationImageModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String status, String msg, String url});
}

/// @nodoc
class __$$ChangeObservationImageModelImplCopyWithImpl<$Res>
    extends _$ChangeObservationImageModelCopyWithImpl<$Res,
        _$ChangeObservationImageModelImpl>
    implements _$$ChangeObservationImageModelImplCopyWith<$Res> {
  __$$ChangeObservationImageModelImplCopyWithImpl(
      _$ChangeObservationImageModelImpl _value,
      $Res Function(_$ChangeObservationImageModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? msg = null,
    Object? url = null,
  }) {
    return _then(_$ChangeObservationImageModelImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      msg: null == msg
          ? _value.msg
          : msg // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChangeObservationImageModelImpl
    implements _ChangeObservationImageModel {
  const _$ChangeObservationImageModelImpl(
      {this.status = "", this.msg = "", this.url = ""});

  factory _$ChangeObservationImageModelImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$ChangeObservationImageModelImplFromJson(json);

  @override
  @JsonKey()
  final String status;
  @override
  @JsonKey()
  final String msg;
  @override
  @JsonKey()
  final String url;

  @override
  String toString() {
    return 'ChangeObservationImageModel(status: $status, msg: $msg, url: $url)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChangeObservationImageModelImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.msg, msg) || other.msg == msg) &&
            (identical(other.url, url) || other.url == url));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, status, msg, url);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChangeObservationImageModelImplCopyWith<_$ChangeObservationImageModelImpl>
      get copyWith => __$$ChangeObservationImageModelImplCopyWithImpl<
          _$ChangeObservationImageModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChangeObservationImageModelImplToJson(
      this,
    );
  }
}

abstract class _ChangeObservationImageModel
    implements ChangeObservationImageModel {
  const factory _ChangeObservationImageModel(
      {final String status,
      final String msg,
      final String url}) = _$ChangeObservationImageModelImpl;

  factory _ChangeObservationImageModel.fromJson(Map<String, dynamic> json) =
      _$ChangeObservationImageModelImpl.fromJson;

  @override
  String get status;
  @override
  String get msg;
  @override
  String get url;
  @override
  @JsonKey(ignore: true)
  _$$ChangeObservationImageModelImplCopyWith<_$ChangeObservationImageModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
