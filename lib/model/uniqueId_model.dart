import 'package:freezed_annotation/freezed_annotation.dart';

part 'uniqueId_model.g.dart';
part 'uniqueId_model.freezed.dart';

@freezed
class UniqueIdModel with _$UniqueIdModel{
  const factory UniqueIdModel({

    @Default("") String uniqueIdentificationNumber,

  }) = _UniqueIdModel;

  factory UniqueIdModel.fromJson(Map<String, dynamic> json) => _$UniqueIdModelFromJson(json);
}