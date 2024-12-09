import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jsaw_limited/model/graph2_station_model.dart';

import 'graph2_model.dart';

part 'graph2main_model.g.dart';
part 'graph2main_model.freezed.dart';

@freezed
class Graph2MainModel with _$Graph2MainModel {
  const factory Graph2MainModel({
    @Default(0) int totalPages,
    @Default(0) int totalItems,
    @Default(0) int currentPage,
    @Default('') String msg,
    @Default('') String sessionID,
    @Default(false) bool status,
    @Default(<Graph2Model>[]) List<Graph2Model> model, // List of Graph2StationModel objects
  }) = _Graph2MainModel;

  factory Graph2MainModel.fromJson(Map<String, dynamic> json) => _$Graph2MainModelFromJson(json);
}
