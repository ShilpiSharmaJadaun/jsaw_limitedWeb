/// ---------------------------------------------------------------------------
/// Compliance Incident — DESIGN-ONLY view models + mock data.
///
/// The fields here mirror the REAL data that already exists once a Safety
/// Officer submits the Safety Remark Form. That single record
/// (see `CompleteSafetyRemarkModel` / `safety_remark_page.dart`) bundles the
/// incident details, the medical/injury assessment, the medical officer's
/// remarks, the safety officer's remark and the incident image — so it is the
/// primary source for the Compliance Incident view.
///
/// The Investigation portion (team, root cause, CAPA, attachment) comes from
/// the Submit Investigation Form.
///
/// There is NO backend wiring yet — [sampleComplianceIncidents] returns
/// placeholder records so the UI/layout can be reviewed. When the API exists,
/// map `CompleteSafetyRemarkModel` + the investigation response straight into
/// these classes; the screens won't change.
/// ---------------------------------------------------------------------------

/// A person reference (investigation team member or CAPA-assigned employee).
class PersonRef {
  final String empCode;
  final String empName;
  final String department;
  const PersonRef({
    required this.empCode,
    required this.empName,
    this.department = '',
  });
}

/// Root Cause – Inquired With (point 6): employee + auto-populated details.
class InquiredWithRef {
  final String empCode;
  final String empName;
  final String statName;
  final String gradeName;
  final String desgName;
  const InquiredWithRef({
    required this.empCode,
    required this.empName,
    this.statName = '',
    this.gradeName = '',
    this.desgName = '',
  });
}

/// A single CAPA action row (corrective / suppressive / preventive).
class CapaAction {
  final String action;
  final String respEmpName;
  final String respEmpCode;
  final String department;
  final String targetDate;
  const CapaAction({
    required this.action,
    required this.respEmpName,
    required this.respEmpCode,
    required this.department,
    required this.targetDate,
  });
}

/// Everything captured on the Safety Remark Form (post-submit). Field names
/// follow `CompleteSafetyRemarkModel` exactly so this maps 1:1 to the API.
class SafetyRemarkBundle {
  // -- Incident details ----------------------------------------------------
  final String incidentUniqueId;
  final String raisedBy; // person who raised the incident
  final String incidentDateTime;
  final String incidentType;
  final String shift;
  final String employeeName;
  final String employeeCode;
  final String age;
  final String contractorName;
  final String contractorCode;
  final String plant;
  final String department; // deptName
  final String location;
  final String responsibleEngineer; // responsibleShiftEngg
  final String responsibleHod;
  final String contactNumber;
  final String firDateTime;
  final String workInjury;
  final String descriptionOfIncident; // descpOfIncident

  // -- Medical / injury assessment ----------------------------------------
  final String medicalOfficerName;
  final String typeOfInjury;
  final String bodyPart;
  final String natureOfInjury;
  final String restUpto;
  final String fitForDutyFrom;
  final String medicalOfficerRemarks;

  // -- Safety officer ------------------------------------------------------
  final String safetyOfficerName;
  final String safetyRemarks;
  final String raisedDate;

  // -- Incident image ------------------------------------------------------
  final String? imageUrl;

  const SafetyRemarkBundle({
    required this.incidentUniqueId,
    required this.raisedBy,
    required this.incidentDateTime,
    required this.incidentType,
    required this.shift,
    required this.employeeName,
    required this.employeeCode,
    required this.age,
    required this.contractorName,
    required this.contractorCode,
    required this.plant,
    required this.department,
    required this.location,
    required this.responsibleEngineer,
    required this.responsibleHod,
    required this.contactNumber,
    required this.firDateTime,
    required this.workInjury,
    required this.descriptionOfIncident,
    required this.typeOfInjury,
    required this.bodyPart,
    required this.natureOfInjury,
    required this.restUpto,
    required this.fitForDutyFrom,
    required this.medicalOfficerName,
    required this.medicalOfficerRemarks,
    required this.safetyOfficerName,
    required this.safetyRemarks,
    required this.raisedDate,
    this.imageUrl,
  });
}

