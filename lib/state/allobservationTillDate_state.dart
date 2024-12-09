import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jsaw_limited/model/allobservation_model.dart';

part 'allobservationTillDate_state.freezed.dart';

@freezed
class AllObservaionTillDateState with _$AllObservaionTillDateState{

  const factory AllObservaionTillDateState.loading (List<AllObservationModel> divisionModel) = _Loading;
  const factory AllObservaionTillDateState.content (List<AllObservationModel> divisionModel) = _Content;
  const factory AllObservaionTillDateState.success (List<AllObservationModel> divisionModel) = _Success;
  const factory AllObservaionTillDateState.failed (List<AllObservationModel> divisionModel, String msg) = _Failed;

  factory AllObservaionTillDateState.initial() => AllObservaionTillDateState.content([]);

}