import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jsaw_limited/model/stationwise_graphtable_model.dart';
import 'package:jsaw_limited/model/update_observation_model.dart';
import 'package:jsaw_limited/model/userwise_tablegraph_model.dart';

part 'stationwise_graphtable_state.freezed.dart';

@freezed
class StationWiseGraphTableState with _$StationWiseGraphTableState {
  const factory StationWiseGraphTableState.loading(List<StationWiseGraphTableModel> stationwiseTable) = _Loading;
  const factory StationWiseGraphTableState.content(List<StationWiseGraphTableModel> stationwiseTable) = _Content;
  const factory StationWiseGraphTableState.success(List<StationWiseGraphTableModel> stationwiseTable) = _Success;
  const factory StationWiseGraphTableState.failed(List<StationWiseGraphTableModel> stationwiseTable, String message) =
  _Failed;

  factory StationWiseGraphTableState.initial() => StationWiseGraphTableState.content([]);
}