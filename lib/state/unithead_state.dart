import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jsaw_limited/model/unithead_model.dart';

part 'unithead_state.freezed.dart';

@freezed
class UnitHeadState with _$UnitHeadState{

  const factory UnitHeadState.loading (List<UnitHeadModel> unitHead) = _Loading;
  const factory UnitHeadState.content (List<UnitHeadModel> unitHead) = _Content;
  const factory UnitHeadState.success (List<UnitHeadModel> unitHead) = _Success;
  const factory UnitHeadState.failed (List<UnitHeadModel> unitHead, String msg) = _Failed;

  factory UnitHeadState.initial() => UnitHeadState.content([]);

}