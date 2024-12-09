import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jsaw_limited/model/observationby_uni_model.dart';

part 'observationby_uni_state.freezed.dart';

@freezed
class ObservationbyUniState with _$ObservationbyUniState{

  const factory ObservationbyUniState.loading (List<ObservationbyUniModel> observationbyUni) = _Loading;
  const factory ObservationbyUniState.content (List<ObservationbyUniModel> observationbyUni) = _Content;
  const factory ObservationbyUniState.success (List<ObservationbyUniModel> observationbyUni) = _Success;
  const factory ObservationbyUniState.failed (List<ObservationbyUniModel> observationbyUni, String msg) = _Failed;

  factory ObservationbyUniState.initial() => ObservationbyUniState.content([]);

}