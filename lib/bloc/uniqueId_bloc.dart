import 'package:bloc/bloc.dart';
import 'package:jsaw_limited/service/observation_service.dart';
import '../error/api_error.dart';
import '../state/uniqueId_state.dart';

class UniqueIdBloc extends Cubit<UniqueIdState>{
  UniqueIdBloc(this.observationService): super(UniqueIdState.initial());

  late ObservationService observationService;

  /// Scoping precedence:
  /// - [responsibilityEnggCode] non-empty → observations received by that engineer (Received tab).
  /// - [observationRaisedByEmpUnqId] non-empty → observations raised by that employee (Raised tab).
  /// - [statuses] non-empty → observations in those statuses, e.g. PENDING / IN PROGRESS (Edit tab).
  /// - none → full, system-wide list (All / other tabs, unchanged behaviour).
  Future<void> initState({String? responsibilityEnggCode, String? observationRaisedByEmpUnqId, List<String>? statuses})async {
    try{
      emit(UniqueIdState.loading(state.uniqueId));
      final divisionList = (responsibilityEnggCode != null && responsibilityEnggCode.isNotEmpty)
          ? await observationService.getReceivedUniqueIdList(responsibilityEnggCode)
          : (observationRaisedByEmpUnqId != null && observationRaisedByEmpUnqId.isNotEmpty)
              ? await observationService.getRaisedUniqueIdList(observationRaisedByEmpUnqId)
              : (statuses != null && statuses.isNotEmpty)
                  ? await observationService.getUniqueIdListByStatuses(statuses)
                  : await observationService.getUniqueIdList();
      emit(UniqueIdState.success(divisionList));
    }on ApiError catch (error) {
      emit(UniqueIdState.failed(state.uniqueId, error.message));
    }
  }
}