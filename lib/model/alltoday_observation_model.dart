import 'package:freezed_annotation/freezed_annotation.dart';

part 'alltoday_observation_model.g.dart';
part 'alltoday_observation_model.freezed.dart';

@freezed
class AllTodayObservationModel with _$AllTodayObservationModel{
  const factory AllTodayObservationModel({

    @Default(0) int id,
    @Default("") String observationRaisedBy,
    @Default("") String observationRaisedByEmpUnqId,
    @Default("") String uniqueIdentificationNumber,
    @Default("") String plantDept,
    @Default("") String plantDeptCode,
    @Default("") String location,
    @Default("") String observationText,
    @Default("") String imageNumber,
    @Default("") String actionTaken,
    @Default("") String responsibility,
    @Default("") String status,
    @Default("") String hazardCategory,
    @Default("") String stationName,
    @Default("") String remarks,
    @Default("") String imageCompliance,
    @Default("") String priorityStatusName,
    @Default("") String priorityStatusColour,
    @Default("") String raisedDate,
    @Default("") String responsibilityHODName,
    @Default("") String responsibilityHODEmpUnqID,
    @Default("") String stationCode,
    @Default("") String lowQualityImageUrl,
    @Default("") String highQualityImageUrl,

  }) = _AllTodayObservationModel;

  factory AllTodayObservationModel.fromJson(Map<String, dynamic> json) => _$AllTodayObservationModelFromJson(json);
}