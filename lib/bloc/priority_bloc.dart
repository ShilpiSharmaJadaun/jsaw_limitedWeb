import 'package:bloc/bloc.dart';
import 'package:jsaw_limited/service/observation_service.dart';
import 'package:jsaw_limited/state/priority_state.dart';
import '../error/api_error.dart';

class PriorityBloc extends Cubit<PriorityState> {
  PriorityBloc(this.observationService) : super(PriorityState.initial());

  late ObservationService observationService;

  Future<void> initState() async {
    emit(PriorityState.loading(state.priorityModel));
    try {
      final priorityList = await observationService.getPriority();
      emit(PriorityState.success(priorityList));
    } on ApiError catch (error) {
      print(error);
      emit(PriorityState.failed(state.priorityModel, error.message));
    }
  }
}

