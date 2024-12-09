import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jsaw_limited/model/updateHod_model.dart';

part 'updateHod_state.freezed.dart';

@freezed
class UpdateHodState with _$UpdateHodState {
  const factory UpdateHodState.loading(UpdateHodModel updateHod) = _Loading;
  const factory UpdateHodState.content(UpdateHodModel updateHod) = _Content;
  const factory UpdateHodState.success(UpdateHodModel updateHod, String? message) = _Success;
  const factory UpdateHodState.failed(UpdateHodModel updateHod, String message) =_Failed;

  factory UpdateHodState.initial() => const UpdateHodState.content(UpdateHodModel());
}