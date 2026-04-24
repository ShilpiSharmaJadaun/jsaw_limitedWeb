import 'package:freezed_annotation/freezed_annotation.dart';

part 'allNatureInjury_model.g.dart';
part 'allNatureInjury_model.freezed.dart';

@freezed
class AllNatureInjuryModel with _$AllNatureInjuryModel{
  const factory AllNatureInjuryModel({

    @Default(0) int id,
    @Default("") String description,

  }) = _AllNatureInjuryModel;

  factory AllNatureInjuryModel.fromJson(Map<String, dynamic> json) => _$AllNatureInjuryModelFromJson(json);
}