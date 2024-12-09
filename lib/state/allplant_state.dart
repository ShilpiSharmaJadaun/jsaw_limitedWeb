import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jsaw_limited/model/allplant_model.dart';

part 'allplant_state.freezed.dart';

@freezed
class AllPlantState with _$AllPlantState{

  const factory AllPlantState.loading (List<AllPlantModel> allPlantModel) = _Loading;
  const factory AllPlantState.content (List<AllPlantModel> allPlantModel) = _Content;
  const factory AllPlantState.success (List<AllPlantModel> allPlantModel) = _Success;
  const factory AllPlantState.failed (List<AllPlantModel> allPlantModel, String msg) = _Failed;

  factory AllPlantState.initial() => AllPlantState.content([]);

}