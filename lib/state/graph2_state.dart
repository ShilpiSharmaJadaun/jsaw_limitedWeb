import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jsaw_limited/model/graph2_model.dart';

part 'graph2_state.freezed.dart';

@freezed
class Graph2State with _$Graph2State{

  const factory Graph2State.loading (List<Graph2Model> graph2Models) = _Loading;
  const factory Graph2State.content (List<Graph2Model> graph2Models) = _Content;
  const factory Graph2State.success (List<Graph2Model> graph2Models) = _Success;
  const factory Graph2State.failed (List<Graph2Model> graph2Models, String error) = _Failed;

  factory Graph2State.initial() => Graph2State.content([]);
}
