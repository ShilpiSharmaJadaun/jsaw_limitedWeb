import 'package:bloc/bloc.dart';
import 'package:jsaw_limited/service/employee_reporting_service.dart';
import 'package:jsaw_limited/service/incident_service.dart';
import 'package:jsaw_limited/state/allHod_state.dart';
import 'package:jsaw_limited/state/allMedicalOfficerList_state.dart';
import 'package:jsaw_limited/state/allNatureInjury_state.dart';
import 'package:jsaw_limited/state/safetyRemarkList_state.dart';
import '../error/api_error.dart';

class SafetyRemarkListBloc extends Cubit<SafetyRemarkListState> {
  SafetyRemarkListBloc(this.incidentService) : super(SafetyRemarkListState.initial());

  late IncidentService incidentService;


  Future<void> initState() async {
    emit(SafetyRemarkListState.loading(state.safetyRemarkListModel));
    try {
      final allSafetyRemarkList = await incidentService.getSafetyRemarkList();
      emit(SafetyRemarkListState.success(allSafetyRemarkList!));
    } on ApiError catch (error) {
      emit(SafetyRemarkListState.failed(state.safetyRemarkListModel, error.message));
    }
  }

  void removeByIncidentUniqueId(String incidentUniqueId) {
    final updated = state.safetyRemarkListModel
        .where((item) => item.incidentUniqueId != incidentUniqueId)
        .toList();
    emit(SafetyRemarkListState.success(updated));
  }
}

