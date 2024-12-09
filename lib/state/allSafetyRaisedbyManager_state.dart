import 'package:freezed_annotation/freezed_annotation.dart';
import '../model/allSafetyObservationByManager_Graph_model.dart';
import '../model/allsafetyObservationRaisedModelbyengg_model.dart';

part 'allSafetyRaisedbyManager_state.freezed.dart';

@freezed
class AllSafetyRaisedByManagerState with _$AllSafetyRaisedByManagerState{

  const factory AllSafetyRaisedByManagerState.loading (List<AllSafetyObservationRaisedByManagerandEnggModel> allSafetyObservationRaisedByManager) = _Loading;
  const factory AllSafetyRaisedByManagerState.content (List<AllSafetyObservationRaisedByManagerandEnggModel> allSafetyObservationRaisedByManager) = _Content;
  const factory AllSafetyRaisedByManagerState.success (List<AllSafetyObservationRaisedByManagerandEnggModel> allSafetyObservationRaisedByManager) = _Success;
  const factory AllSafetyRaisedByManagerState.failed (List<AllSafetyObservationRaisedByManagerandEnggModel> allSafetyObservationRaisedByManager, String msg) = _Failed;

  factory AllSafetyRaisedByManagerState.initial() => AllSafetyRaisedByManagerState.content([]);

}