import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jsaw_limited/service/observation_service.dart';
import 'package:jsaw_limited/state/update_observation_state.dart';
import '../error/api_error.dart';


class UpdateObservationBloc extends Cubit<UpdateObservationState>{
  UpdateObservationBloc(this.observationService): super(UpdateObservationState.initial());

  final ObservationService observationService;

  Future<void> updateObservation(Map<String, dynamic> data)async{
    emit(UpdateObservationState.loading(state.updateObservation));
    try{
      final message = await observationService.getUpdateObservation(data);

      emit(UpdateObservationState.success(state.updateObservation, message));
    }on ApiError catch(error){
      emit(UpdateObservationState.failed(state.updateObservation,  error.message));
    }
  }

}