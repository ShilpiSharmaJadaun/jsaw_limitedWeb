import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:web/web.dart' show window;

import '../model/compliance_api_models.dart';
import '../model/compliance_incident_model.dart';
import 'auth_http.dart';
import 'constant.dart';

/// Talks to the `/compliance` backend endpoints. Reads the logged-in employee
/// (empUnqId / empName) from localStorage, matching the rest of the app.
class ComplianceService {
  String get _empUnqId => window.localStorage.getItem('kEmployeeCode') ?? '';
  String get _empName => window.localStorage.getItem('kEmployeename') ?? '';

  /// Compliance incidents visible to the logged-in employee.
  Future<List<ComplianceSummary>> getMyComplianceIncidents() async {
    final url = "${root}compliance/getMyComplianceIncidents";
    final response = await authHttp.post(
      Uri.parse(url),
      body: json.encode({"empUnqId": _empUnqId}),
      headers: getHeaders(),
    );
    final body = json.decode(response.body);
    if (body is Map && body['status'] == true && body['model'] is List) {
      return (body['model'] as List)
          .whereType<Map>()
          .map((e) => ComplianceSummary.fromJson(e.cast<String, dynamic>()))
          .toList();
    }
    return <ComplianceSummary>[];
  }

  /// All compliance incidents (HOD/admin review list).
  Future<List<ComplianceSummary>> getAllComplianceIncidents() async {
    final url = "${root}compliance/getAllComplianceIncidents";
    final response = await authHttp.get(Uri.parse(url), headers: getHeaders());
    final body = json.decode(response.body);
    if (body is Map && body['status'] == true && body['model'] is List) {
      return (body['model'] as List)
          .whereType<Map>()
          .map((e) => ComplianceSummary.fromJson(e.cast<String, dynamic>()))
          .toList();
    }
    return <ComplianceSummary>[];
  }

  /// Investigations where the logged-in user is a TEAM member (read-only
  /// "Investigations Raised" list). Scoped server-side from the JWT.
  Future<List<ComplianceSummary>> getInvestigationsRaised() async {
    final url = "${root}compliance/getInvestigationsForTeamMember";
    final response = await authHttp.get(Uri.parse(url), headers: getHeaders());
    final body = json.decode(response.body);
    if (body is Map && body['status'] == true && body['model'] is List) {
      return (body['model'] as List)
          .whereType<Map>()
          .map((e) => ComplianceSummary.fromJson(e.cast<String, dynamic>()))
          .toList();
    }
    return <ComplianceSummary>[];
  }

  /// Investigations the logged-in HOD monitors (a subordinate is the creator,
  /// a team member, or a CAPA engineer). Read-only. Scoped server-side from JWT.
  Future<List<ComplianceSummary>> getInvestigationsToMonitor() async {
    final url = "${root}compliance/getInvestigationsForHod";
    final response = await authHttp.get(Uri.parse(url), headers: getHeaders());
    final body = json.decode(response.body);
    if (body is Map && body['status'] == true && body['model'] is List) {
      return (body['model'] as List)
          .whereType<Map>()
          .map((e) => ComplianceSummary.fromJson(e.cast<String, dynamic>()))
          .toList();
    }
    return <ComplianceSummary>[];
  }

  /// Full read-only bundle for one incident (mapped to the UI model).
  Future<ComplianceIncident> getComplianceDetail(String incidentUniqueId) async {
    final url = "${root}compliance/getComplianceDetail";
    final response = await authHttp.post(
      Uri.parse(url),
      body: json.encode({"incidentUniqueId": incidentUniqueId, "empUnqId": _empUnqId}),
      headers: getHeaders(),
    );
    final body = json.decode(response.body);
    if (body is Map && body['status'] == true && body['model'] is Map) {
      return complianceIncidentFromDetail(
        (body['model'] as Map).cast<String, dynamic>(),
        forEmpUnqId: _empUnqId, // show only this employee's CAPA
      );
    }
    throw Exception(
        (body is Map ? body['msg']?.toString() : null) ?? 'Failed to load compliance detail');
  }

