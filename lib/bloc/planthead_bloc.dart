import 'package:bloc/bloc.dart';
import 'package:jsaw_limited/service/observation_service.dart';
import 'package:jsaw_limited/state/plantHead_state.dart';
import '../error/api_error.dart';

class PlantHeadBloc extends Cubit<PlantHeadState> {
  PlantHeadBloc(this.observationService) : super(PlantHeadState.initial());

  late ObservationService observationService;

  Future<void> initState(String plantCode) async {
    emit(PlantHeadState.loading(state.plantHead));
    try {
      final priorityList = await observationService.getPlantHead(plantCode);
      emit(PlantHeadState.success(priorityList));
    } on ApiError catch (error) {
      print(error);
      emit(PlantHeadState.failed(state.plantHead, error.message));
    }
  }
}

