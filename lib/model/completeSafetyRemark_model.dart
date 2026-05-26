import 'package:freezed_annotation/freezed_annotation.dart';

part 'completeSafetyRemark_model.g.dart';
part 'completeSafetyRemark_model.freezed.dart';

@freezed
class CompleteSafetyRemarkModel with _$CompleteSafetyRemarkModel{
  const factory CompleteSafetyRemarkModel({
    @Default(0) int  id,
    @Default(0) int  incidentReportId,
    @Default("") String incidentUniqueId,
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
    @Default("") String typeOfInjury,
    @Default("") String bodyPart,
    @Default("") String natureOfInjury,
    @Default("") String restUpto,
    @Default("") String fitForDutyFrom,
    @Default("") String medicalOfficerRemarks,
    @Default("") String safetyRemarks,
    @Default("") String raisedDate,
    @Default("") String lowQualityImageUrl,
    @Default("") String highQualityImageUrl,

  }) = _CompleteSafetyRemarkModel;

  factory CompleteSafetyRemarkModel.fromJson(Map<String, dynamic> json) => _$CompleteSafetyRemarkModelFromJson(json);
}