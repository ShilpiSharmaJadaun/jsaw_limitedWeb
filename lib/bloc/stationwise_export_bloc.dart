import 'package:bloc/bloc.dart';
import 'package:jsaw_limited/service/graph.dart';
import 'package:jsaw_limited/service/observation_service.dart';
import 'package:jsaw_limited/state/departmentgraphExport_state.dart';
import 'package:jsaw_limited/state/generateExcel_state.dart';
import 'package:jsaw_limited/state/stationwise_graph_export_state.dart';
import '../error/api_error.dart';

class StationWiseGraphExportBloc extends Cubit<StationWiseGraphExportState>{
  StationWiseGraphExportBloc(this.graphService): super(StationWiseGraphExportState.initial());

  late GraphService graphService;

  Future<void> initState(String startDate, String endDate)async {
    try{
      emit(StationWiseGraphExportState.loading(state.stationWiseExport));
      final generateExcel = await graphService.generateStationWiseExport(startDate, endDate);
      emit(StationWiseGraphExportState.success(generateExcel!, generateExcel.url));
    }on ApiError catch (error) {
      print(error);
      emit(StationWiseGraphExportState.failed(state.stationWiseExport, error.message));
    }
  }
}