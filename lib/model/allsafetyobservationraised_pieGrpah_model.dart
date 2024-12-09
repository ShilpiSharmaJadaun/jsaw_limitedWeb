import 'package:freezed_annotation/freezed_annotation.dart';

part 'allsafetyobservationraised_pieGrpah_model.g.dart';
part 'allsafetyobservationraised_pieGrpah_model.freezed.dart';

@freezed
class AllSafetyObservationRaisedByManagerandEnggModelPieChart with _$AllSafetyObservationRaisedByManagerandEnggModelPieChart{
  const factory AllSafetyObservationRaisedByManagerandEnggModelPieChart({

    @Default("") String plant,
    @Default(0) int closed,
    @Default(0) int pending,
    @Default(0) int inProgress,
    @Default(0) int alls,
    @Default(0) int compliance,
    @Default(0.0) double closedPercentage,
    @Default(0.0) double pendingPercentage,
    @Default(0.0) double inProgressPercentage,
    @Default(0.0) double compliancePercentage,
  }) = _AllSafetyObservationRaisedByManagerandEnggModelPieChart;

  factory AllSafetyObservationRaisedByManagerandEnggModelPieChart.fromJson(Map<String, dynamic> json) => _$AllSafetyObservationRaisedByManagerandEnggModelPieChartFromJson(json);
}