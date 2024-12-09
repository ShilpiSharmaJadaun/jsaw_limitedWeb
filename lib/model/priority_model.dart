import 'package:freezed_annotation/freezed_annotation.dart';

part 'priority_model.g.dart';
part 'priority_model.freezed.dart';

@freezed
class PriorityModel with _$PriorityModel{
  const factory PriorityModel({

    @Default(0) int id,
    @Default("") String priorityStatusName,
    @Default("") String priorityStatusColour,
    @Default("") String priorityStatusDeadline,
  }) = _PriorityModel;

  factory PriorityModel.fromJson(Map<String, dynamic> json) => _$PriorityModelFromJson(json);
}