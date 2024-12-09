import 'package:freezed_annotation/freezed_annotation.dart';


part 'hazard_graph_model.g.dart';
part 'hazard_graph_model.freezed.dart';

@freezed
class HazardGraphModel with _$HazardGraphModel {
  const factory HazardGraphModel({
    @Default('') String hazardCategory,
    @Default(0) int observationCount,
    @Default(0) int percentage,
  }) = _HazardGraphModel;

  factory HazardGraphModel.fromJson(Map<String, dynamic> json) => _$HazardGraphModelFromJson(json);
}