  /// Full bundle for the HOD review screen. Same payload as
  /// [getComplianceDetail] but keeps ALL CAPA actions (not filtered to one
  /// employee) so the HOD sees the complete incident context.
  Future<ComplianceIncident> getComplianceDetailForReview(
      String incidentUniqueId) async {
    final url = "${root}compliance/getComplianceDetail";
    final response = await authHttp.post(
      Uri.parse(url),
      body: json.encode(
          {"incidentUniqueId": incidentUniqueId, "empUnqId": _empUnqId}),
      headers: getHeaders(),
    );
    final body = json.decode(response.body);
    if (body is Map && body['status'] == true && body['model'] is Map) {
      return complianceIncidentFromDetail(
        (body['model'] as Map).cast<String, dynamic>(),
        forEmpUnqId: '', // keep all CAPA for the HOD
      );
    }
    throw Exception((body is Map ? body['msg']?.toString() : null) ??
        'Failed to load compliance detail');
  }

  /// Submit this employee's compliance remark (+ optional image).
  Future<String?> submitCompliance({
    required String incidentUniqueId,
    required String remark,
    Uint8List? imageBytes,
  }) async {
    final url = "${root}compliance/submitCompliance";
    final request = http.MultipartRequest("POST", Uri.parse(url));
    authHttp.attachAuth(request);

    if (imageBytes != null && imageBytes.isNotEmpty) {
      request.files.add(http.MultipartFile.fromBytes(
        'image',
        imageBytes,
        filename: 'compliance.jpg',
        contentType: MediaType('image', 'jpeg'),
      ));
    }
    request.fields['remark'] = remark;
    request.fields['incidentUniqueId'] = incidentUniqueId;
    request.fields['empUnqId'] = _empUnqId;
    request.fields['empName'] = _empName;

    final res = await request.send();
    final results = await http.Response.fromStream(res);
    authHttp.check(results);
    final finalres = jsonDecode(results.body) as Map<String, dynamic>;
    if (finalres['status'] == true) {
      return finalres['msg']?.toString();
    }
    throw Exception(finalres['msg']?.toString() ?? 'Submit failed');
  }

  /// HOD review view: all assigned employees + their compliance status.
  Future<ComplianceReview> getComplianceForReview(String incidentUniqueId) async {
    final url = "${root}compliance/getComplianceForReview";
    final response = await authHttp.post(
      Uri.parse(url),
      body: json.encode({"incidentUniqueId": incidentUniqueId}),
      headers: getHeaders(),
    );
    final body = json.decode(response.body);
    if (body is Map && body['status'] == true && body['model'] is Map) {
      return ComplianceReview.fromJson((body['model'] as Map).cast<String, dynamic>());
    }
    throw Exception(
        (body is Map ? body['msg']?.toString() : null) ?? 'Failed to load compliance review');
  }

  /// HOD reopens (rejects) one employee's compliance.
  Future<String?> rejectCompliance({
    required String incidentUniqueId,
    required String empUnqId,
    required String reviewRemark,
  }) async {
    final url = "${root}compliance/rejectCompliance";
    final response = await authHttp.post(
      Uri.parse(url),
      body: json.encode({
        "incidentUniqueId": incidentUniqueId,
        "empUnqId": empUnqId,
        "hodEmpUnqId": _empUnqId,
        "reviewRemark": reviewRemark,
      }),
      headers: getHeaders(),
    );
    final body = json.decode(response.body);
    if (body is Map && body['status'] == true) {
      return body['msg']?.toString();
    }
    throw Exception((body is Map ? body['msg']?.toString() : null) ?? 'Reopen failed');
  }

  /// HOD closes the whole incident compliance (allowed only when all complete).
  Future<String?> closeCompliance(String incidentUniqueId) async {
    final url = "${root}compliance/closeCompliance";
    final response = await authHttp.post(
      Uri.parse(url),
      body: json.encode({"incidentUniqueId": incidentUniqueId, "hodEmpUnqId": _empUnqId}),
      headers: getHeaders(),
    );
    final body = json.decode(response.body);
    if (body is Map && body['status'] == true) {
      return body['msg']?.toString();
    }
    throw Exception((body is Map ? body['msg']?.toString() : null) ?? 'Close failed');
  }
}
