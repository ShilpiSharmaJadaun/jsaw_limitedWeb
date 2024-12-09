import 'package:freezed_annotation/freezed_annotation.dart';

part 'deleteHOD_model.g.dart';
part 'deleteHOD_model.freezed.dart';

@freezed
class DeleteHODModel with _$DeleteHODModel{
  const factory DeleteHODModel({
    @Default("") String status,
    @Default("") String message,
  }) = _DeleteHODModel;

  factory DeleteHODModel.fromJson(Map<String, dynamic> json) => _$DeleteHODModelFromJson(json);
}