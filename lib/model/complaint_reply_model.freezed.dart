// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'complaint_reply_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ComplaintReplyModel _$ComplaintReplyModelFromJson(Map<String, dynamic> json) {
  return _ComplaintReplyModel.fromJson(json);
}

/// @nodoc
mixin _$ComplaintReplyModel {
  int get id => throw _privateConstructorUsedError;
  int get complaintId => throw _privateConstructorUsedError;
  String get senderType => throw _privateConstructorUsedError;
  String get senderName => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  String get attachment => throw _privateConstructorUsedError;
  String get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ComplaintReplyModelCopyWith<ComplaintReplyModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ComplaintReplyModelCopyWith<$Res> {
  factory $ComplaintReplyModelCopyWith(
          ComplaintReplyModel value, $Res Function(ComplaintReplyModel) then) =
      _$ComplaintReplyModelCopyWithImpl<$Res, ComplaintReplyModel>;
  @useResult
  $Res call(
      {int id,
      int complaintId,
      String senderType,
      String senderName,
      String message,
      String attachment,
      String createdAt});
}

/// @nodoc
class _$ComplaintReplyModelCopyWithImpl<$Res, $Val extends ComplaintReplyModel>
    implements $ComplaintReplyModelCopyWith<$Res> {
  _$ComplaintReplyModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? complaintId = null,
    Object? senderType = null,
    Object? senderName = null,
    Object? message = null,
    Object? attachment = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      complaintId: null == complaintId
          ? _value.complaintId
          : complaintId // ignore: cast_nullable_to_non_nullable
              as int,
      senderType: null == senderType
          ? _value.senderType
          : senderType // ignore: cast_nullable_to_non_nullable
              as String,
      senderName: null == senderName
          ? _value.senderName
          : senderName // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      attachment: null == attachment
          ? _value.attachment
          : attachment // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ComplaintReplyModelImplCopyWith<$Res>
    implements $ComplaintReplyModelCopyWith<$Res> {
  factory _$$ComplaintReplyModelImplCopyWith(_$ComplaintReplyModelImpl value,
          $Res Function(_$ComplaintReplyModelImpl) then) =
      __$$ComplaintReplyModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      int complaintId,
      String senderType,
      String senderName,
      String message,
      String attachment,
      String createdAt});
}

/// @nodoc
class __$$ComplaintReplyModelImplCopyWithImpl<$Res>
    extends _$ComplaintReplyModelCopyWithImpl<$Res, _$ComplaintReplyModelImpl>
    implements _$$ComplaintReplyModelImplCopyWith<$Res> {
  __$$ComplaintReplyModelImplCopyWithImpl(_$ComplaintReplyModelImpl _value,
      $Res Function(_$ComplaintReplyModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? complaintId = null,
    Object? senderType = null,
    Object? senderName = null,
    Object? message = null,
    Object? attachment = null,
    Object? createdAt = null,
  }) {
    return _then(_$ComplaintReplyModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      complaintId: null == complaintId
          ? _value.complaintId
          : complaintId // ignore: cast_nullable_to_non_nullable
              as int,
      senderType: null == senderType
          ? _value.senderType
          : senderType // ignore: cast_nullable_to_non_nullable
              as String,
      senderName: null == senderName
          ? _value.senderName
          : senderName // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      attachment: null == attachment
          ? _value.attachment
          : attachment // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ComplaintReplyModelImpl implements _ComplaintReplyModel {
  const _$ComplaintReplyModelImpl(
      {this.id = 0,
      this.complaintId = 0,
      this.senderType = '',
      this.senderName = '',
      this.message = '',
      this.attachment = '',
      this.createdAt = ''});

  factory _$ComplaintReplyModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ComplaintReplyModelImplFromJson(json);

  @override
  @JsonKey()
  final int id;
  @override
  @JsonKey()
  final int complaintId;
  @override
  @JsonKey()
  final String senderType;
  @override
  @JsonKey()
  final String senderName;
  @override
  @JsonKey()
  final String message;
  @override
  @JsonKey()
  final String attachment;
  @override
  @JsonKey()
  final String createdAt;

  @override
  String toString() {
    return 'ComplaintReplyModel(id: $id, complaintId: $complaintId, senderType: $senderType, senderName: $senderName, message: $message, attachment: $attachment, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ComplaintReplyModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.complaintId, complaintId) ||
                other.complaintId == complaintId) &&
            (identical(other.senderType, senderType) ||
                other.senderType == senderType) &&
            (identical(other.senderName, senderName) ||
                other.senderName == senderName) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.attachment, attachment) ||
                other.attachment == attachment) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, complaintId, senderType,
      senderName, message, attachment, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ComplaintReplyModelImplCopyWith<_$ComplaintReplyModelImpl> get copyWith =>
      __$$ComplaintReplyModelImplCopyWithImpl<_$ComplaintReplyModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ComplaintReplyModelImplToJson(
      this,
    );
  }
}

abstract class _ComplaintReplyModel implements ComplaintReplyModel {
  const factory _ComplaintReplyModel(
      {final int id,
      final int complaintId,
      final String senderType,
      final String senderName,
      final String message,
      final String attachment,
      final String createdAt}) = _$ComplaintReplyModelImpl;

  factory _ComplaintReplyModel.fromJson(Map<String, dynamic> json) =
      _$ComplaintReplyModelImpl.fromJson;

  @override
  int get id;
  @override
  int get complaintId;
  @override
  String get senderType;
  @override
  String get senderName;
  @override
  String get message;
  @override
  String get attachment;
  @override
  String get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$ComplaintReplyModelImplCopyWith<_$ComplaintReplyModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
