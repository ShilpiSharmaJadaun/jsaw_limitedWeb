import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jsaw_limited/model/allBodyParts_model.dart';
import 'package:jsaw_limited/model/allContractor_model.dart';
import 'package:jsaw_limited/model/allDepartment_model.dart';

part 'allBodyParts_state.freezed.dart';

@freezed
class AllBodyPartsState with _$AllBodyPartsState{

  const factory AllBodyPartsState.loading (List<AllBodyPartsModel> allBodyParts) = _Loading;
  const factory AllBodyPartsState.content (List<AllBodyPartsModel> allBodyParts) = _Content;
  const factory AllBodyPartsState.success (List<AllBodyPartsModel> allBodyParts) = _Success;
  const factory AllBodyPartsState.failed (List<AllBodyPartsModel> allBodyParts, String msg) = _Failed;

  factory AllBodyPartsState.initial() => AllBodyPartsState.content([]);

}