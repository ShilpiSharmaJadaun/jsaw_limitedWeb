import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jsaw_limited/model/insertnewHOD_model.dart';

part 'insertHODEmployee_state.freezed.dart';

@freezed
class InsertNewHodState with _$InsertNewHodState {
  const factory InsertNewHodState.loading(InsertNewHodModel insertHOD) = _Loading;
  const factory InsertNewHodState.content(InsertNewHodModel insertHOD) = _Content;
  const factory InsertNewHodState.success(InsertNewHodModel insertHOD, String? message) = _Success;
  const factory InsertNewHodState.failed(InsertNewHodModel insertHOD, String message) =_Failed;

  factory InsertNewHodState.initial() => const InsertNewHodState.content(InsertNewHodModel());
}