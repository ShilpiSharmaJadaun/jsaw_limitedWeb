import 'package:bloc/bloc.dart';
import 'package:jsaw_limited/service/observation_service.dart';
import 'package:jsaw_limited/state/approve_compliance_state.dart';
import '../error/api_error.dart';

class ApproveComplianceBloc extends Cubit<ApproveComplianceState>{
  ApproveComplianceBloc(this.observationService): super(ApproveComplianceState.initial());

  late ObservationService observationService;

  Future<void> initState()async {
    try{
      emit(ApproveComplianceState.loading(state.complianceModel));

      final complianceList = await observationService.getComplianceList();

      emit(ApproveComplianceState.success(complianceList));
    }on ApiError catch (error) {
      emit(ApproveComplianceState.failed(state.complianceModel, error.message));
    }
  }
}