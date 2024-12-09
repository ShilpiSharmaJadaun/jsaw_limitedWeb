import 'package:bloc/bloc.dart';
import 'package:jsaw_limited/service/dashboard_service.dart';
import 'package:jsaw_limited/state/allhazard_cat_state.dart';
import '../error/api_error.dart';

class AllHazardCatBloc extends Cubit<AllHazardCatState>{
  AllHazardCatBloc(this.dashboardService): super(AllHazardCatState.initial());

  late DashboardService dashboardService;

  Future<void> initState()async {
    try{
      emit(AllHazardCatState.loading(state.allHazardCategory));
      final hazardList = await dashboardService.getAllHazardList();
      emit(AllHazardCatState.success(hazardList));
    }on ApiError catch (error) {
      emit(AllHazardCatState.failed(state.allHazardCategory, error.message));
    }
  }
}