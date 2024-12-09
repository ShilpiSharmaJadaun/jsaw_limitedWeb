import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jsaw_limited/service/employee_reporting_service.dart';
import 'package:jsaw_limited/state/insertHODEmployee_state.dart';
import '../error/api_error.dart';


class InsertHODEMPloyeeBloc extends Cubit<InsertNewHodState>{
  InsertHODEMPloyeeBloc(this.employeeReportingService): super(InsertNewHodState.initial());

  EmployeeReportingService employeeReportingService;

  Future<void> insertHod(Map<String, dynamic> data)async{
    emit(InsertNewHodState.loading(state.insertHOD));
    try{
      final message = await employeeReportingService.insertHODEmployee(data);

      emit(InsertNewHodState.success(state.insertHOD, message));
    }on ApiError catch(error){
      emit(InsertNewHodState.failed(state.insertHOD,  error.message));
    }
  }

}