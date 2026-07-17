import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jsaw_limited/model/complaint_reply_model.dart';

part 'raised_feedback_model.g.dart';
part 'raised_feedback_model.freezed.dart';

@freezed
class SuggestionFeedbackModel with _$SuggestionFeedbackModel{
  const factory SuggestionFeedbackModel({

    @Default(0) int id,
    @Default("") String issueTitle,
    @Default("") String issueDescription,
    @Default("") String dateTimeOfOccurrence,
    @Default("") String softwareVersion,
    @Default("") String operatingSystem,
    @Default("") String severity,
    @Default("") String attachments,
    @Default("") String empUnId,
    @Default("") String empName,
    @Default("") String ticketRaisedDate,
    @Default("") String closingTicketDate,
    @Default("") String status,
    @Default("") String statusColor,
    @Default("") String lowQualityImageUrl,
    @Default("") String highQualityImageUrl,
    @Default("") String solutionRemark,
    @Default("") String complaintNumber,
    @Default([]) List<ComplaintReplyModel> replies,
  }) = _SuggestionFeedbackModel;

  factory SuggestionFeedbackModel.fromJson(Map<String, dynamic> json) => _$SuggestionFeedbackModelFromJson(json);
}