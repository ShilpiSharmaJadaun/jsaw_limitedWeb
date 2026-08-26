import 'package:bloc/bloc.dart';
import 'package:jsaw_limited/pages/widgets/incident_filter.dart';
import 'package:jsaw_limited/service/incident_service.dart';
import 'package:jsaw_limited/state/allIncident_state.dart';
import '../error/api_error.dart';

/// Paginated incident list for one tab of the All Incident page.
///
/// Two layers of filtering are sent on every fetch:
///  * the fixed **tab scope** ([raisedByEmpCode] / [employeeCode]) chosen at
///    construction — Raised Incident / Received Incident / All (both blank);
///  * the user-chosen [filter] from the filter dialog (Phase-2 point 2).
class AllIncidentbloc extends Cubit<AllIncidentState> {
  AllIncidentbloc(
    this.incidentService, {
    this.raisedByEmpCode = '',
    this.employeeCode = '',
  }) : super(AllIncidentState.initial());

  final IncidentService incidentService;
  final String raisedByEmpCode;
  final String employeeCode;

  // Pagination state — read by the UI to render the page indicator/controls.
  int currentPage = 1;
  int totalPages = 1;
  int totalElements = 0;
  int pageSize = 10;
  bool hasNext = false;
  bool hasPrevious = false;

  /// Active user filter; preserved across page changes.
  IncidentFilter filter = IncidentFilter.empty;

  /// First load (or reload from page 1 with the current filter).
  Future<void> load() => _fetch(1);

  /// Apply a new filter and jump back to page 1.
  Future<void> applyFilter(IncidentFilter newFilter) async {
    filter = newFilter;
    await _fetch(1);
  }

  Future<void> clearFilter() => applyFilter(IncidentFilter.empty);

  /// Re-fetch the current page (same filter).
  Future<void> refresh() => _fetch(currentPage < 1 ? 1 : currentPage);

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
        filter: filter,
        raisedByEmpCode: raisedByEmpCode,
        employeeCode: employeeCode,
        page: page,
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
      // The backend reports "no rows" as a failure; surface it as an empty
      // list so the UI shows the tab's empty state instead of an error.
      if (error.message.toLowerCase().contains('no incident')) {
        currentPage = 1;
        totalPages = 0;
        totalElements = 0;
        hasNext = false;
        hasPrevious = false;
        emit(AllIncidentState.success(const []));
        return;
      }
      emit(AllIncidentState.failed(state.allIncident, error.message));
    }
  }
}
