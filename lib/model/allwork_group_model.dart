import 'package:freezed_annotation/freezed_annotation.dart';

part 'allwork_group_model.g.dart';
part 'allwork_group_model.freezed.dart';

@freezed
class AllWorkGroupModel with _$AllWorkGroupModel{
  const factory AllWorkGroupModel({

    @Default("") String wrkGrp,
    @Default("") String wrkGrpDesc,

  }) = _AllWorkGroupModel;

  factory AllWorkGroupModel.fromJson(Map<String, dynamic> json) => _$AllWorkGroupModelFromJson(json);
}