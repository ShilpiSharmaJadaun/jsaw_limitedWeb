import 'package:freezed_annotation/freezed_annotation.dart';

part 'userwise_tablegraph_model.g.dart';
part 'userwise_tablegraph_model.freezed.dart';

@freezed
class UserWiseTableGraphModel with _$UserWiseTableGraphModel{
  const factory UserWiseTableGraphModel({
    @Default("") String empUnqId,
    @Default("") String empName,
    @Default(0) int totalRaised,
    @Default(0) int totalReceived,
    @Default(0) int totalPendingRaised,
    @Default(0) int totalClosedRaised,
    @Default("") String designationCode,
    @Default("") String designationName,
    @Default("") String departmentName,
  }) = _UserWiseTableGraphModel;

  factory UserWiseTableGraphModel.fromJson(Map<String, dynamic> json) => _$UserWiseTableGraphModelFromJson(json);
}