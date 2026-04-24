import 'package:freezed_annotation/freezed_annotation.dart';
import 'filterObservation_model.dart';

part 'allBodyParts_model.g.dart';
part 'allBodyParts_model.freezed.dart';

@freezed
class AllBodyPartsModel with _$AllBodyPartsModel{
  const factory AllBodyPartsModel({

    @Default(0) int id,
    @Default("") String description,
  }) = _AllBodyPartsModel;

  factory AllBodyPartsModel.fromJson(Map<String, dynamic> json) => _$AllBodyPartsModelFromJson(json);
}