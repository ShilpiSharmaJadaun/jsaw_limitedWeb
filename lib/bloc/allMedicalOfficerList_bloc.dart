import 'package:bloc/bloc.dart';
import 'package:jsaw_limited/service/employee_reporting_service.dart';
import 'package:jsaw_limited/service/incident_service.dart';
import 'package:jsaw_limited/state/allHod_state.dart';
import 'package:jsaw_limited/state/allMedicalOfficerList_state.dart';
import 'package:jsaw_limited/state/allNatureInjury_state.dart';
import '../error/api_error.dart';

class AllMedicalOfficerListBloc extends Cubit<AllMedicalOfficerListState> {
  AllMedicalOfficerListBloc(this.incidentService) : super(AllMedicalOfficerListState.initial());

  late IncidentService incidentService;


  Future<void> initState() async {
    emit(AllMedicalOfficerListState.loading(state.allMedicalOfficerList));
    try {
      final allIncidentList = await incidentService.getAllMedicalOfficerList();
      emit(AllMedicalOfficerListState.success(allIncidentList!));
    } on ApiError catch (error) {
      emit(AllMedicalOfficerListState.failed(state.allMedicalOfficerList, error.message));
    }
  }
}

