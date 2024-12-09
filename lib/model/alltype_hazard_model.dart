import 'package:freezed_annotation/freezed_annotation.dart';

part 'alltype_hazard_model.g.dart';
part 'alltype_hazard_model.freezed.dart';

@freezed
class AllTypeHazardModel with _$AllTypeHazardModel{
  const factory AllTypeHazardModel({

    @Default(0) int id,
    @Default("") String categoryName,

  }) = _AllTypeHazardModel;

  factory AllTypeHazardModel.fromJson(Map<String, dynamic> json) => _$AllTypeHazardModelFromJson(json);
}