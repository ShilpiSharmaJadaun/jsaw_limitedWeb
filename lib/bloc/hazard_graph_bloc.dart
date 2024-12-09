import 'package:bloc/bloc.dart';
import 'package:jsaw_limited/service/graph.dart';
import 'package:jsaw_limited/state/hazard_graph_state.dart';
import '../error/api_error.dart';

class HazardGraphBloc extends Cubit<HazardGraphState>{
  HazardGraphBloc(this.graphService): super(HazardGraphState.initial());

  late GraphService graphService;

  Future<void> initState(String startDate, String endDate)async {
    try{
      emit(HazardGraphState.loading(state.hazardGraphState));
      final divisionList = await graphService.getHazardGraphData(startDate, endDate);
      emit(HazardGraphState.success(divisionList));
    }on ApiError catch (error) {
      emit(HazardGraphState.failed(state.hazardGraphState, error.toString()));
    }
  }
}