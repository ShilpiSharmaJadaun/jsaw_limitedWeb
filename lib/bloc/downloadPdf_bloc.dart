import 'package:bloc/bloc.dart';
import 'package:jsaw_limited/service/incident_service.dart';
import 'package:jsaw_limited/state/downloadPdf_state.dart';
import '../error/api_error.dart';

class DownloadPdfBloc extends Cubit<DownloadPdfState> {
  DownloadPdfBloc(this.incidentService) : super(DownloadPdfState.initial());

  late IncidentService incidentService;

  Future<void> downloadByUid(String uniqueId) async {
    if (uniqueId.isEmpty) {
      emit(DownloadPdfState.failed(
          uniqueId, 'PDF is not available for this record.'));
      return;
    }
    try {
      emit(DownloadPdfState.loading(uniqueId));
      final bytes = await incidentService.downloadFirPdfByUid(uniqueId);
      if (bytes == null || bytes.isEmpty) {
        emit(DownloadPdfState.failed(uniqueId, 'Failed to download PDF.'));
        return;
      }
      emit(DownloadPdfState.success(uniqueId, bytes));
    } on ApiError catch (error) {
      emit(DownloadPdfState.failed(uniqueId, error.message));
    } catch (e) {
      emit(DownloadPdfState.failed(uniqueId, e.toString()));
    }
  }
}
