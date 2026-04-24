// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'allContractor_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AllContractorModelImpl _$$AllContractorModelImplFromJson(
        Map<String, dynamic> json) =>
    _$AllContractorModelImpl(
      compCode: json['compCode'] as String? ?? "",
      wrkGrp: json['wrkGrp'] as String? ?? "",
      unitCode: json['unitCode'] as String? ?? "",
      contCode: json['contCode'] as String? ?? "",
      contName: json['contName'] as String? ?? "",
      active: json['active'] as bool? ?? true,
      add1: json['add1'] as String? ?? "",
      add2: json['add2'] as String? ?? "",
      phone: json['phone'] as String? ?? "",
    );

Map<String, dynamic> _$$AllContractorModelImplToJson(
        _$AllContractorModelImpl instance) =>
    <String, dynamic>{
      'compCode': instance.compCode,
      'wrkGrp': instance.wrkGrp,
      'unitCode': instance.unitCode,
      'contCode': instance.contCode,
      'contName': instance.contName,
      'active': instance.active,
      'add1': instance.add1,
      'add2': instance.add2,
      'phone': instance.phone,
    };
