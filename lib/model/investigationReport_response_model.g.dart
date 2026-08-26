// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'investigationReport_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$InvestigationReportResponseImpl _$$InvestigationReportResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$InvestigationReportResponseImpl(
      id: (json['id'] as num?)?.toInt() ?? 0,
      incidentReportId: (json['incidentReportId'] as num?)?.toInt() ?? 0,
      incidentUniqueId: json['incidentUniqueId'] as String? ?? "",
      reportDate: json['reportDate'] as String? ?? "",
      associatedRiskImageUrl: json['associatedRiskImageUrl'] as String? ?? "",
      lowQualityImageUrl: json['lowQualityImageUrl'] as String? ?? "",
      highQualityImageUrl: json['highQualityImageUrl'] as String? ?? "",
      machineryDetails: json['machineryDetails'] as String? ?? "",
      activityBeforeIncident: json['activityBeforeIncident'] as String? ?? "",
      raisedDate: json['raisedDate'] as String? ?? "",
      updatedDate: json['updatedDate'] as String? ?? "",
      team: (json['team'] as List<dynamic>?)
              ?.map((e) =>
                  InvestigationTeamItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      rootCauses: (json['rootCauses'] as List<dynamic>?)
              ?.map((e) => InvestigationRootCauseItem.fromJson(
                  e as Map<String, dynamic>))
              .toList() ??
          const [],
      capa: (json['capa'] as List<dynamic>?)
              ?.map((e) =>
                  InvestigationCapaItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      inquiredWith: (json['inquiredWith'] as List<dynamic>?)
              ?.map((e) => InvestigationInquiredWithItem.fromJson(
                  e as Map<String, dynamic>))
              .toList() ??
          const [],
      createdByEmpCode: json['createdByEmpCode'] as String? ?? "",
      receivedAs: (json['receivedAs'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$InvestigationReportResponseImplToJson(
        _$InvestigationReportResponseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'incidentReportId': instance.incidentReportId,
      'incidentUniqueId': instance.incidentUniqueId,
      'reportDate': instance.reportDate,
      'associatedRiskImageUrl': instance.associatedRiskImageUrl,
      'lowQualityImageUrl': instance.lowQualityImageUrl,
      'highQualityImageUrl': instance.highQualityImageUrl,
      'machineryDetails': instance.machineryDetails,
      'activityBeforeIncident': instance.activityBeforeIncident,
      'raisedDate': instance.raisedDate,
      'updatedDate': instance.updatedDate,
      'team': instance.team,
      'rootCauses': instance.rootCauses,
      'capa': instance.capa,
      'inquiredWith': instance.inquiredWith,
      'createdByEmpCode': instance.createdByEmpCode,
      'receivedAs': instance.receivedAs,
    };

_$InvestigationTeamItemImpl _$$InvestigationTeamItemImplFromJson(
        Map<String, dynamic> json) =>
    _$InvestigationTeamItemImpl(
      id: (json['id'] as num?)?.toInt() ?? 0,
      seq: (json['seq'] as num?)?.toInt() ?? 0,
      empUnqId: json['empUnqId'] as String? ?? "",
      empName: json['empName'] as String? ?? "",
    );

Map<String, dynamic> _$$InvestigationTeamItemImplToJson(
        _$InvestigationTeamItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'seq': instance.seq,
      'empUnqId': instance.empUnqId,
      'empName': instance.empName,
    };

_$InvestigationRootCauseItemImpl _$$InvestigationRootCauseItemImplFromJson(
        Map<String, dynamic> json) =>
    _$InvestigationRootCauseItemImpl(
      id: (json['id'] as num?)?.toInt() ?? 0,
      seq: (json['seq'] as num?)?.toInt() ?? 0,
      rootCauseText: json['rootCauseText'] as String? ?? "",
    );

Map<String, dynamic> _$$InvestigationRootCauseItemImplToJson(
        _$InvestigationRootCauseItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'seq': instance.seq,
      'rootCauseText': instance.rootCauseText,
    };

_$InvestigationCapaItemImpl _$$InvestigationCapaItemImplFromJson(
        Map<String, dynamic> json) =>
    _$InvestigationCapaItemImpl(
      id: (json['id'] as num?)?.toInt() ?? 0,
      seq: (json['seq'] as num?)?.toInt() ?? 0,
      capaText: json['capaText'] as String? ?? "",
      respEmpCode: json['respEmpCode'] as String? ?? "",
      respEmpName: json['respEmpName'] as String? ?? "",
      respDeptCode: json['respDeptCode'] as String? ?? "",
      targetDate: json['targetDate'] as String? ?? "",
    );

Map<String, dynamic> _$$InvestigationCapaItemImplToJson(
        _$InvestigationCapaItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'seq': instance.seq,
      'capaText': instance.capaText,
      'respEmpCode': instance.respEmpCode,
      'respEmpName': instance.respEmpName,
      'respDeptCode': instance.respDeptCode,
      'targetDate': instance.targetDate,
    };

_$InvestigationInquiredWithItemImpl
    _$$InvestigationInquiredWithItemImplFromJson(Map<String, dynamic> json) =>
        _$InvestigationInquiredWithItemImpl(
          id: (json['id'] as num?)?.toInt() ?? 0,
          seq: (json['seq'] as num?)?.toInt() ?? 0,
          empUnqId: json['empUnqId'] as String? ?? "",
          empName: json['empName'] as String? ?? "",
          deptCode: json['deptCode'] as String? ?? "",
          statName: json['statName'] as String? ?? "",
          gradeName: json['gradeName'] as String? ?? "",
          desgName: json['desgName'] as String? ?? "",
        );

Map<String, dynamic> _$$InvestigationInquiredWithItemImplToJson(
        _$InvestigationInquiredWithItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'seq': instance.seq,
      'empUnqId': instance.empUnqId,
      'empName': instance.empName,
      'deptCode': instance.deptCode,
      'statName': instance.statName,
      'gradeName': instance.gradeName,
      'desgName': instance.desgName,
    };
