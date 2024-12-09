import 'package:freezed_annotation/freezed_annotation.dart';

part 'allSafetyObservationByManager_Graph_model.g.dart';
part 'allSafetyObservationByManager_Graph_model.freezed.dart';

@freezed
class AllSafetyObservationByManagerandEnggModel with _$AllSafetyObservationByManagerandEnggModel{
  const factory AllSafetyObservationByManagerandEnggModel({

    @Default("") String pantDept,
    @Default(0) int count,
  }) = _AllSafetyObservationByManagerandEnggModel;

  factory AllSafetyObservationByManagerandEnggModel.fromJson(Map<String, dynamic> json) => _$AllSafetyObservationByManagerandEnggModelFromJson(json);
}