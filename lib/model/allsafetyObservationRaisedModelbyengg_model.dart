import 'package:freezed_annotation/freezed_annotation.dart';

part 'allsafetyObservationRaisedModelbyengg_model.g.dart';
part 'allsafetyObservationRaisedModelbyengg_model.freezed.dart';

@freezed
class AllSafetyObservationRaisedByManagerandEnggModel with _$AllSafetyObservationRaisedByManagerandEnggModel{
  const factory AllSafetyObservationRaisedByManagerandEnggModel({

    @Default("") String pantDept,
    @Default(0) int count,
  }) = _AllSafetyObservationRaisedByManagerandEnggModel;

  factory AllSafetyObservationRaisedByManagerandEnggModel.fromJson(Map<String, dynamic> json) => _$AllSafetyObservationRaisedByManagerandEnggModelFromJson(json);
}