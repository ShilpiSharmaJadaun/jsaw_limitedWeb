import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jsaw_limited/service/employee_reporting_service.dart';
import 'package:jsaw_limited/state/updateHod_state.dart';
import '../error/api_error.dart';


class UpdateHodBloc extends Cubit<UpdateHodState>{
  UpdateHodBloc(this.employeeReportingService): super(UpdateHodState.initial());

  EmployeeReportingService employeeReportingService;

  Future<void> forgetPassword(Map<String, dynamic> data)async{
    emit(UpdateHodState.loading(state.updateHod));
    try{
      final message = await employeeReportingService.updateHod(data);

      emit(UpdateHodState.success(state.updateHod, message));
    }on ApiError catch(error){
      emit(UpdateHodState.failed(state.updateHod,  error.message));
    }
  }

}