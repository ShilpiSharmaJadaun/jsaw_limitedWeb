import 'package:freezed_annotation/freezed_annotation.dart';

part 'allIncident_model.g.dart';
part 'allIncident_model.freezed.dart';

@freezed
class AllIncidentModel with _$AllIncidentModel{
  const factory AllIncidentModel({

    @Default(0) int id,
    @Default("") String uniqueId,
    @Default("") String incidentDateTime,
    @Default("") String shift,
    @Default("") String employeeCode,
    @Default("") String employeeName,
    @Default(0) int age,
    @Default("") String contractorName,
    @Default("") String contCode,
    @Default("") String plant,
    @Default("") String plantCode,
    @Default("") String deptName,
    @Default("") String deptCode,
    @Default("") String location,
    @Default("") String responsibleShiftEngg,
    @Default("") String responsibleHod,
    @Default("") String contactNumber,
    @Default("") String incidentType,
    @Default("") String workInjury,
    @Default("") String descpOfIncident,
    @Default("") String firDateTime,
    @Default("") String imageUrl,
    @Default("") String raisedDate,
    @Default("") String updatedDate,
    @Default("") String medicalOfficerTypeOfInjury,
    @Default("") String bodyPart,
    @Default("") String natureOfInjury,
    @Default("") String restUpto,
    @Default("") String fitForDutyFrom,
    @Default("") String medicalOfficerRemarks,
    @Default("") String medicalOfficerResponseDate,
    @Default("") String medicalOfficerUpdatedDate,
    @Default("") String safetyTypeOfInjury,
    @Default("") String safetyRemarks,
    @Default("") String safetyResponseDate,
    @Default("") String safetyUpdatedDate,
    @Default("") String lowQualityImageUrl,
    @Default("") String highQualityImageUrl,


  }) = _AllIncidentModel;

  factory AllIncidentModel.fromJson(Map<String, dynamic> json) => _$AllIncidentModelFromJson(json);
}