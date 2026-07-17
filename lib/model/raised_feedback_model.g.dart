// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'raised_feedback_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SuggestionFeedbackModelImpl _$$SuggestionFeedbackModelImplFromJson(
        Map<String, dynamic> json) =>
    _$SuggestionFeedbackModelImpl(
      id: (json['id'] as num?)?.toInt() ?? 0,
      issueTitle: json['issueTitle'] as String? ?? "",
      issueDescription: json['issueDescription'] as String? ?? "",
      dateTimeOfOccurrence: json['dateTimeOfOccurrence'] as String? ?? "",
      softwareVersion: json['softwareVersion'] as String? ?? "",
      operatingSystem: json['operatingSystem'] as String? ?? "",
      severity: json['severity'] as String? ?? "",
      attachments: json['attachments'] as String? ?? "",
      empUnId: json['empUnId'] as String? ?? "",
      empName: json['empName'] as String? ?? "",
      ticketRaisedDate: json['ticketRaisedDate'] as String? ?? "",
      closingTicketDate: json['closingTicketDate'] as String? ?? "",
      status: json['status'] as String? ?? "",
      statusColor: json['statusColor'] as String? ?? "",
      lowQualityImageUrl: json['lowQualityImageUrl'] as String? ?? "",
      highQualityImageUrl: json['highQualityImageUrl'] as String? ?? "",
      solutionRemark: json['solutionRemark'] as String? ?? "",
      complaintNumber: json['complaintNumber'] as String? ?? "",
      replies: (json['replies'] as List<dynamic>?)
              ?.map((e) =>
                  ComplaintReplyModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$SuggestionFeedbackModelImplToJson(
        _$SuggestionFeedbackModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'issueTitle': instance.issueTitle,
      'issueDescription': instance.issueDescription,
      'dateTimeOfOccurrence': instance.dateTimeOfOccurrence,
      'softwareVersion': instance.softwareVersion,
      'operatingSystem': instance.operatingSystem,
      'severity': instance.severity,
      'attachments': instance.attachments,
      'empUnId': instance.empUnId,
      'empName': instance.empName,
      'ticketRaisedDate': instance.ticketRaisedDate,
      'closingTicketDate': instance.closingTicketDate,
      'status': instance.status,
      'statusColor': instance.statusColor,
      'lowQualityImageUrl': instance.lowQualityImageUrl,
      'highQualityImageUrl': instance.highQualityImageUrl,
      'solutionRemark': instance.solutionRemark,
      'complaintNumber': instance.complaintNumber,
      'replies': instance.replies,
    };
