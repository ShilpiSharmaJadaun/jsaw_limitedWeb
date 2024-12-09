import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jsaw_limited/model/graph2_station_model.dart';

part 'graph2_model.g.dart';
part 'graph2_model.freezed.dart';

@freezed
class Graph2Model with _$Graph2Model {
  const factory Graph2Model({
    @Default('') String plantDept,
    @Default('') String plantDeptCode,
    @Default('') String totalCount,
    @Default(<Graph2StationModel>[]) List<Graph2StationModel> stations,
  }) = _Graph2Model;

  factory Graph2Model.fromJson(Map<String, dynamic> json) => _$Graph2ModelFromJson(json);
}
