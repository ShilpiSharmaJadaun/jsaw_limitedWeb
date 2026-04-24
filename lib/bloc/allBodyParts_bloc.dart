import 'package:bloc/bloc.dart';
import 'package:jsaw_limited/service/incident_service.dart';
import 'package:jsaw_limited/service/observation_service.dart';
import 'package:jsaw_limited/state/allBodyParts_state.dart';
import 'package:jsaw_limited/state/allContractor_state.dart';
import 'package:jsaw_limited/state/allDepart_state.dart';
import '../error/api_error.dart';

class AllBodyPartsBloc extends Cubit<AllBodyPartsState>{
  AllBodyPartsBloc(this.incidentService): super(AllBodyPartsState.initial());

  late IncidentService incidentService;

  Future<void> initState()async {
    try{
      emit(AllBodyPartsState.loading(state.allBodyParts));
      final allBodyParts = await incidentService.getAllBodyParts();
      emit(AllBodyPartsState.success(allBodyParts));
    }on ApiError catch (error) {
      emit(AllBodyPartsState.failed(state.allBodyParts, error.message));
    }
  }
}