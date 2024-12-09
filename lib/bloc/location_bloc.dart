import 'package:bloc/bloc.dart';
import 'package:jsaw_limited/service/observation_service.dart';
import 'package:jsaw_limited/state/location_state.dart';
import '../error/api_error.dart';

class LocationBloc extends Cubit<LocationState>{
  LocationBloc(this.observationService): super(LocationState.initial());

  late ObservationService observationService;

  Future<void> initState(String deptCode)async {
    try{
      emit(LocationState.loading(state.locationModel));
      final locationList = await observationService.getAllLocation(deptCode);
      emit(LocationState.success(locationList));
    }on ApiError catch (error) {
      emit(LocationState.failed(state.locationModel, error.message));
    }
  }
}