import 'package:freezed_annotation/freezed_annotation.dart';
import 'filterObservation_model.dart';

part 'allContractor_model.g.dart';
part 'allContractor_model.freezed.dart';

@freezed
class AllContractorModel with _$AllContractorModel{
  const factory AllContractorModel({

    @Default("") String compCode,
    @Default("") String wrkGrp,
    @Default("") String unitCode,
    @Default("") String contCode,
    @Default("") String contName,
    @Default(true) bool active,
    @Default("") String add1,
    @Default("") String add2,
    @Default("") String phone,
  }) = _AllContractorModel;

  factory AllContractorModel.fromJson(Map<String, dynamic> json) => _$AllContractorModelFromJson(json);
}