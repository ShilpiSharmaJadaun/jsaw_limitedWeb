import 'package:bloc/bloc.dart';
import 'package:jsaw_limited/service/employee_reporting_service.dart';
import 'package:jsaw_limited/service/incident_service.dart';
import 'package:jsaw_limited/state/allHod_state.dart';
import 'package:jsaw_limited/state/allIncidentList_state.dart';
import 'package:jsaw_limited/state/allNatureInjury_state.dart';
import '../error/api_error.dart';

class AllIncidentListBloc extends Cubit<AllIncidentListState> {
  AllIncidentListBloc(this.incidentService) : super(AllIncidentListState.initial());

  late IncidentService incidentService;


  Future<void> initState() async {
    emit(AllIncidentListState.loading(state.allIncidentList));
    try {
      final allIncidentList = await incidentService.getAllIncidentList();
      emit(AllIncidentListState.success(allIncidentList!));
    } on ApiError catch (error) {
      emit(AllIncidentListState.failed(state.allIncidentList, error.message));
    }
  }
}

