import 'package:bloc/bloc.dart';
import 'package:jsaw_limited/service/observation_service.dart';
import 'package:jsaw_limited/state/generateExcel_state.dart';
import '../error/api_error.dart';

class GenerateExcelBloc extends Cubit<GenerateExcelState>{
  GenerateExcelBloc(this.observationService): super(GenerateExcelState.initial());

  late ObservationService observationService;

  Future<void> initState(String sessionID)async {
    try{
      emit(GenerateExcelState.loading(state.generateExcel));
      final generateExcel = await observationService.generateExcel(sessionID);
      emit(GenerateExcelState.success(generateExcel!, generateExcel.url));
    }on ApiError catch (error) {
      emit(GenerateExcelState.failed(state.generateExcel, error.message));
    }
  }
}