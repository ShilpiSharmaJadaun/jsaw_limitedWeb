import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:jsaw_limited/model/all_filter_observation_model.dart';
import 'package:jsaw_limited/model/filterObservation_model.dart';
import 'package:jsaw_limited/service/observation_service.dart';
import 'package:jsaw_limited/state/all_filter_observation_state.dart';
import '../error/api_error.dart';

/// Loads observations for several statuses at once (the backend `filterObservation`
/// endpoint only filters ONE status per call), merges them, and paginates the
/// merged list CLIENT-SIDE. Used by the Edit tab so it can show PENDING and
/// IN PROGRESS observations together. Reuses [AllFilterObservationState] /
/// [AllFilterObservationModel] so the existing list UI works unchanged.
class EditObservationListBloc extends Cubit<AllFilterObservationState> {
  EditObservationListBloc(this.observationService)
      : super(AllFilterObservationState.initial());

  final ObservationService observationService;

  static const int pageSize = 10;

  List<FilterObservationModel> _all = const [];

  /// Fetch every row across [statuses] (with the optional filters), merge &
  /// de-duplicate them, then show the first page.
  Future<void> loadAll(
    List<String> statuses, {
    String stationCode = "",
    String startDate = "",
    String endDate = "",
    String location = "",
    String plantDeptCode = "",
    String uniqueId = "",
  }) async {
    emit(AllFilterObservationState.loading(state.filterObservation));
    try {
      _all = await observationService.getObservationsByStatuses(
        statuses,
        stationCode: stationCode,
        startDate: startDate,
        endDate: endDate,
        location: location,
        plantDeptCode: plantDeptCode,
        uniqueId: uniqueId,
      );
      emitPage(0);
    } on ApiError catch (error) {
      emit(AllFilterObservationState.failed(state.filterObservation, error.message));
    }
  }

  /// Emit one client-side page ([pageSize] rows) of the already-loaded list.
  void emitPage(int page) {
    final totalItems = _all.length;
    final totalPages = totalItems == 0 ? 0 : (totalItems / pageSize).ceil();
    final start = page * pageSize;
    final items = start >= totalItems
        ? const <FilterObservationModel>[]
        : _all.sublist(start, min(start + pageSize, totalItems));
    emit(AllFilterObservationState.success(AllFilterObservationModel(
      model: items,
      totalItems: totalItems,
      totalPages: totalPages,
      currentPage: page,
    )));
  }
}
