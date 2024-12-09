import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jsaw_limited/model/priority_model.dart';

part 'priority_state.freezed.dart';

@freezed
class PriorityState with _$PriorityState{

  const factory PriorityState.loading (List<PriorityModel> priorityModel) = _Loading;
  const factory PriorityState.content (List<PriorityModel> priorityModel) = _Content;
  const factory PriorityState.success (List<PriorityModel> priorityModel) = _Success;
  const factory PriorityState.failed (List<PriorityModel> priorityModel, String msg) = _Failed;

  factory PriorityState.initial() => PriorityState.content([]);

}