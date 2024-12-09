import 'package:freezed_annotation/freezed_annotation.dart';

part 'observation_status_List_model.g.dart';
part 'observation_status_List_model.freezed.dart';

@freezed
class ObservationStatusListModel with _$ObservationStatusListModel{
  const factory ObservationStatusListModel({

    @Default(0.0) double percentage,
    @Default(0) int count,
    @Default("") String name,

  }) = _ObservationStatusListModel;

  factory ObservationStatusListModel.fromJson(Map<String, dynamic> json) => _$ObservationStatusListModelFromJson(json);
}