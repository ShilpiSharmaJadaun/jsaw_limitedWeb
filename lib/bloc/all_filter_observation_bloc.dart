import 'package:bloc/bloc.dart';
import 'package:jsaw_limited/service/observation_service.dart';
import 'package:jsaw_limited/state/all_filter_observation_state.dart';
import 'package:jsaw_limited/state/filterObservation_state.dart';
import '../error/api_error.dart';

class AllFilterObservationBloc extends Cubit<AllFilterObservationState> {
  AllFilterObservationBloc(this.observationService) : super(AllFilterObservationState.initial());

  late ObservationService observationService;

  Future<void> initState(int page, String stationCode, String startDate, String endDate,String location, String plantDeptCode,

      String status, String hazardCategory, String responsibilityEnggCode, String observationRaisedByEmpUnqId,
      sessionID, String uniqueId) async {
    emit(AllFilterObservationState.loading(state.filterObservation));
    try {
      final employeeResponsibility = await observationService.getAllFilterObservation(page,stationCode, startDate,
          endDate, location, plantDeptCode, status, hazardCategory,
          responsibilityEnggCode, observationRaisedByEmpUnqId, sessionID, uniqueId);

      emit(AllFilterObservationState.success(employeeResponsibility));
    } on ApiError catch (error) {
      print(error);
      emit(AllFilterObservationState.failed(state.filterObservation, error.message));
    }
  }
}

