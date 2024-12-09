import 'package:bloc/bloc.dart';
import 'package:jsaw_limited/service/employee_reporting_service.dart';
import 'package:jsaw_limited/state/allHod_state.dart';
import '../error/api_error.dart';

class AllHodBloc extends Cubit<AllHodState> {
  AllHodBloc(this.employeeReportingService) : super(AllHodState.initial());

  late EmployeeReportingService employeeReportingService;


  Future<void> initState(String empCode) async {
    emit(AllHodState.loading(state.allHod));
    try {
      final employeeResponsibility = await employeeReportingService.getAllHod(empCode);
      emit(AllHodState.success(employeeResponsibility!));
    } on ApiError catch (error) {
      print(error);
      emit(AllHodState.failed(state.allHod, error.message));
    }
  }
}

