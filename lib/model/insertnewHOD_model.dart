import 'package:freezed_annotation/freezed_annotation.dart';

part 'insertnewHOD_model.g.dart';
part 'insertnewHOD_model.freezed.dart';

@freezed
class InsertNewHodModel with _$InsertNewHodModel{
  const factory InsertNewHodModel({
    @Default("") String status,
    @Default("") String message,
  }) = _InsertNewHodModel;

  factory InsertNewHodModel.fromJson(Map<String, dynamic> json) => _$InsertNewHodModelFromJson(json);
}