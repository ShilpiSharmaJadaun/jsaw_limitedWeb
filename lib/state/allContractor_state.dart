import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jsaw_limited/model/allContractor_model.dart';
import 'package:jsaw_limited/model/allDepartment_model.dart';

part 'allContractor_state.freezed.dart';

@freezed
class AllContractorState with _$AllContractorState{

  const factory AllContractorState.loading (List<AllContractorModel> allContractorModel) = _Loading;
  const factory AllContractorState.content (List<AllContractorModel> allContractorModel) = _Content;
  const factory AllContractorState.success (List<AllContractorModel> allContractorModel) = _Success;
  const factory AllContractorState.failed (List<AllContractorModel> allContractorModel, String msg) = _Failed;

  factory AllContractorState.initial() => AllContractorState.content([]);

}