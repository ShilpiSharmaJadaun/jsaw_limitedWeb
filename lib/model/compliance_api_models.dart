import 'compliance_incident_model.dart';

/// Lightweight API view models for the Compliance endpoints + a mapper that
/// turns the `getComplianceDetail` payload into the existing [ComplianceIncident]
/// UI model (so the detail screen renders unchanged).

String _s(dynamic v) => v == null ? '' : v.toString();
int _i(dynamic v) => v is int ? v : int.tryParse('${v ?? ''}') ?? 0;
bool _b(dynamic v) => v is bool ? v : (v?.toString().toLowerCase() == 'true');
String? _nullIfEmpty(String s) => s.isEmpty ? null : s;
String _fileNameFromUrl(String url) {
  final i = url.lastIndexOf('/');
  return (i >= 0 && i < url.length - 1) ? url.substring(i + 1) : url;
}

/// One card on the compliance list.
class ComplianceSummary {
  final String incidentUniqueId;
  final String incidentType;
  final String description;
  final String raisedBy;
  final String reportingDate;
  final String status;   // OVERALL: PENDING / COMPLETE / CLOSED
  final String myStatus; // THIS user: PENDING / COMPLETE / REOPEN / CLOSED
  final String imageUrl;
  final int assignedCount;
  final bool alreadySubmitted;

  const ComplianceSummary({
    required this.incidentUniqueId,
    required this.incidentType,
    required this.description,
    required this.raisedBy,
    required this.reportingDate,
    required this.status,
    required this.myStatus,
    required this.imageUrl,
    required this.assignedCount,
    required this.alreadySubmitted,
  });

  factory ComplianceSummary.fromJson(Map<String, dynamic> m) => ComplianceSummary(
        incidentUniqueId: _s(m['incidentUniqueId']),
        incidentType: _s(m['incidentType']),
        description: _s(m['description']),
        raisedBy: _s(m['raisedBy']),
        reportingDate: _s(m['reportingDate']),
        status: _s(m['status']).isEmpty ? 'PENDING' : _s(m['status']),
        myStatus: _s(m['myStatus']).isEmpty ? 'PENDING' : _s(m['myStatus']),
        imageUrl: _s(m['imageUrl']),
        assignedCount: _i(m['assignedCount']),
        alreadySubmitted: _b(m['alreadySubmitted']),
      );
}

/// One assigned employee's row on the HOD review screen.
class ComplianceAssigneeReview {
  final String empUnqId;
  final String empName;
  final String deptCode;
  final String status; // PENDING / COMPLETE / REOPEN / CLOSED
  final String remark;
  final String imageUrl;
  final String submittedDate;
  final String reviewRemark;

  const ComplianceAssigneeReview({
    required this.empUnqId,
    required this.empName,
    required this.deptCode,
    required this.status,
    required this.remark,
    required this.imageUrl,
    required this.submittedDate,
    required this.reviewRemark,
  });

  factory ComplianceAssigneeReview.fromJson(Map<String, dynamic> m) =>
      ComplianceAssigneeReview(
        empUnqId: _s(m['empUnqId']),
        empName: _s(m['empName']),
        deptCode: _s(m['deptCode']),
        status: _s(m['status']).isEmpty ? 'PENDING' : _s(m['status']),
        remark: _s(m['remark']),
        imageUrl: _s(m['imageUrl']),
        submittedDate: _s(m['submittedDate']),
        reviewRemark: _s(m['reviewRemark']),
      );
}

/// HOD review payload for one incident.
class ComplianceReview {
  final String incidentUniqueId;
  final String overallStatus;
  final bool canClose;
  final List<ComplianceAssigneeReview> assignees;

  const ComplianceReview({
    required this.incidentUniqueId,
    required this.overallStatus,
    required this.canClose,
    required this.assignees,
  });

  factory ComplianceReview.fromJson(Map<String, dynamic> m) {
    final list = (m['assignees'] is List)
        ? (m['assignees'] as List)
            .whereType<Map>()
            .map((e) => ComplianceAssigneeReview.fromJson(e.cast<String, dynamic>()))
            .toList()
        : <ComplianceAssigneeReview>[];
    return ComplianceReview(
      incidentUniqueId: _s(m['incidentUniqueId']),
      overallStatus: _s(m['overallStatus']).isEmpty ? 'PENDING' : _s(m['overallStatus']),
      canClose: _b(m['canClose']),
      assignees: list,
    );
  }
}

