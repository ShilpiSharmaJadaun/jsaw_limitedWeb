import 'package:bloc/bloc.dart';
import 'package:jsaw_limited/service/incident_service.dart';
import 'package:jsaw_limited/state/allIncident_state.dart';
import '../error/api_error.dart';

class AllIncidentbloc extends Cubit<AllIncidentState> {
  AllIncidentbloc(this.incidentService) : super(AllIncidentState.initial());

  final IncidentService incidentService;

  // Pagination state — read by the UI to render the page indicator/controls.
  int currentPage = 1;
  int totalPages = 1;
  int totalElements = 0;
  int pageSize = 10;
  bool hasNext = false;
  bool hasPrevious = false;

  // Filter values are kept so that page changes preserve the active filters.
  String _uniqueId = '';
  String _plant = '';
  String _deptName = '';
  String _responsibleShiftEngg = '';
  String _status = '';
  String _firDateTimeFrom = '';
  String _firDateTimeTo = '';

  Future<void> initState(
    String uniqueId,
    String plant,
    String deptName,
    String responsibleShiftEngg,
    String status,
    String firDateTimeFrom,
    String firDateTimeTo,
    int page,
  ) async {
    _uniqueId = uniqueId;
    _plant = plant;
    _deptName = deptName;
    _responsibleShiftEngg = responsibleShiftEngg;
    _status = status;
    _firDateTimeFrom = firDateTimeFrom;
    _firDateTimeTo = firDateTimeTo;
    await _fetch(page);
  }

  Future<void> nextPage() async {
    if (hasNext) await _fetch(currentPage + 1);
  }

  Future<void> previousPage() async {
    if (hasPrevious) await _fetch(currentPage - 1);
  }

  Future<void> goToPage(int page) async {
    if (page >= 1 && page <= totalPages && page != currentPage) {
      await _fetch(page);
    }
  }

  Future<void> _fetch(int page) async {
    emit(AllIncidentState.loading(state.allIncident));
    try {
      final result = await incidentService.getAllIncident(
        _uniqueId,
        _plant,
        _deptName,
        _responsibleShiftEngg,
        _status,
        _firDateTimeFrom,
        _firDateTimeTo,
        page,
        pageSize: pageSize,
      );
      currentPage = result.currentPage;
      totalPages = result.totalPages;
      totalElements = result.totalElements;
      pageSize = result.pageSize;
      hasNext = result.hasNext;
      hasPrevious = result.hasPrevious;
      emit(AllIncidentState.success(result.items));
    } on ApiError catch (error) {
      emit(AllIncidentState.failed(state.allIncident, error.message));
    }
  }
}