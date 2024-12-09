import 'package:freezed_annotation/freezed_annotation.dart';

part 'priorityUpdate_model.g.dart';
part 'priorityUpdate_model.freezed.dart';

@freezed
class PriorityUpdateModel with _$PriorityUpdateModel{
  const factory PriorityUpdateModel({

    @Default("") String status,
    @Default("") String msg,

  }) = _PriorityUpdateModel;

  factory PriorityUpdateModel.fromJson(Map<String, dynamic> json) => _$PriorityUpdateModelFromJson(json);
}