import 'package:bloc/bloc.dart';
import 'package:jsaw_limited/service/observation_service.dart';
import 'package:jsaw_limited/state/employeeResponsibility_state.dart';
import 'package:jsaw_limited/state/filterObservation_state.dart';
import '../error/api_error.dart';

class FilterObservationBloc extends Cubit<FilterObservationState> {
  FilterObservationBloc(this.observationService) : super(FilterObservationState.initial());

  late ObservationService observationService;

  Future<void> initState(int page, String stationCode, String startDate, String endDate,String location, String plantDeptCode,

      String status, String hazardCategory, String responsibilityEnggCode, String observationRaisedByEmpUnqId) async {
    emit(FilterObservationState.loading(state.filterObservation));
    try {
      final employeeResponsibility = await observationService.getFilterObservation( page,stationCode, startDate,
          endDate, location, plantDeptCode, status, hazardCategory,
          responsibilityEnggCode, observationRaisedByEmpUnqId);
      emit(FilterObservationState.success(employeeResponsibility));
    } on ApiError catch (error) {
      print(error);
      emit(FilterObservationState.failed(state.filterObservation, error.message));
    }
  }
}

