import 'package:bloc/bloc.dart';
import 'package:jsaw_limited/service/observation_service.dart';
import '../error/api_error.dart';
import '../state/raisedObservationState.dart';

class RaisedObservationBloc extends Cubit<RaisedObservationState> {
  RaisedObservationBloc(this.observationService) : super(RaisedObservationState.initial());

  late ObservationService observationService;

  Future<void> initState(String empUnqCode) async {
    emit(RaisedObservationState.loading(state.raisedObservation));
    try {
      final observationList = await observationService.getAllRaisedObservation(empUnqCode);
      emit(RaisedObservationState.success(observationList));
    } on ApiError catch (error) {
      print(error);
      emit(RaisedObservationState.failed(state.raisedObservation, error.message));
    }
  }
}

