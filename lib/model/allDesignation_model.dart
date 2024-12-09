import 'package:freezed_annotation/freezed_annotation.dart';

part 'allDesignation_model.g.dart';
part 'allDesignation_model.freezed.dart';

@freezed
class AllDesignationModel with _$AllDesignationModel{
  const factory AllDesignationModel({

    @Default("") String designation_code,
    @Default("") String designation_name,
    @Default("") String wrkGrp,

  }) = _AllDesignationModel;

  factory AllDesignationModel.fromJson(Map<String, dynamic> json) => _$AllDesignationModelFromJson(json);
}