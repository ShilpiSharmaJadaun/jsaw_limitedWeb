import 'package:bloc/bloc.dart';
import 'package:jsaw_limited/service/employee_reporting_service.dart';
import 'package:jsaw_limited/service/incident_service.dart';
import 'package:jsaw_limited/state/allHod_state.dart';
import 'package:jsaw_limited/state/allNatureInjury_state.dart';
import '../error/api_error.dart';

class AllNatureInjuryBloc extends Cubit<AllNatureInjuryState> {
  AllNatureInjuryBloc(this.incidentService) : super(AllNatureInjuryState.initial());

  late IncidentService incidentService;


  Future<void> initState() async {
    emit(AllNatureInjuryState.loading(state.allNatureInjury));
    try {
      final employeeResponsibility = await incidentService.getAllNatureInjuryDetail();
      emit(AllNatureInjuryState.success(employeeResponsibility!));
    } on ApiError catch (error) {
      emit(AllNatureInjuryState.failed(state.allNatureInjury, error.message));
    }
  }
}

