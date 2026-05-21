import 'package:bloc/bloc.dart';
import 'package:jsaw_limited/service/observation_service.dart';
import 'package:jsaw_limited/state/employeeResponsibility_state.dart';
import '../error/api_error.dart';
import '../main.dart';
import 'package:web/web.dart' show window;

class EmployeeResponsibilityBloc extends Cubit<EmployeeResponsibilityState> {
  EmployeeResponsibilityBloc(this.observationService) : super(EmployeeResponsibilityState.initial());

  late ObservationService observationService;

  final employeeCode = window.localStorage.getItem('kEmployeeCode') ?? "";

  Future<void> initState(String deptCode, String stateCode, String designationCode) async {
    emit(EmployeeResponsibilityState.loading(state.responsibility));
    try {
      final employeeResponsibility = await observationService.getResponsibilityEmployee(deptCode, stateCode,designationCode, employeeCode);
      emit(EmployeeResponsibilityState.success(employeeResponsibility));
    } on ApiError catch (error) {
      print(error);
      emit(EmployeeResponsibilityState.failed(state.responsibility, error.message));
    }
  }
}

