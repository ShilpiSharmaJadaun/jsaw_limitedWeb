import 'package:bloc/bloc.dart';
import 'package:jsaw_limited/service/observation_service.dart';
import 'package:jsaw_limited/state/observationby_uni_state.dart';
import '../error/api_error.dart';

class ObservationbyUniBloc extends Cubit<ObservationbyUniState> {
  ObservationbyUniBloc(this.observationService) : super(ObservationbyUniState.initial());

  late ObservationService observationService;

  Future<void> initState(String UNI, String raisedBy) async {
    emit(ObservationbyUniState.loading(state.observationbyUni));
    try {
      final observationList = await observationService.getAllObservationBYUINandEmployee(UNI, raisedBy);
      emit(ObservationbyUniState.success(observationList));
    } on ApiError catch (error) {
      print(error);
      emit(ObservationbyUniState.failed(state.observationbyUni, error.message));
    }
  }
}

