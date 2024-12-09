import 'package:freezed_annotation/freezed_annotation.dart';

part 'raisedObservation_model.g.dart';
part 'raisedObservation_model.freezed.dart';

@freezed
class RaisedObservationModel with _$RaisedObservationModel{
  const factory RaisedObservationModel({

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
    @Default("") String responsibilityEnggCode,
    @Default("") String status,
    @Default("") String hazardCategory,
    @Default("") String remarks,
    @Default("") String imageCompliance,
    @Default("") String priorityStatusName,
    @Default("") String priorityStatusColour,
    @Default("") String raisedDate,
    @Default("") String responsibilityHODName,
    @Default("") String responsibilityHODEmpUnqID,
    @Default("") String wrkGrp,
    @Default("") String updatedByEmpId,
    @Default("") String updatedByEmpName,
    @Default("") String categoryName,
    @Default("") String correctiveMeasure,
    @Default("") String stationName,
    @Default("") String stationCode,

  }) = _RaisedObservationModel;

  factory RaisedObservationModel.fromJson(Map<String, dynamic> json) => _$RaisedObservationModelFromJson(json);
}