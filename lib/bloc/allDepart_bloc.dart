import 'package:bloc/bloc.dart';
import 'package:jsaw_limited/service/observation_service.dart';
import 'package:jsaw_limited/state/allDepart_state.dart';
import '../error/api_error.dart';

class AllDepartBloc extends Cubit<AllDepartState>{
  AllDepartBloc(this.observationService): super(AllDepartState.initial());

  late ObservationService observationService;

  Future<void> initState(String deptCode)async {
    try{
      emit(AllDepartState.loading(state.allDepartModel));
      final allDepartlist = await observationService.getDepartment(deptCode);
      emit(AllDepartState.success(allDepartlist));
    }on ApiError catch (error) {
      emit(AllDepartState.failed(state.allDepartModel, error.message));
    }
  }
}