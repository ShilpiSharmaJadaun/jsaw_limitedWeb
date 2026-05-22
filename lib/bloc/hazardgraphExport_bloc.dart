import 'package:bloc/bloc.dart';
import 'package:jsaw_limited/service/graph.dart';
import 'package:jsaw_limited/service/observation_service.dart';
import 'package:jsaw_limited/state/departmentgraphExport_state.dart';
import 'package:jsaw_limited/state/generateExcel_state.dart';
import 'package:jsaw_limited/state/hazardGraphExport_state.dart';
import '../error/api_error.dart';

class HazardGraphExportBloc extends Cubit<HazardGraphExportState>{
  HazardGraphExportBloc(this.graphService): super(HazardGraphExportState.initial());

  late GraphService graphService;

  Future<void> initState([String startDate = "", String endDate = ""])async {
    try{
      emit(HazardGraphExportState.loading(state.hazardGraphExport));
      final generateExcel = await graphService.generateHazardGraphExport(startDate, endDate);
      emit(HazardGraphExportState.success(generateExcel!, generateExcel.url));
    }on ApiError catch (error) {
      emit(HazardGraphExportState.failed(state.hazardGraphExport, error.message));
    }
  }
}