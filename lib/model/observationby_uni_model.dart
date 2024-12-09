import 'package:freezed_annotation/freezed_annotation.dart';

part 'observationby_uni_model.g.dart';
part 'observationby_uni_model.freezed.dart';

@freezed
class ObservationbyUniModel with _$ObservationbyUniModel{
  const factory ObservationbyUniModel({

    @Default(0) int id,
    @Default("") String uniqueIdentificationNumber,
    @Default("") String observationText,
    @Default("") String actionTaken,
    @Default("") String status,
    @Default("") String remarks,
    @Default("") String imageCompliance,
    @Default("") String updatedDate,
    @Default("") String updatedByEmpId,
    @Default("") String updatedByEmpName,

  }) = _ObservationbyUniModel;

  factory ObservationbyUniModel.fromJson(Map<String, dynamic> json) => _$ObservationbyUniModelFromJson(json);
}