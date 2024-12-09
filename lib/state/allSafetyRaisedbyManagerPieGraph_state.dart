import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jsaw_limited/model/allsafetyobservationraised_pieGrpah_model.dart';
import '../model/allsafetyObservationRaisedModelbyengg_model.dart';

part 'allSafetyRaisedbyManagerPieGraph_state.freezed.dart';

@freezed
class SafetyRaisedByManagerPieChartState with _$SafetyRaisedByManagerPieChartState{

  const factory SafetyRaisedByManagerPieChartState.loading (List<AllSafetyObservationRaisedByManagerandEnggModelPieChart> allSafetyObservationRaisedByManager) = _Loading;
  const factory SafetyRaisedByManagerPieChartState.content (List<AllSafetyObservationRaisedByManagerandEnggModelPieChart> allSafetyObservationRaisedByManager) = _Content;
  const factory SafetyRaisedByManagerPieChartState.success (List<AllSafetyObservationRaisedByManagerandEnggModelPieChart> allSafetyObservationRaisedByManager) = _Success;
  const factory SafetyRaisedByManagerPieChartState.failed (List<AllSafetyObservationRaisedByManagerandEnggModelPieChart> allSafetyObservationRaisedByManager, String msg) = _Failed;

  factory SafetyRaisedByManagerPieChartState.initial() => SafetyRaisedByManagerPieChartState.content([]);

}