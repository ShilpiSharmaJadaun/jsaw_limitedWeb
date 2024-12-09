import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jsaw_limited/model/allwork_group_model.dart';

part 'allwork_group_state.freezed.dart';

@freezed
class AllWorkGroupState with _$AllWorkGroupState{

  const factory AllWorkGroupState.loading (List<AllWorkGroupModel> allworkGroup) = _Loading;
  const factory AllWorkGroupState.content (List<AllWorkGroupModel> allworkGroup) = _Content;
  const factory AllWorkGroupState.success (List<AllWorkGroupModel> allworkGroup) = _Success;
  const factory AllWorkGroupState.failed (List<AllWorkGroupModel> allworkGroup, String msg) = _Failed;

  factory AllWorkGroupState.initial() => AllWorkGroupState.content([]);

}