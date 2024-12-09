import 'package:bloc/bloc.dart';
import 'package:jsaw_limited/service/observation_service.dart';
import 'package:jsaw_limited/state/alltype_hazard_state.dart';
import '../error/api_error.dart';

class AllTypeHazardBloc extends Cubit<AllTypeHazardState>{
  AllTypeHazardBloc(this.observationService): super(AllTypeHazardState.initial());

  late ObservationService observationService;

  Future<void> initState()async {
    try{
      emit(AllTypeHazardState.loading(state.allTypeHazard));
      final hazardList = await observationService.getAllTypehazard();
      emit(AllTypeHazardState.success(hazardList));
    }on ApiError catch (error) {
      emit(AllTypeHazardState.failed(state.allTypeHazard, error.message));
    }
  }
}