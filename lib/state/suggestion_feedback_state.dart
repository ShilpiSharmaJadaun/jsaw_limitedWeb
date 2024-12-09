import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jsaw_limited/model/raised_feedback_model.dart';

part 'suggestion_feedback_state.freezed.dart';

@freezed
class SuggestionFeedbackState with _$SuggestionFeedbackState{

  const factory SuggestionFeedbackState.loading (List<SuggestionFeedbackModel> suggestionFeedback) = _Loading;
  const factory SuggestionFeedbackState.content (List<SuggestionFeedbackModel> suggestionFeedback) = _Content;
  const factory SuggestionFeedbackState.success (List<SuggestionFeedbackModel> suggestionFeedback) = _Success;
  const factory SuggestionFeedbackState.failed (List<SuggestionFeedbackModel> suggestionFeedback, String msg) = _Failed;

  factory SuggestionFeedbackState.initial() => SuggestionFeedbackState.content([]);

}