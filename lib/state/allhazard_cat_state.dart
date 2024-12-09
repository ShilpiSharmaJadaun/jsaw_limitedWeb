import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jsaw_limited/model/allhazard_cat_model.dart';

part 'allhazard_cat_state.freezed.dart';

@freezed
class AllHazardCatState with _$AllHazardCatState{

  const factory AllHazardCatState.loading (List<AllHazardCatModel> allHazardCategory) = _Loading;
  const factory AllHazardCatState.content (List<AllHazardCatModel> allHazardCategory) = _Content;
  const factory AllHazardCatState.success (List<AllHazardCatModel> allHazardCategory) = _Success;
  const factory AllHazardCatState.failed (List<AllHazardCatModel> allHazardCategory, String msg) = _Failed;

  factory AllHazardCatState.initial() => AllHazardCatState.content([]);

}