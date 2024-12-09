import 'package:bloc/bloc.dart';
import 'package:jsaw_limited/service/graph.dart';
import '../error/api_error.dart';
import '../state/AllSafetyObservationByManagerandEngg_State.dart';

class SafetyByManagerBloc extends Cubit<AllSafetyByManagerState> {
  final GraphService graphService;

  SafetyByManagerBloc(this.graphService) : super(AllSafetyByManagerState.initial());

  Future<void> initState(String startDate, String endDate) async {

    emit(AllSafetyByManagerState.loading(state.allSafetyObservationByManager));
    try {
      final allDepartlist = await graphService.getSafetyBymanagerGraph(startDate, endDate);
      emit(AllSafetyByManagerState.success(allDepartlist));
    } catch (e) {

      emit(AllSafetyByManagerState.failed(state.allSafetyObservationByManager, "Error occurred"));
    }
  }
}

