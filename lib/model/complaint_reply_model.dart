import 'package:freezed_annotation/freezed_annotation.dart';

part 'complaint_reply_model.g.dart';
part 'complaint_reply_model.freezed.dart';

@freezed
class ComplaintReplyModel with _$ComplaintReplyModel {
  const factory ComplaintReplyModel({
    @Default(0) int id,
    @Default(0) int complaintId,
    @Default('') String senderType,
    @Default('') String senderName,
    @Default('') String message,
    @Default('') String attachment,
    @Default('') String createdAt,
  }) = _ComplaintReplyModel;

  factory ComplaintReplyModel.fromJson(Map<String, dynamic> json) =>
      _$ComplaintReplyModelFromJson(json);
}
