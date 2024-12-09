import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jsaw_limited/service/observation_service.dart';
import 'package:jsaw_limited/state/complainceApproveReject_state.dart';
import '../error/api_error.dart';


class ComplainceApproveRejectBloc extends Cubit<ComplainceApproveRejectState>{
  ComplainceApproveRejectBloc(this.observationService): super(ComplainceApproveRejectState.initial());

  final ObservationService observationService;

  Future<void> updateObservation(Map<String, dynamic> data)async{
    emit(ComplainceApproveRejectState.loading(state.complianceModel));
    try{
      final message = await observationService.getComplianceApproveReject(data);

      emit(ComplainceApproveRejectState.success(state.complianceModel, message));
    }on ApiError catch(error){
      emit(ComplainceApproveRejectState.failed(state.complianceModel,  error.message));
    }
  }

}