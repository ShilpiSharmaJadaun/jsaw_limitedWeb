import 'package:bloc/bloc.dart';
import 'package:jsaw_limited/service/graph.dart';
import 'package:jsaw_limited/state/allSafetyRaisedbyManager_state.dart';
import '../error/api_error.dart';
import '../state/AllSafetyObservationByManagerandEngg_State.dart';
import '../state/allSafetyRaisedbyManagerPieGraph_state.dart';

class SafetyRaisedByManagerPieChartBloc extends Cubit<SafetyRaisedByManagerPieChartState> {
  final GraphService graphService;

  SafetyRaisedByManagerPieChartBloc(this.graphService) : super(SafetyRaisedByManagerPieChartState.initial());

  Future<void> initState(String startDate, String endDate) async {

    emit(SafetyRaisedByManagerPieChartState.loading(state.allSafetyObservationRaisedByManager));
    try {
      final allPieList = await graphService.getSafetyRaisedBymanagerPieGraph(startDate, endDate);
      emit(SafetyRaisedByManagerPieChartState.success(allPieList));
    } catch (e) {

      emit(SafetyRaisedByManagerPieChartState.failed(state.allSafetyObservationRaisedByManager, "Error occurred"));
    }
  }
}

