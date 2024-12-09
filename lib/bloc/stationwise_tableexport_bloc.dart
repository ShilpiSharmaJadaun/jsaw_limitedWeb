import 'package:bloc/bloc.dart';
import 'package:jsaw_limited/service/graph.dart';
import 'package:jsaw_limited/state/stationwise_tableexport_state.dart';
import '../error/api_error.dart';


class StationWiseTableExportBloc extends Cubit<StationWiseTableExportState> {
  StationWiseTableExportBloc( this.graphService)
      : super(StationWiseTableExportState.initial());

  late GraphService graphService;

  Future<void> initState(String startDate, String endDate)async {
    try{
      emit(StationWiseTableExportState.loading(state.stationwiseTable));
      final generateExcel = await graphService.generateStationWiseTableExport(startDate, endDate);
      emit(StationWiseTableExportState.success(generateExcel!, generateExcel.url));
    }on ApiError catch (error) {
      emit(StationWiseTableExportState.failed(state.stationwiseTable, error.message));
    }
  }
}