import 'package:bloc/bloc.dart';
import 'package:jsaw_limited/service/observation_service.dart';
import 'package:jsaw_limited/state/allwork_group_state.dart';
import '../error/api_error.dart';

class AllWorkGroupBloc extends Cubit<AllWorkGroupState>{
  AllWorkGroupBloc(this.observationService): super(AllWorkGroupState.initial());

  late ObservationService observationService;

  Future<void> initState()async {
    try{
      emit(AllWorkGroupState.loading(state.allworkGroup));
      final divisionList = await observationService.getAllWorkGroup();
      emit(AllWorkGroupState.success(divisionList));
    }on ApiError catch (error) {
      emit(AllWorkGroupState.failed(state.allworkGroup, error.message));
    }
  }
}