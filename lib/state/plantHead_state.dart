import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jsaw_limited/model/plantHead_model.dart';

part 'plantHead_state.freezed.dart';

@freezed
class PlantHeadState with _$PlantHeadState{

  const factory PlantHeadState.loading (List<PlantHeadModel> plantHead) = _Loading;
  const factory PlantHeadState.content (List<PlantHeadModel> plantHead) = _Content;
  const factory PlantHeadState.success (List<PlantHeadModel> plantHead) = _Success;
  const factory PlantHeadState.failed (List<PlantHeadModel> plantHead, String msg) = _Failed;

  factory PlantHeadState.initial() => PlantHeadState.content([]);

}