import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:web/web.dart' show window;

import 'auth_http.dart';
import 'constant.dart';

/// True when the logged-in user is on the HSE team (login flag `khseCode`).
bool isHseUser() => (window.localStorage.getItem('khseCode') ?? '').trim() == '1';

/// One compliance submission row as returned by `incidentAdmin/getComplianceSubmissions`.
class ComplianceSubmissionRow {
  final int id;
  final String empUnqId;
  final String empName;
  final String remark;
  final String reviewRemark;
  final String imageUrl;
  final String status;

  const ComplianceSubmissionRow({
    required this.id,
    required this.empUnqId,
    required this.empName,
    required this.remark,
    required this.reviewRemark,
    required this.imageUrl,
    required this.status,
  });

  factory ComplianceSubmissionRow.fromJson(Map<String, dynamic> j) {
    String s(String k) => (j[k] ?? '').toString();
    return ComplianceSubmissionRow(
      id: j['id'] is int ? j['id'] as int : int.tryParse(s('id')) ?? 0,
      empUnqId: s('empUnqId'),
      empName: s('empName'),
      remark: s('remark'),
      reviewRemark: s('reviewRemark'),
      imageUrl: s('imageUrl'),
      status: s('status'),
    );
  }
}

/// HSE-only Edit / Delete of incident records at any stage (customer request Oct-2026).
/// Every call returns the server message on success and throws [Exception] with the
/// server message otherwise. None of these calls sends mail or changes a status.
class IncidentAdminService {
  Future<String> updateIncident({
    required String incidentUniqueId,
    required Map<String, String> fields,
    Uint8List? newImageBytes,
  }) async {
    final request = http.MultipartRequest(
        'POST', Uri.parse('${root}incidentAdmin/updateIncident'));
    authHttp.attachAuth(request);
    request.fields['incidentUniqueId'] = incidentUniqueId;
    request.fields.addAll(fields);
    if (newImageBytes != null) {
      request.files.add(http.MultipartFile.fromBytes('image', newImageBytes,
          filename: 'upload.jpg', contentType: MediaType('image', 'jpeg')));
    }
    return _multipart(request);
  }

  Future<String> updateMedical(Map<String, dynamic> body) =>
      _postJson('incidentAdmin/updateMedical', body);

  Future<String> updateSafety(Map<String, dynamic> body) =>
      _postJson('incidentAdmin/updateSafety', body);

  Future<List<ComplianceSubmissionRow>> getComplianceSubmissions(
      String incidentUniqueId) async {
    final res = await authHttp.get(
        Uri.parse('${root}incidentAdmin/getComplianceSubmissions'
            '?incidentUniqueId=${Uri.encodeQueryComponent(incidentUniqueId)}'),
        headers: getHeaders());
    final j = _decode(res);
    final model = j['model'];
    return model is List
        ? model
            .whereType<Map>()
            .map((e) => ComplianceSubmissionRow.fromJson(e.cast<String, dynamic>()))
            .toList()
        : <ComplianceSubmissionRow>[];
  }

  Future<String> updateComplianceSubmission({
    required int id,
    required String remark,
    String? reviewRemark,
    Uint8List? newImageBytes,
    bool clearImage = false,
  }) async {
    final request = http.MultipartRequest(
        'POST', Uri.parse('${root}incidentAdmin/updateComplianceSubmission'));
    authHttp.attachAuth(request);
    request.fields['id'] = id.toString();
    request.fields['remark'] = remark;
    if (reviewRemark != null) request.fields['reviewRemark'] = reviewRemark;
    request.fields['clearImage'] = clearImage ? 'true' : 'false';
    if (newImageBytes != null) {
      request.files.add(http.MultipartFile.fromBytes('image', newImageBytes,
          filename: 'upload.jpg', contentType: MediaType('image', 'jpeg')));
    }
    return _multipart(request);
  }

  /// PERMANENT — removes the incident and its whole chain.
  Future<String> deleteIncident(String incidentUniqueId, String reason) =>
      _postJson('incidentAdmin/deleteIncident',
          {'incidentUniqueId': incidentUniqueId, 'reason': reason});

  // ---------------------------------------------------------------- helpers

  Future<String> _postJson(String path, Map<String, dynamic> body) async {
    final res = await authHttp.post(Uri.parse('$root$path'),
        body: json.encode(body), headers: getHeaders());
    return (_decode(res)['msg'] ?? 'Saved').toString();
  }

  Future<String> _multipart(http.MultipartRequest request) async {
    final res = await http.Response.fromStream(await request.send());
    authHttp.check(res);
    return (_decode(res)['msg'] ?? 'Saved').toString();
  }

  Map<String, dynamic> _decode(http.Response res) {
    if (res.statusCode < 200 || res.statusCode >= 300) {
      throw Exception('Server error ${res.statusCode}');
    }
    final dynamic j;
    try {
      j = json.decode(res.body);
    } on FormatException {
      throw Exception('Invalid response from server');
    }
    if (j is! Map) throw Exception('Invalid response from server');
    if (j['status'] != true) {
      throw Exception((j['msg'] ?? j['message'] ?? 'Request failed').toString());
    }
    return j.cast<String, dynamic>();
  }
}
