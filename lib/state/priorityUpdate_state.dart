import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jsaw_limited/model/priorityUpdate_model.dart';
import 'package:jsaw_limited/model/save_suggestionModel.dart';


part 'priorityUpdate_state.freezed.dart';

@freezed
class PriorityUpdateState with _$PriorityUpdateState {
  const factory PriorityUpdateState.loading(PriorityUpdateModel priorityModel) = _Loading;
  const factory PriorityUpdateState.content(PriorityUpdateModel priorityModel) = _Content;
  const factory PriorityUpdateState.success(PriorityUpdateModel priorityModel, String? message) = _Success;
  const factory PriorityUpdateState.failed(PriorityUpdateModel priorityModel, String message) =
  _Failed;

  factory PriorityUpdateState.initial() => PriorityUpdateState.content(PriorityUpdateModel());
}