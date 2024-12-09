import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jsaw_limited/model/hazard_graph_model.dart';

part 'hazard_graph_state.freezed.dart';

@freezed
class HazardGraphState with _$HazardGraphState{

  const factory HazardGraphState.loading (List<HazardGraphModel> hazardGraphState) = _Loading;
  const factory HazardGraphState.content (List<HazardGraphModel> hazardGraphState) = _Content;
  const factory HazardGraphState.success (List<HazardGraphModel> hazardGraphState) = _Success;
  const factory HazardGraphState.failed (List<HazardGraphModel> hazardGraphState, String error) = _Failed;

  factory HazardGraphState.initial() => HazardGraphState.content([]);
}
