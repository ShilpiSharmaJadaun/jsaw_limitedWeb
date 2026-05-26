import 'package:freezed_annotation/freezed_annotation.dart';

part 'allobservation_model.g.dart';
part 'allobservation_model.freezed.dart';

@freezed
class AllObservationModel with _$AllObservationModel{
  const factory AllObservationModel({

    @Default("") String observationRaisedBy,
    @Default("") String uniqueIdentificationNumber,
    @Default("") String observationRaisedByEmpUnqId,
    @Default("") String plantDept,
    @Default("") String location,
    @Default("") String observationText,
    @Default("") String imageNumber,
    @Default("") String category,
    @Default("") String actionTaken,
    @Default("") String responsibility,
    @Default("") String status,
    @Default("") String hazardCategory,
    @Default("") String department,
    @Default("") String deptCode,
    @Default("") String remarks,
    @Default("") String priorityStatusName,
    @Default("") String priorityStatusColour,
    @Default("") String raisedDate,
    @Default("") String responsibilityHODName,
    @Default("") String responsibilityHODEmpUnqID,
    @Default("") String wrkGrp,
    @Default("") String fileURL,
    @Default("") String stationName,
    @Default("") String station_Code,
    @Default("") String lowQualityImageUrl,
    @Default("") String highQualityImageUrl,


  }) = _AllObservationModel;

  factory AllObservationModel.fromJson(Map<String, dynamic> json) => _$AllObservationModelFromJson(json);
}