/// Investigation Details (Submit Investigation Form).
class InvestigationDetail {
  final String incidentId;
  final List<PersonRef> team;
  final String reportDate;
  final List<String> rootCauses;

  /// Facts Leading to the Incident or Dangerous Occurrence (points 4 & 5).
  final String machineryDetails;
  final String activityBeforeIncident;

  /// Root Cause – Inquired With (point 6). Optional, any number.
  final List<InquiredWithRef> inquiredWith;

  // CAPA — three categories per the compliance spec.
  final List<CapaAction> correctiveActions;
  final List<CapaAction> suppressiveActions;
  final List<CapaAction> preventiveActions;

  /// All employees selected in the CAPA section. These are the users who
  /// gain visibility of this Compliance Incident after login.
  final List<PersonRef> assignedEmployees;

  /// Uploaded investigation attachment (image).
  final String? attachmentImageUrl;
  final String attachmentName;

  const InvestigationDetail({
    required this.incidentId,
    required this.team,
    required this.reportDate,
    required this.rootCauses,
    this.machineryDetails = '',
    this.activityBeforeIncident = '',
    this.inquiredWith = const [],
    required this.correctiveActions,
    required this.suppressiveActions,
    required this.preventiveActions,
    required this.assignedEmployees,
    required this.attachmentName,
    this.attachmentImageUrl,
  });

  bool get isEmpty => team.isEmpty && rootCauses.isEmpty;
}

/// Top-level Compliance Incident record (one per Incident ID).
class ComplianceIncident {
  /// Investigation/compliance status. Placeholder for design — the real value
  /// will be derived once the workflow/status API exists.
  final String status;

  final SafetyRemarkBundle safety;
  final InvestigationDetail investigation;

  /// This logged-in employee's own compliance status for the incident.
  final String myStatus; // PENDING / COMPLETE / REOPEN / CLOSED
  final MyComplianceSubmission? mySubmission;

  const ComplianceIncident({
    required this.status,
    required this.safety,
    required this.investigation,
    this.myStatus = 'PENDING',
    this.mySubmission,
  });

  // Convenience getters used by the list card / header.
  String get incidentId => safety.incidentUniqueId;
  String get title => safety.descriptionOfIncident;
  String get incidentType => safety.incidentType;
  String get reportDate =>
      investigation.reportDate.isNotEmpty && investigation.reportDate != '—'
          ? investigation.reportDate
          : safety.raisedDate;
  int get assignedEmployeesCount => investigation.assignedEmployees.length;
}

/// This employee's own compliance submission (from the detail API).
class MyComplianceSubmission {
  final String remark;
  final String imageUrl;
  final String status;       // COMPLETE / REOPEN / CLOSED
  final String reviewRemark; // reopen reason, if reopened
  final String submittedDate;
  final String reopenSource; // who reopened: HOD | SAFETY
  const MyComplianceSubmission({
    this.remark = '',
    this.imageUrl = '',
    this.status = '',
    this.reviewRemark = '',
    this.submittedDate = '',
    this.reopenSource = '',
  });
}

