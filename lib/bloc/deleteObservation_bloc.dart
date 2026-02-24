import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jsaw_limited/service/observation_service.dart';
import 'package:jsaw_limited/service/password_service.dart';
import 'package:jsaw_limited/state/changepassword_state.dart';
import 'package:jsaw_limited/state/chnageEmail_state.dart';
import 'package:jsaw_limited/state/deleteObservation_state.dart';
import '../error/api_error.dart';


class DeleteObservationBloc extends Cubit<DeleteObservationState>{
  DeleteObservationBloc(this.observationService): super(DeleteObservationState.initial());

  ObservationService observationService;

  Future<void> deleteObservation(Map<String, dynamic> data)async{
    emit(DeleteObservationState.loading(state.deleteObservation));
    try{
      final message = await observationService.deleteObservation(data);

      emit(DeleteObservationState.success(state.deleteObservation, message));
    }on ApiError catch(error){
      emit(DeleteObservationState.failed(state.deleteObservation,  error.message));
    }
  }

}