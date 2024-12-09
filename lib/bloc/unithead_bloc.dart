import 'package:bloc/bloc.dart';
import 'package:jsaw_limited/service/observation_service.dart';
import '../error/api_error.dart';
import '../state/unithead_state.dart';

class UnitHeadBloc extends Cubit<UnitHeadState> {
  UnitHeadBloc(this.observationService) : super(UnitHeadState.initial());

  late ObservationService observationService;

  Future<void> initState(String plantCode) async {
    emit(UnitHeadState.loading(state.unitHead));
    try {
      final unitHeadList = await observationService.getUnitHead(plantCode);
      emit(UnitHeadState.success(unitHeadList));
    } on ApiError catch (error) {
      emit(UnitHeadState.failed(state.unitHead, error.message));
    }
  }
}

