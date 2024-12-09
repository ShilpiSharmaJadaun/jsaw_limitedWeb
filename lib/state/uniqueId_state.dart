import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jsaw_limited/model/uniqueId_model.dart';

part 'uniqueId_state.freezed.dart';

@freezed
class UniqueIdState with _$UniqueIdState{

  const factory UniqueIdState.loading (List<UniqueIdModel> uniqueId) = _Loading;
  const factory UniqueIdState.content (List<UniqueIdModel> uniqueId) = _Content;
  const factory UniqueIdState.success (List<UniqueIdModel> uniqueId) = _Success;
  const factory UniqueIdState.failed (List<UniqueIdModel> uniqueId, String msg) = _Failed;

  factory UniqueIdState.initial() => UniqueIdState.content([]);

}