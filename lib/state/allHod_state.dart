import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jsaw_limited/model/allHod_model.dart';

part 'allHod_state.freezed.dart';

@freezed
class AllHodState with _$AllHodState{

  const factory AllHodState.loading (List<AllHodModel> allHod) = _Loading;
  const factory AllHodState.content (List<AllHodModel> allHod) = _Content;
  const factory AllHodState.success (List<AllHodModel> allHod) = _Success;
  const factory AllHodState.failed (List<AllHodModel> allHod, String msg) = _Failed;

  factory AllHodState.initial() => AllHodState.content([]);

}