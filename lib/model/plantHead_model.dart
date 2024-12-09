import 'package:freezed_annotation/freezed_annotation.dart';

part 'plantHead_model.g.dart';
part 'plantHead_model.freezed.dart';

@freezed
class PlantHeadModel with _$PlantHeadModel{
  const factory PlantHeadModel({

    @Default("") String plantCode,
    @Default("") String plantName,
    @Default("") String empName,
    @Default("") String empUnqId,
    @Default("") String empEmail,

  }) = _PlantHeadModel;

  factory PlantHeadModel.fromJson(Map<String, dynamic> json) => _$PlantHeadModelFromJson(json);
}