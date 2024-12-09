import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jsaw_limited/model/alltype_hazard_model.dart';

part 'alltype_hazard_state.freezed.dart';

@freezed
class AllTypeHazardState with _$AllTypeHazardState{

  const factory AllTypeHazardState.loading (List<AllTypeHazardModel> allTypeHazard) = _Loading;
  const factory AllTypeHazardState.content (List<AllTypeHazardModel> allTypeHazard) = _Content;
  const factory AllTypeHazardState.success (List<AllTypeHazardModel> allTypeHazard) = _Success;
  const factory AllTypeHazardState.failed (List<AllTypeHazardModel> allTypeHazard, String msg) = _Failed;

  factory AllTypeHazardState.initial() => AllTypeHazardState.content([]);

}