import 'dart:typed_data';
import 'package:bloc/bloc.dart';
import '../service/observation_service.dart';
import '../error/api_error.dart';
import '../state/suggestion_state.dart';


class SaveSuggestionBloc extends Cubit<SaveSuggestionState> {
  SaveSuggestionBloc(this.observationService) : super(SaveSuggestionState.initial());

  final ObservationService observationService;

  Future<void> saveSuggestion(
      Uint8List fileBytes,
      String issueTitle,
      String issueDescription,
      String dateTimeOfOccurrence,
      String softwareVersion,
      String operatingSystem,
      String severity,
      String empUnId,
      String empName,
      String status,
      ) async {
    emit(SaveSuggestionState.loading(state.saveSuggestion));
    try {
      final msg = await observationService.getSuggestion(fileBytes, issueTitle, issueDescription, dateTimeOfOccurrence, softwareVersion, operatingSystem, severity, empUnId, empName, status);
      emit(SaveSuggestionState.success(state.saveSuggestion, msg!));
    } on ApiError catch (error) {
      print(error);
      emit(SaveSuggestionState.failed(state.saveSuggestion, error.message));
    } catch (e) {
      print(e);
      emit(SaveSuggestionState.failed(state.saveSuggestion, e.toString()));
    }
  }
}
