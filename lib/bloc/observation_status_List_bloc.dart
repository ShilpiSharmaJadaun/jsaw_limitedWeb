import 'package:bloc/bloc.dart';
import 'package:jsaw_limited/service/dashboard_service.dart';
import 'package:jsaw_limited/service/graph.dart';
import 'package:jsaw_limited/state/observationStatus_state.dart';
import 'package:jsaw_limited/state/observation_status_List_state.dart';
import '../error/api_error.dart';

class ObservationStatusListBloc extends Cubit<ObservationStatusListState> {
  ObservationStatusListBloc(this.graphService) : super(ObservationStatusListState.initial());

  late GraphService graphService;

  Future<void> initState() async {
    emit(ObservationStatusListState.loading(state.observationStatusListModel));
    try {
      final observationList = await graphService.getObservationStatusList();
      emit(ObservationStatusListState.success(observationList));
    } on ApiError catch (error) {
      print(error);
      emit(ObservationStatusListState.failed(state.observationStatusListModel, error.message));
    }
  }
}

