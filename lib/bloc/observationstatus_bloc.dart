import 'package:bloc/bloc.dart';
import 'package:jsaw_limited/service/dashboard_service.dart';
import 'package:jsaw_limited/state/observationStatus_state.dart';
import '../error/api_error.dart';

class ObservationStatusBloc extends Cubit<ObservationStatusState> {
  ObservationStatusBloc(this.dashboardService) : super(ObservationStatusState.initial());

  late DashboardService dashboardService;

  Future<void> initState() async {
    emit(ObservationStatusState.loading(state.observationStatus));
    try {
      final observationList = await dashboardService.getObservationStatus();
      emit(ObservationStatusState.success(observationList));
    } on ApiError catch (error) {
      print(error);
      emit(ObservationStatusState.failed(state.observationStatus, error.message));
    }
  }
}

