import 'package:freezed_annotation/freezed_annotation.dart';

part 'deleteObservation_model.g.dart';
part 'deleteObservation_model.freezed.dart';

@freezed
class DeleteObservationModel with _$DeleteObservationModel{
  const factory DeleteObservationModel({
    @Default("") String status,
    @Default("") String msg,
    @Default(0) int model,
  }) = _DeleteObservationModel;

  factory DeleteObservationModel.fromJson(Map<String, dynamic> json) => _$DeleteObservationModelFromJson(json);
}