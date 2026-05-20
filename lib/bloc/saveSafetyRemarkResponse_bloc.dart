import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jsaw_limited/service/incident_service.dart';
import 'package:jsaw_limited/service/observation_service.dart';
import 'package:jsaw_limited/state/saveMedicalResponse_state.dart';
import 'package:jsaw_limited/state/saveSafetyRemarkResponse_state.dart';
import 'package:jsaw_limited/state/update_observation_state.dart';
import '../error/api_error.dart';


class SafetyRemarkResponseBloc extends Cubit<SafetyRemarkResponseState>{
  SafetyRemarkResponseBloc(this.incidentService): super(SafetyRemarkResponseState.initial());

  final IncidentService incidentService;

  Future<void> saveResponce(Map<String, dynamic> data)async{
    emit(SafetyRemarkResponseState.loading(state.saveSafetyRemarkResponse));
    try{
      final message = await incidentService.saveSafetyRemarkResponse(data);

      emit(SafetyRemarkResponseState.success(state.saveSafetyRemarkResponse, message));
    }on ApiError catch(error){
      emit(SafetyRemarkResponseState.failed(state.saveSafetyRemarkResponse,  error.message));

    }
  }

}