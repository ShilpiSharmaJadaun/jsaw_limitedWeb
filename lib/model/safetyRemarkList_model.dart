import 'package:freezed_annotation/freezed_annotation.dart';

part 'safetyRemarkList_model.g.dart';
part 'safetyRemarkList_model.freezed.dart';

@freezed
class SafetyRemarkListModel with _$SafetyRemarkListModel{
  const factory SafetyRemarkListModel({

    @Default(0) int id,
    @Default(0) int incidentReportId,
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
    @JsonKey(fromJson: _restUptoFromJson) @Default(0) int restUpto,
    @Default("") String fitForDutyFrom,
    @Default("") String medicalOfficerRemarks,
    @Default("") String medicalOfficerName,
    @Default("") String medicalOfficerCode,
    @Default("") String raisedDate,
    @Default("") String lowQualityImageUrl,
    @Default("") String highQualityImageUrl,

  }) = _SafetyRemarkListModel;

  factory SafetyRemarkListModel.fromJson(Map<String, dynamic> json) => _$SafetyRemarkListModelFromJson(json);
}

int _restUptoFromJson(dynamic value) {
  if (value is num) return value.toInt();
  if (value is String) return int.tryParse(value) ?? 0;
  return 0;
}