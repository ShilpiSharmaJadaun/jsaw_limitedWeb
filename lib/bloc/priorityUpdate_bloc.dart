import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jsaw_limited/service/observation_service.dart';
import 'package:jsaw_limited/state/priorityUpdate_state.dart';
import 'package:jsaw_limited/state/suggestion_feedback_state.dart';
import '../error/api_error.dart';


class PriorityUpdateBloc extends Cubit<PriorityUpdateState>{
  PriorityUpdateBloc(this.observationService): super(PriorityUpdateState.initial());

  final ObservationService observationService;

  Future<void> initState(Map<String, dynamic> data)async{
    emit(PriorityUpdateState.loading(state.priorityModel));
    try{
      final message = await observationService.getPriorityUpdate(data);

      emit(PriorityUpdateState.success(state.priorityModel,message));
    }on ApiError catch(error){
      emit(PriorityUpdateState.failed(state.priorityModel,  error.message));
    }
  }

}