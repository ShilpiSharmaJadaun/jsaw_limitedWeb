import 'package:bloc/bloc.dart';
import 'package:jsaw_limited/service/dashboard_service.dart';
import 'package:jsaw_limited/state/alltoday_observation_state.dart';
import '../error/api_error.dart';

class AllTodayObservationBloc extends Cubit<AllTodayObservationState>{
  AllTodayObservationBloc(this.dashboardService): super(AllTodayObservationState.initial());

  late DashboardService dashboardService;

  Future<void> initState([String? hazardCategory])async {
    try{
      emit(AllTodayObservationState.loading(state.allTodayObservation));
      final divisionList = await dashboardService.getAllTodayObservation(hazardCategory ?? "");
      emit(AllTodayObservationState.success(divisionList));
    }on ApiError catch (error) {
      emit(AllTodayObservationState.failed(state.allTodayObservation, error.message));
    }
  }
}