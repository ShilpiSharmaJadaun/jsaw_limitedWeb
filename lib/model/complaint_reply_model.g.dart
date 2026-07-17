// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'complaint_reply_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ComplaintReplyModelImpl _$$ComplaintReplyModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ComplaintReplyModelImpl(
      id: (json['id'] as num?)?.toInt() ?? 0,
      complaintId: (json['complaintId'] as num?)?.toInt() ?? 0,
      senderType: json['senderType'] as String? ?? '',
      senderName: json['senderName'] as String? ?? '',
      message: json['message'] as String? ?? '',
      attachment: json['attachment'] as String? ?? '',
      createdAt: json['createdAt'] as String? ?? '',
    );

Map<String, dynamic> _$$ComplaintReplyModelImplToJson(
        _$ComplaintReplyModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'complaintId': instance.complaintId,
      'senderType': instance.senderType,
      'senderName': instance.senderName,
      'message': instance.message,
      'attachment': instance.attachment,
      'createdAt': instance.createdAt,
    };
