import 'package:bloc/bloc.dart';
import 'package:jsaw_limited/service/employee_reporting_service.dart';
import 'package:jsaw_limited/service/incident_service.dart';
import 'package:jsaw_limited/state/allHod_state.dart';
import 'package:jsaw_limited/state/allNatureInjury_state.dart';
import '../error/api_error.dart';
import '../state/allTypeIncident_state.dart';

class AllTypeIncidentBloc extends Cubit<AllTypeIncidentState>{
  AllTypeIncidentBloc(this.incidentService): super(AllTypeIncidentState.initial());

  late IncidentService incidentService;

  Future<void> initState() async {
    try {
      emit(AllTypeIncidentState.loading(state.allTypeIncident));
      final allTypeIncident = await incidentService.getAllTypeOfIncident();
      emit(AllTypeIncidentState.success(allTypeIncident));
    } on ApiError catch (error) {
      emit(AllTypeIncidentState.failed(state.allTypeIncident, error.message));
    } catch (error, stack) {
      print('AllTypeIncident UNEXPECTED ERROR: $error');
      print(stack);
      emit(AllTypeIncidentState.failed(state.allTypeIncident, error.toString()));
    }
  }
}
