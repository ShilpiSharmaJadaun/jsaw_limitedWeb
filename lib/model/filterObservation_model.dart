import 'package:freezed_annotation/freezed_annotation.dart';

part 'filterObservation_model.g.dart';
part 'filterObservation_model.freezed.dart';

@freezed
class FilterObservationModel with _$FilterObservationModel{
  const factory FilterObservationModel({

    @Default("") String uniqueIdentificationNumber,
    @Default(0) int id,
    @Default("") String observationRaisedBy,
    @Default("") String observationRaisedByEmpUnqId,
    @Default("") String plantDept,
    @Default("") String plantDeptCode,
    @Default("") String location,
    @Default("") String observationText,
    @Default("") String imageNumber,
    @Default("") String actionTaken,
    @Default("") String responsibility,
    @Default("") String responsibilityEnggCode,
    @Default("") String status,
    @Default("") String hazardCategory,
    @Default("") String remarks,
    @Default("") String imageCompliance,
    @Default("") String priorityStatusName,
    @Default("") String priorityStatusColour,
    @Default("") String raisedDate,
    @Default("") String stationCode,
    @Default("") String stationName,
    @Default("") String responsibilityHODName,
    @Default("") String responsibilityHODEmpUnqID,
    @Default("") String wrkGrp,
    @Default("") String updatedByEmpId,
    @Default("") String updatedByEmpName,
    @Default("") String categoryName,
    @Default("") String correctiveMeasure,
    @Default("") String updatedDate,
    @Default("") String count,
    @Default("") String fileURL,
    @Default("") String lowQualityImageUrl,
    @Default("") String highQualityImageUrl,
    @Default("") String reminderSentDate,
    @Default("") String escalationSentDate,
    @Default("") String complianceDate,
    @Default("") String observationCompletionTargetDate,


  }) = _FilterObservationModel;

  factory FilterObservationModel.fromJson(Map<String, dynamic> json) => _$FilterObservationModelFromJson(json);
}