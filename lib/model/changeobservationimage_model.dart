import 'package:freezed_annotation/freezed_annotation.dart';

part 'changeobservationimage_model.g.dart';
part 'changeobservationimage_model.freezed.dart';

@freezed
class ChangeObservationImageModel with _$ChangeObservationImageModel{
  const factory ChangeObservationImageModel({

    @Default("") String status,
    @Default("") String msg,
    @Default("") String url,

  }) = _ChangeObservationImageModel;

  factory ChangeObservationImageModel.fromJson(Map<String, dynamic> json) => _$ChangeObservationImageModelFromJson(json);
}