import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jsaw_limited/service/incident_service.dart';
import 'package:jsaw_limited/service/observation_service.dart';
import 'package:jsaw_limited/state/saveMedicalResponse_state.dart';
import 'package:jsaw_limited/state/update_observation_state.dart';
import '../error/api_error.dart';


class SaveMedicalResponseBloc extends Cubit<SaveMedicalResponseState>{
  SaveMedicalResponseBloc(this.incidentService): super(SaveMedicalResponseState.initial());

  final IncidentService incidentService;

  Future<void> saveResponce(Map<String, dynamic> data)async{
    emit(SaveMedicalResponseState.loading(state.saveMedicalResponse));
    try{
      final message = await incidentService.saveMedicalResponse(data);

      emit(SaveMedicalResponseState.success(state.saveMedicalResponse, message));
    }on ApiError catch(error){
      emit(SaveMedicalResponseState.failed(state.saveMedicalResponse,  error.message));
    }
  }

}