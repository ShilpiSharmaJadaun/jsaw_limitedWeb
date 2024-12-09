import 'package:bloc/bloc.dart';
import 'package:jsaw_limited/service/graph.dart';
import 'package:jsaw_limited/state/allSafetyRaisedbyManager_state.dart';
import '../error/api_error.dart';
import '../state/AllSafetyObservationByManagerandEngg_State.dart';

class SafetyRaisedByManagerBloc extends Cubit<AllSafetyRaisedByManagerState> {
  final GraphService graphService;

  SafetyRaisedByManagerBloc(this.graphService) : super(AllSafetyRaisedByManagerState.initial());

  Future<void> initState(String startDate, String endDate) async {

    emit(AllSafetyRaisedByManagerState.loading(state.allSafetyObservationRaisedByManager));
    try {
      final allGraphList = await graphService.getSafetyRaisedBymanagerGraph(startDate, endDate);
      emit(AllSafetyRaisedByManagerState.success(allGraphList));
    } catch (e) {

      emit(AllSafetyRaisedByManagerState.failed(state.allSafetyObservationRaisedByManager, "Error occurred"));
    }
  }
}

