import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jsaw_limited/model/top3hazard_model.dart';

part 'top3hazard_state.freezed.dart';

@freezed
class Top3HazardState with _$Top3HazardState{

  const factory Top3HazardState.loading (List<Top3HazardModel> top3HazardModel) = _Loading;
  const factory Top3HazardState.content (List<Top3HazardModel> top3HazardModel) = _Content;
  const factory Top3HazardState.success (List<Top3HazardModel> top3HazardModel) = _Success;
  const factory Top3HazardState.failed (List<Top3HazardModel> top3HazardModel, String msg) = _Failed;

  factory Top3HazardState.initial() => Top3HazardState.content([]);

}