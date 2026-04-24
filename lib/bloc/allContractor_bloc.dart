import 'package:bloc/bloc.dart';
import 'package:jsaw_limited/service/incident_service.dart';
import 'package:jsaw_limited/service/observation_service.dart';
import 'package:jsaw_limited/state/allContractor_state.dart';
import 'package:jsaw_limited/state/allDepart_state.dart';
import '../error/api_error.dart';

class AllContractorBloc extends Cubit<AllContractorState>{
  AllContractorBloc(this.incidentService): super(AllContractorState.initial());

  late IncidentService incidentService;

  Future<void> initState()async {
    try{
      emit(AllContractorState.loading(state.allContractorModel));
      final allContractorList = await incidentService.getAllContractorList();
      emit(AllContractorState.success(allContractorList));
    }on ApiError catch (error) {
      emit(AllContractorState.failed(state.allContractorModel, error.message));
    }
  }
}