import 'package:freezed_annotation/freezed_annotation.dart';

part 'allIncidentList_model.g.dart';
part 'allIncidentList_model.freezed.dart';

@freezed
class AllIncidentListModel with _$AllIncidentListModel{
  const factory AllIncidentListModel({

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


  }) = _AllIncidentListModel;

  factory AllIncidentListModel.fromJson(Map<String, dynamic> json) => _$AllIncidentListModelFromJson(json);
}