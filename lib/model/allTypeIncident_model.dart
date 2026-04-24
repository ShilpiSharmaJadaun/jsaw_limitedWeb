import 'package:freezed_annotation/freezed_annotation.dart';

part 'allTypeIncident_model.g.dart';
part 'allTypeIncident_model.freezed.dart';

@freezed
class AllTypeIncidentModel with _$AllTypeIncidentModel{
  const factory AllTypeIncidentModel({

    @Default(0) int id,
    @Default("") String description,

  }) = _AllTypeIncidentModel;

  factory AllTypeIncidentModel.fromJson(Map<String, dynamic> json) => _$AllTypeIncidentModelFromJson(json);
}