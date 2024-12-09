import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_observation_model.g.dart';
part 'update_observation_model.freezed.dart';

@freezed
class UpdateObservationModel with _$UpdateObservationModel{
  const factory UpdateObservationModel({
    @Default("") String status,
    @Default("") String message,
  }) = _UpdateObservationModel;

  factory UpdateObservationModel.fromJson(Map<String, dynamic> json) => _$UpdateObservationModelFromJson(json);
}