import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jsaw_limited/model/allHod_model.dart';
import 'package:jsaw_limited/model/allNatureInjury_model.dart';

part 'allNatureInjury_state.freezed.dart';

@freezed
class AllNatureInjuryState with _$AllNatureInjuryState{

  const factory AllNatureInjuryState.loading (List<AllNatureInjuryModel> allNatureInjury) = _Loading;
  const factory AllNatureInjuryState.content (List<AllNatureInjuryModel> allNatureInjury) = _Content;
  const factory AllNatureInjuryState.success (List<AllNatureInjuryModel> allNatureInjury) = _Success;
  const factory AllNatureInjuryState.failed (List<AllNatureInjuryModel> allNatureInjury, String msg) = _Failed;

  factory AllNatureInjuryState.initial() => AllNatureInjuryState.content([]);

}