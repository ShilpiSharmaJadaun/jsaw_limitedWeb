import 'package:freezed_annotation/freezed_annotation.dart';
import '../model/allSafetyObservationByManager_Graph_model.dart';

part 'AllSafetyObservationByManagerandEngg_State.freezed.dart';

@freezed
class AllSafetyByManagerState with _$AllSafetyByManagerState{

  const factory AllSafetyByManagerState.loading (List<AllSafetyObservationByManagerandEnggModel> allSafetyObservationByManager) = _Loading;
  const factory AllSafetyByManagerState.content (List<AllSafetyObservationByManagerandEnggModel> allSafetyObservationByManager) = _Content;
  const factory AllSafetyByManagerState.success (List<AllSafetyObservationByManagerandEnggModel> allSafetyObservationByManager) = _Success;
  const factory AllSafetyByManagerState.failed (List<AllSafetyObservationByManagerandEnggModel> allSafetyObservationByManager, String msg) = _Failed;

  factory AllSafetyByManagerState.initial() => AllSafetyByManagerState.content([]);

}