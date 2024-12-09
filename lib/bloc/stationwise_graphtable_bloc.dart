import 'package:bloc/bloc.dart';
import 'package:jsaw_limited/service/graph.dart';
import 'package:jsaw_limited/state/stationwise_graphtable_state.dart';


class StationWiseGraphTableBloc extends Cubit<StationWiseGraphTableState> {
  StationWiseGraphTableBloc( this.graphService)
      : super(StationWiseGraphTableState.initial());

  late GraphService graphService;

  Future<void> init(String startDate, String endDate) async {
    emit(StationWiseGraphTableState.loading(state.stationwiseTable));
    final stationWiseData = await graphService.getStationwiseData(startDate, endDate);
    emit(StationWiseGraphTableState.content(stationWiseData));
  }
}