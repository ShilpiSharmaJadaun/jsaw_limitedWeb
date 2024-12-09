import 'package:freezed_annotation/freezed_annotation.dart';

part 'location_model.g.dart';
part 'location_model.freezed.dart';

@freezed
class LocationModel with _$LocationModel{
  const factory LocationModel({

    @Default(0) int id,
    @Default("") String deptCode,
    @Default("") String deptName_Plant,
    @Default("") String locations,

  }) = _LocationModel;

  factory LocationModel.fromJson(Map<String, dynamic> json) => _$LocationModelFromJson(json);
}