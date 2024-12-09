import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jsaw_limited/service/employee_reporting_service.dart';
import 'package:jsaw_limited/state/deleteHOD_state.dart';
import '../error/api_error.dart';


class DeleteHODBloc extends Cubit<DeleteHODState>{
  DeleteHODBloc(this.employeeReportingService): super(DeleteHODState.initial());

  EmployeeReportingService employeeReportingService;

  Future<void> forgetPassword(Map<String, dynamic> data)async{
    emit(DeleteHODState.loading(state.deleteHOD));
    try{
      final message = await employeeReportingService.deleteHODEmployee(data);

      emit(DeleteHODState.success(state.deleteHOD, message));
    }on ApiError catch(error){
      emit(DeleteHODState.failed(state.deleteHOD,  error.message));
    }
  }

}