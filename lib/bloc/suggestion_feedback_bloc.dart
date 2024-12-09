import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jsaw_limited/service/observation_service.dart';
import 'package:jsaw_limited/state/suggestion_feedback_state.dart';
import '../error/api_error.dart';


class SuggestionFeedbackBloc extends Cubit<SuggestionFeedbackState>{
  SuggestionFeedbackBloc(this.observationService): super(SuggestionFeedbackState.initial());

  final ObservationService observationService;

  Future<void> initState()async{
    emit(SuggestionFeedbackState.loading(state.suggestionFeedback));
    try{
      final message = await observationService.getSuggestionFeedbackList();

      emit(SuggestionFeedbackState.success(message));
    }on ApiError catch(error){
      emit(SuggestionFeedbackState.failed(state.suggestionFeedback,  error.message));
    }
  }

}