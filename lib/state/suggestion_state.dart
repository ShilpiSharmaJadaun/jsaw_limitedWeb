import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jsaw_limited/model/save_suggestionModel.dart';
import 'package:jsaw_limited/model/update_observation_model.dart';

part 'suggestion_state.freezed.dart';

@freezed
class SaveSuggestionState with _$SaveSuggestionState {
  const factory SaveSuggestionState.loading(SaveSuggestionModel saveSuggestion) = _Loading;
  const factory SaveSuggestionState.content(SaveSuggestionModel saveSuggestion) = _Content;
  const factory SaveSuggestionState.success(SaveSuggestionModel saveSuggestion, String? message) = _Success;
  const factory SaveSuggestionState.failed(SaveSuggestionModel saveSuggestion, String message) =
  _Failed;

  factory SaveSuggestionState.initial() => SaveSuggestionState.content(SaveSuggestionModel());
}