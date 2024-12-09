import 'package:freezed_annotation/freezed_annotation.dart';

part 'save_observation_model.g.dart';
part 'save_observation_model.freezed.dart';

@freezed
class SaveObservationModel with _$SaveObservationModel{
  const factory SaveObservationModel({

    @Default("") String timestamp,
    @Default("") String status,
    @Default("") String error,
    @Default("") String path,

  }) = _SaveObservationModel;

  factory SaveObservationModel.fromJson(Map<String, dynamic> json) => _$SaveObservationModelFromJson(json);
}