/// ---------------------------------------------------------------------------
/// Mock data — placeholder only (kept for previews). The live screens use the
/// ComplianceService instead.
/// ---------------------------------------------------------------------------
List<ComplianceIncident> sampleComplianceIncidents() {
  return [
    ComplianceIncident(
      status: 'In Progress',
      safety: const SafetyRemarkBundle(
        incidentUniqueId: 'INC-2026-0142',
        raisedBy: 'S. Iqbal',
        incidentDateTime: '05-June-2026 14:35',
        incidentType: 'Personal Injury',
        shift: 'B (14:00 – 22:00)',
        employeeName: 'Ramesh Kumar',
        employeeCode: '115163',
        age: '34',
        contractorName: 'M/s Shakti Engg. Works',
        contractorCode: 'C-0471',
        plant: 'Plant A',
        department: 'Press Shop',
        location: 'Press Shop, Bay 3',
        responsibleEngineer: 'P. Nair (120044)',
        responsibleHod: 'A. Verma',
        contactNumber: '98xxxxxx20',
        firDateTime: '05-June-2026 15:10',
        workInjury: 'Yes',
        descriptionOfIncident:
            'Operator sustained a laceration to the left hand while clearing a '
            'jammed blank from the press feed. Machine was not fully isolated '
            'before the operator reached into the danger zone.',
        typeOfInjury: 'Laceration / Cut',
        bodyPart: 'Left hand (dorsal)',
        natureOfInjury: 'Open wound',
        restUpto: '7 days',
        fitForDutyFrom: '13-June-2026',
        medicalOfficerRemarks:
            'Deep laceration ~4cm. No fracture on X-ray. 5 sutures, tetanus '
            'booster, antibiotics for 5 days. Fit for light duty after 7 days.',
        safetyRemarks:
            'Interlock guard found bypassed; operator under time pressure to '
            'clear jam. Press #3 stopped until guard restored. Enforce LOTO for '
            'jam clearing and retrain operators.',
        raisedDate: '06-June-2026',
        medicalOfficerName: 'Dr. A. Mehra',
        safetyOfficerName: 'P. Nair',
        imageUrl: null,
      ),
      investigation: const InvestigationDetail(
        incidentId: 'INC-2026-0142',
        reportDate: '08-June-2026',
        team: [
          PersonRef(
              empCode: '115163',
              empName: 'Mohammed Khaja Moinuddin Basha',
              department: 'HSE'),
          PersonRef(empCode: '120044', empName: 'P. Nair', department: 'Safety'),
          PersonRef(
              empCode: '118702',
              empName: 'R. Deshmukh',
              department: 'Maintenance'),
        ],
        rootCauses: [
          'Machine interlock deliberately bypassed to save changeover time.',
          'No enforced lock-out/tag-out procedure for clearing jams.',
        ],
        correctiveActions: [
          CapaAction(
            action: 'Restore guard interlock and verify functional test.',
            respEmpName: 'R. Deshmukh',
            respEmpCode: '118702',
            department: 'Maintenance',
            targetDate: '10-June-2026',
          ),
        ],
        suppressiveActions: [
          CapaAction(
            action: 'Place press #3 on hold until interlock verified.',
            respEmpName: 'P. Nair',
            respEmpCode: '120044',
            department: 'Safety',
            targetDate: '06-June-2026',
          ),
        ],
        preventiveActions: [
          CapaAction(
            action: 'Roll out LOTO refresher training for all press operators.',
            respEmpName: 'Mohammed Khaja Moinuddin Basha',
            respEmpCode: '115163',
            department: 'HSE',
            targetDate: '20-June-2026',
          ),
          CapaAction(
            action: 'Display jam-clearing SOP at each press station.',
            respEmpName: 'P. Nair',
            respEmpCode: '120044',
            department: 'Safety',
            targetDate: '15-June-2026',
          ),
        ],
        assignedEmployees: [
          PersonRef(
              empCode: '118702',
              empName: 'R. Deshmukh',
              department: 'Maintenance'),
          PersonRef(empCode: '120044', empName: 'P. Nair', department: 'Safety'),
          PersonRef(
              empCode: '115163',
              empName: 'Mohammed Khaja Moinuddin Basha',
              department: 'HSE'),
        ],
        attachmentName: 'press3_guard.jpg',
        attachmentImageUrl: null,
      ),
    ),
    ComplianceIncident(
      status: 'Completed',
      safety: const SafetyRemarkBundle(
        incidentUniqueId: 'INC-2026-0138',
        raisedBy: 'S. Banerjee',
        incidentDateTime: '29-May-2026 09:10',
        incidentType: 'Spill / Release',
        shift: 'A (06:00 – 14:00)',
        employeeName: 'S. Banerjee',
        employeeCode: '117045',
        age: '41',
        contractorName: '—',
        contractorCode: '—',
        plant: 'Plant B',
        department: 'Stores',
        location: 'Chemical Store',
        responsibleEngineer: 'K. Joshi (120044)',
        responsibleHod: 'M. Singh',
        contactNumber: '97xxxxxx88',
        firDateTime: '29-May-2026 09:40',
        workInjury: 'No',
        descriptionOfIncident:
            'Approx. 20 litres of cleaning solvent spilled while transferring '
            'between drums. Contained within bund; no personnel exposure.',
        typeOfInjury: 'Not applicable',
        bodyPart: '—',
        natureOfInjury: 'No injury',
        restUpto: '—',
        fitForDutyFrom: '—',
        medicalOfficerRemarks:
            'No exposure reported. No treatment required. Advised eyewash '
            'station check for the area.',
        safetyRemarks:
            'Transfer done without drip tray under coupling; pump seal worn. '
            'Area cleaned and neutralised same day. Provide drip trays and '
            'replace pump seal.',
        raisedDate: '30-May-2026',
        medicalOfficerName: 'Dr. A. Mehra',
        safetyOfficerName: 'K. Joshi',
        imageUrl: null,
      ),
      investigation: const InvestigationDetail(
        incidentId: 'INC-2026-0138',
        reportDate: '02-June-2026',
        team: [
          PersonRef(empCode: '120044', empName: 'K. Joshi', department: 'Safety'),
          PersonRef(
              empCode: '117045', empName: 'S. Banerjee', department: 'Stores'),
        ],
        rootCauses: [
          'No spill containment tray used during drum transfer.',
        ],
        correctiveActions: [
          CapaAction(
            action: 'Replace worn transfer pump seal.',
            respEmpName: 'R. Deshmukh',
            respEmpCode: '118702',
            department: 'Maintenance',
            targetDate: '31-May-2026',
          ),
        ],
        suppressiveActions: [
          CapaAction(
            action: 'Neutralise and clean spill; isolate drum.',
            respEmpName: 'S. Banerjee',
            respEmpCode: '117045',
            department: 'Stores',
            targetDate: '29-May-2026',
          ),
        ],
        preventiveActions: [
          CapaAction(
            action: 'Issue drip trays and update transfer SOP.',
            respEmpName: 'K. Joshi',
            respEmpCode: '120044',
            department: 'Safety',
            targetDate: '05-June-2026',
          ),
        ],
        assignedEmployees: [
          PersonRef(
              empCode: '118702',
              empName: 'R. Deshmukh',
              department: 'Maintenance'),
          PersonRef(
              empCode: '117045', empName: 'S. Banerjee', department: 'Stores'),
          PersonRef(empCode: '120044', empName: 'K. Joshi', department: 'Safety'),
        ],
        attachmentName: 'spill_bund.jpg',
        attachmentImageUrl: null,
      ),
    ),
    ComplianceIncident(
      status: 'Pending',
      safety: const SafetyRemarkBundle(
        incidentUniqueId: 'INC-2026-0151',
        raisedBy: 'V. Rao',
        incidentDateTime: '09-June-2026 11:50',
        incidentType: 'Near Miss',
        shift: 'A (06:00 – 14:00)',
        employeeName: 'V. Rao',
        employeeCode: '119338',
        age: '29',
        contractorName: '—',
        contractorCode: '—',
        plant: 'Warehouse',
        department: 'Logistics',
        location: 'Rack 12',
        responsibleEngineer: 'P. Nair (120044)',
        responsibleHod: 'A. Verma',
        contactNumber: '99xxxxxx41',
        firDateTime: '—',
        workInjury: 'No',
        descriptionOfIncident:
            'An unsecured carton fell from the third level of a storage rack, '
            'narrowly missing a passing forklift operator.',
        typeOfInjury: 'Not applicable',
        bodyPart: '—',
        natureOfInjury: 'No injury',
        restUpto: '—',
        fitForDutyFrom: '—',
        medicalOfficerRemarks: 'Not applicable (no injury).',
        safetyRemarks:
            'Rack load not restrained; no edge protection. Install rack netting '
            'and enforce maximum stack height. Awaiting investigation team.',
        raisedDate: '09-June-2026',
        medicalOfficerName: '—',
        safetyOfficerName: 'P. Nair',
        imageUrl: null,
      ),
      investigation: const InvestigationDetail(
        incidentId: 'INC-2026-0151',
        reportDate: '—',
        team: [],
        rootCauses: [],
        correctiveActions: [],
        suppressiveActions: [],
        preventiveActions: [],
        assignedEmployees: [],
        attachmentName: '',
        attachmentImageUrl: null,
      ),
    ),
  ];
}
