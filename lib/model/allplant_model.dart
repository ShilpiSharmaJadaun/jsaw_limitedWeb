import 'package:freezed_annotation/freezed_annotation.dart';

part 'allplant_model.g.dart';
part 'allplant_model.freezed.dart';

@freezed
class AllPlantModel with _$AllPlantModel{
  const AllPlantModel._();

  const factory AllPlantModel({

    @Default('') String deptCode,
    @Default('') String deptName,
    @Default(0) int unitCode,
    @Default('') String workGroup,
    @Default('') String location,

  }) = _AllPlantModel;

  factory AllPlantModel.fromJson(Map<String, dynamic> json) => _$AllPlantModelFromJson(json);

  bool  isSearched(String query){
    return deptName.contains(query.toLowerCase());
  }
}