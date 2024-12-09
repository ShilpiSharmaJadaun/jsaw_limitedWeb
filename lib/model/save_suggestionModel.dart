import 'package:freezed_annotation/freezed_annotation.dart';

part 'save_suggestionModel.g.dart';
part 'save_suggestionModel.freezed.dart';

@freezed
class SaveSuggestionModel with _$SaveSuggestionModel{
  const factory SaveSuggestionModel({

    @Default("") String status,
    @Default("") String msg,

  }) = _SaveSuggestionModel;

  factory SaveSuggestionModel.fromJson(Map<String, dynamic> json) => _$SaveSuggestionModelFromJson(json);
}