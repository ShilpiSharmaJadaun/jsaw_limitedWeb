import 'package:freezed_annotation/freezed_annotation.dart';

part 'graph2_station_model.g.dart';
part 'graph2_station_model.freezed.dart';

@freezed
class Graph2StationModel with _$Graph2StationModel{
  const factory Graph2StationModel({

    @Default('') String name,
    @Default('') String code,
    @Default('') String count,

  }) = _Graph2StationModel;

  factory Graph2StationModel.fromJson(Map<String, dynamic> json) => _$Graph2StationModelFromJson(json);

}