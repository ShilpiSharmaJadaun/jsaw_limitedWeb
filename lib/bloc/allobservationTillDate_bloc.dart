
import 'package:bloc/bloc.dart';
import 'package:jsaw_limited/service/observation_service.dart';
import '../error/api_error.dart';
import '../state/allobservationTillDate_state.dart';

class AllObservaionTillDateBloc extends Cubit<AllObservaionTillDateState>{
  AllObservaionTillDateBloc(this.observationService): super(AllObservaionTillDateState.initial());

  late ObservationService observationService;

  Future<void> initState()async {
    try{
      emit(AllObservaionTillDateState.loading(state.divisionModel));
      final divisionList = await observationService.getAllObservationsTillDate();
      emit(AllObservaionTillDateState.success(divisionList));
    }on ApiError catch (error) {
      emit(AllObservaionTillDateState.failed(state.divisionModel, error.message));
    }
  }
}