import 'package:bloc/bloc.dart';
import 'package:jsaw_limited/service/dashboard_service.dart';
import 'package:jsaw_limited/state/top3hazard_state.dart';
import '../error/api_error.dart';

class Top3HazardBloc extends Cubit<Top3HazardState>{
  Top3HazardBloc(this.dashboardService): super(Top3HazardState.initial());

  late DashboardService dashboardService;

  Future<void> initState()async {
    try{
      emit(Top3HazardState.loading(state.top3HazardModel));
      final divisionList = await dashboardService.gettop3hazard();
      emit(Top3HazardState.success(divisionList));
    }on ApiError catch (error) {
      emit(Top3HazardState.failed(state.top3HazardModel, error.message));
    }
  }
}