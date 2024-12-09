import 'package:freezed_annotation/freezed_annotation.dart';

part 'observationstatus_model.g.dart';
part 'observationstatus_model.freezed.dart';

@freezed
class ObservationStatusModel with _$ObservationStatusModel{
  const factory ObservationStatusModel({

    @Default(0) int closed,
    @Default(0) int pending,
    @Default(0) int inProgress,
    @Default(0) int alls,
    @Default(0) int compliance,
    @Default(0.0) double closedPercentage,
    @Default(0.0) double pendingPercentage,
    @Default(0.0) double inProgressPercentage,
    @Default(0.0) double compliancePercentage,

  }) = _ObservationStatusModel;

  factory ObservationStatusModel.fromJson(Map<String, dynamic> json) => _$ObservationStatusModelFromJson(json);
}