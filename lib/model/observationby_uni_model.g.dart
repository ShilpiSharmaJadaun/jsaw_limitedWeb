// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'observationby_uni_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ObservationbyUniModelImpl _$$ObservationbyUniModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ObservationbyUniModelImpl(
      id: (json['id'] as num?)?.toInt() ?? 0,
      uniqueIdentificationNumber:
          json['uniqueIdentificationNumber'] as String? ?? "",
      observationText: json['observationText'] as String? ?? "",
      actionTaken: json['actionTaken'] as String? ?? "",
      status: json['status'] as String? ?? "",
      remarks: json['remarks'] as String? ?? "",
      imageCompliance: json['imageCompliance'] as String? ?? "",
      updatedDate: json['updatedDate'] as String? ?? "",
      updatedByEmpId: json['updatedByEmpId'] as String? ?? "",
      updatedByEmpName: json['updatedByEmpName'] as String? ?? "",
    );

Map<String, dynamic> _$$ObservationbyUniModelImplToJson(
        _$ObservationbyUniModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uniqueIdentificationNumber': instance.uniqueIdentificationNumber,
      'observationText': instance.observationText,
      'actionTaken': instance.actionTaken,
      'status': instance.status,
      'remarks': instance.remarks,
      'imageCompliance': instance.imageCompliance,
      'updatedDate': instance.updatedDate,
      'updatedByEmpId': instance.updatedByEmpId,
      'updatedByEmpName': instance.updatedByEmpName,
    };
