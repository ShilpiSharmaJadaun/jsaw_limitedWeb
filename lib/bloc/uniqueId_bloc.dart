import 'package:bloc/bloc.dart';
import 'package:jsaw_limited/service/observation_service.dart';
import '../error/api_error.dart';
import '../state/uniqueId_state.dart';

class UniqueIdBloc extends Cubit<UniqueIdState>{
  UniqueIdBloc(this.observationService): super(UniqueIdState.initial());

  late ObservationService observationService;

  Future<void> initState()async {
    try{
      emit(UniqueIdState.loading(state.uniqueId));
      final divisionList = await observationService.getUniqueIdList();
      emit(UniqueIdState.success(divisionList));
    }on ApiError catch (error) {
      emit(UniqueIdState.failed(state.uniqueId, error.message));
    }
  }
}