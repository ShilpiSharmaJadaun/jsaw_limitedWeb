import 'package:freezed_annotation/freezed_annotation.dart';
import 'filterObservation_model.dart';

part 'all_filter_observation_model.g.dart';
part 'all_filter_observation_model.freezed.dart';

@freezed
class AllFilterObservationModel with _$AllFilterObservationModel{
  const factory AllFilterObservationModel({

    @Default(0) int totalPages,
    @Default(0) int totalItems,
    @Default(0) int currentPage,
    @Default("") String sessionID,
    @Default(<FilterObservationModel>[]) List<FilterObservationModel> model,
  }) = _AllFilterObservationModel;

  factory AllFilterObservationModel.fromJson(Map<String, dynamic> json) => _$AllFilterObservationModelFromJson(json);
}