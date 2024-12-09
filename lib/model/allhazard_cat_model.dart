import 'package:freezed_annotation/freezed_annotation.dart';

part 'allhazard_cat_model.g.dart';
part 'allhazard_cat_model.freezed.dart';

@freezed
class AllHazardCatModel with _$AllHazardCatModel{
  const factory AllHazardCatModel({

    @Default("") String hazardCategoryName,

  }) = _AllHazardCatModel;

  factory AllHazardCatModel.fromJson(Map<String, dynamic> json) => _$AllHazardCatModelFromJson(json);
}