/// Map the `getComplianceDetail` model payload into the UI [ComplianceIncident].
///
/// [forEmpUnqId] (the logged-in employee) filters the CAPA list so each person
/// only sees the corrective actions assigned to THEM. Pass '' to keep all.
ComplianceIncident complianceIncidentFromDetail(Map<String, dynamic> m,
    {String forEmpUnqId = ''}) {
  final sr = (m['safetyRemark'] is Map)
      ? (m['safetyRemark'] as Map).cast<String, dynamic>()
      : <String, dynamic>{};
  final inv = (m['investigation'] is Map)
      ? (m['investigation'] as Map).cast<String, dynamic>()
      : <String, dynamic>{};
  final teamJson = (m['team'] is List) ? (m['team'] as List) : const [];
  final rootJson = (m['rootCauses'] is List) ? (m['rootCauses'] as List) : const [];
  final capaJson = (m['capa'] is List) ? (m['capa'] as List) : const [];

  final safety = SafetyRemarkBundle(
    incidentUniqueId: _s(sr['incidentUniqueId']).isEmpty
        ? _s(m['incidentUniqueId'])
        : _s(sr['incidentUniqueId']),
    incidentDateTime: _s(sr['incidentDateTime']),
    incidentType: _s(sr['incidentType']),
    shift: _s(sr['shift']),
    employeeName: _s(sr['employeeName']),
    employeeCode: _s(sr['employeeCode']),
    age: _s(sr['age']),
    contractorName: _s(sr['contractorName']),
    contractorCode: _s(sr['contCode']),
    plant: _s(sr['plant']),
    department: _s(sr['deptName']),
    location: _s(sr['location']),
    responsibleEngineer: _s(sr['responsibleShiftEngg']),
    responsibleHod: _s(sr['responsibleHod']),
    contactNumber: _s(sr['contactNumber']),
    firDateTime: _s(sr['firDateTime']),
    workInjury: _s(sr['workInjury']),
    descriptionOfIncident: _s(sr['descpOfIncident']),
    typeOfInjury: _s(sr['typeOfInjury']),
    bodyPart: _s(sr['bodyPart']),
    natureOfInjury: _s(sr['natureOfInjury']),
    restUpto: _s(sr['restUpto']),
    fitForDutyFrom: _s(sr['fitForDutyFrom']),
    medicalOfficerName: _s(sr['medicalOfficerName']),
    medicalOfficerRemarks: _s(sr['medicalOfficerRemarks']),
    safetyOfficerName: _s(sr['safetyOfficerName']),
    safetyRemarks: _s(sr['safetyRemarks']),
    raisedDate: _s(sr['raisedDate']),
    raisedBy: _s(sr['employeeName']),
    imageUrl: _nullIfEmpty(_s(sr['imageUrl'])),
  );

  final team = teamJson.whereType<Map>().map((e) {
    final t = e.cast<String, dynamic>();
    return PersonRef(empCode: _s(t['empUnqId']), empName: _s(t['empName']));
  }).toList();

  final rootCauses = rootJson
      .whereType<Map>()
      .map((e) => _s((e.cast<String, dynamic>())['rootCauseText']))
      .where((x) => x.isNotEmpty)
      .toList();

  final me = forEmpUnqId.trim().toLowerCase();
  final corrective = capaJson.whereType<Map>().where((e) {
    if (me.isEmpty) return true; // no filter -> show all
    final code = _s((e.cast<String, dynamic>())['respEmpCode']).trim().toLowerCase();
    return code == me; // only CAPA assigned to this employee
  }).map((e) {
    final c = e.cast<String, dynamic>();
    return CapaAction(
      action: _s(c['capaText']),
      respEmpName: _s(c['respEmpName']),
      respEmpCode: _s(c['respEmpCode']),
      department: _s(c['respDeptCode']),
      targetDate: _s(c['targetDate']),
    );
  }).toList();

  final seen = <String>{};
  final assigned = <PersonRef>[];
  for (final e in capaJson.whereType<Map>()) {
    final c = e.cast<String, dynamic>();
    final code = _s(c['respEmpCode']);
    if (code.isEmpty || seen.contains(code)) continue;
    seen.add(code);
    assigned.add(PersonRef(
        empCode: code, empName: _s(c['respEmpName']), department: _s(c['respDeptCode'])));
  }

  final attachmentUrl = _s(inv['associatedRiskImageUrl']);
  final investigation = InvestigationDetail(
    incidentId: _s(inv['incidentUniqueId']).isEmpty
        ? _s(m['incidentUniqueId'])
        : _s(inv['incidentUniqueId']),
    team: team,
    reportDate: _s(inv['reportDate']),
    rootCauses: rootCauses,
    correctiveActions: corrective,
    suppressiveActions: const [],
    preventiveActions: const [],
    assignedEmployees: assigned,
    attachmentName: attachmentUrl.isEmpty ? '' : _fileNameFromUrl(attachmentUrl),
    attachmentImageUrl: _nullIfEmpty(attachmentUrl),
  );

  MyComplianceSubmission? mySub;
  if (m['mySubmission'] is Map) {
    final ms = (m['mySubmission'] as Map).cast<String, dynamic>();
    mySub = MyComplianceSubmission(
      remark: _s(ms['remark']),
      imageUrl: _s(ms['imageUrl']),
      status: _s(ms['status']),
      reviewRemark: _s(ms['reviewRemark']),
      submittedDate: _s(ms['submittedDate']),
    );
  }

  return ComplianceIncident(
    status: _s(m['status']).isEmpty ? 'PENDING' : _s(m['status']),
    myStatus: _s(m['myStatus']).isEmpty ? 'PENDING' : _s(m['myStatus']),
    safety: safety,
    investigation: investigation,
    mySubmission: mySub,
  );
}
