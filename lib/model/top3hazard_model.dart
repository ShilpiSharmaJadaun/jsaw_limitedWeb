import 'package:freezed_annotation/freezed_annotation.dart';

part 'top3hazard_model.g.dart';
part 'top3hazard_model.freezed.dart';

@freezed
class Top3HazardModel with _$Top3HazardModel{
  const factory Top3HazardModel({

    @Default("") String hazardCategory,
    @Default(0) int count,

  }) = _Top3HazardModel;

  factory Top3HazardModel.fromJson(Map<String, dynamic> json) => _$Top3HazardModelFromJson(json);
}