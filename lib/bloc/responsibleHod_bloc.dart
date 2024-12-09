import 'package:bloc/bloc.dart';
import 'package:jsaw_limited/service/observation_service.dart';
import 'package:jsaw_limited/state/responsibleHOD_state.dart';
import '../error/api_error.dart';

class ResponsibleHODBloc extends Cubit<ResponsibleHODState> {
  ResponsibleHODBloc(this.observationService) : super(ResponsibleHODState.initial());

  late ObservationService observationService;

  Future<void> initState(String deptCode, String stateCode,String designationCode,String responsibleEnggCode) async {
    emit(ResponsibleHODState.loading(state.responsibility));
    try {
      final employeeResponsibility = await observationService.getResponsibleHOD(deptCode, stateCode, designationCode, responsibleEnggCode);
      emit(ResponsibleHODState.success(employeeResponsibility));
    } on ApiError catch (error) {
      print(error);
      emit(ResponsibleHODState.failed(state.responsibility, error.message));
    }
  }
}

