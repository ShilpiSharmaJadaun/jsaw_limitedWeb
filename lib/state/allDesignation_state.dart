import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jsaw_limited/model/allDepartment_model.dart';
import 'package:jsaw_limited/model/allDesignation_model.dart';

part 'allDesignation_state.freezed.dart';

@freezed
class AllDesignationState with _$AllDesignationState{

  const factory AllDesignationState.loading (List<AllDesignationModel> allDesignation) = _Loading;
  const factory AllDesignationState.content (List<AllDesignationModel> allDesignation) = _Content;
  const factory AllDesignationState.success (List<AllDesignationModel> allDesignation) = _Success;
  const factory AllDesignationState.failed (List<AllDesignationModel> allDesignation, String msg) = _Failed;

  factory AllDesignationState.initial() => AllDesignationState.content([]);

}