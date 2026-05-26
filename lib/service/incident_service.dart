import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'auth_http.dart';
import 'package:jsaw_limited/model/allBodyParts_model.dart';
import 'package:jsaw_limited/model/allContractor_model.dart';
import 'package:jsaw_limited/model/allIncident_model.dart';
import 'package:jsaw_limited/model/allMedicalOfficerList_model.dart';
import 'package:jsaw_limited/model/allNatureInjury_model.dart';
import 'package:jsaw_limited/model/allTypeIncident_model.dart';
import 'package:jsaw_limited/model/completeSafetyRemark_model.dart';
import 'package:jsaw_limited/model/employeeBasicDetail_model.dart';
import 'package:jsaw_limited/model/employeeShift_model.dart';
import 'package:jsaw_limited/model/investigationReport_response_model.dart';
import 'package:jsaw_limited/model/safetyRemarkList_model.dart';
import '../error/api_error.dart';
import '../model/completeMedicalResponse_model.dart';
import 'constant.dart';
import 'package:http_parser/http_parser.dart';

class IncidentService{

  Future<List<AllContractorModel>> getAllContractorList()async{
    const url = "${root}incident/getAllContactor";
    final response = await authHttp.get(Uri.parse(url),headers: getHeaders());
    try{
      final responseBody = json.decode(response.body);
      if(responseBody["status"] == true){
        final itemList = responseBody["model"] as List;
        return itemList.map((e) => AllContractorModel.fromJson(e)).toList();
      }else{
        throw ApiError.fromResponse(responseBody["msg"]);
      }
    }catch(e){
      _handleError(e);
    }
    return[];
  }


  Future<List<EmployeeBasicDetailModel>> getEmployeeBasicDetail()async{
    const url = "${root}employees/getEmployeesBasicDetails";
    final response = await authHttp.get(Uri.parse(url),headers: getHeaders());
    try{
      final responseBody = json.decode(response.body);
      if(responseBody["status"] == true){
        final itemList = responseBody["model"] as List;
        return itemList.map((e) => EmployeeBasicDetailModel.fromJson(e)).toList();
      }else{
        throw ApiError.fromResponse(responseBody["msg"]);
      }
    }catch(e){
      _handleError(e);
    }
    return[];
  }

  Future<List<AllNatureInjuryModel>> getAllNatureInjuryDetail()async{
    const url = "${root}incident/getAllTypeOfInjury";
    final response = await authHttp.get(Uri.parse(url),headers: getHeaders());
    try{
      final responseBody = json.decode(response.body);
      if(responseBody["status"] == true){
        final itemList = responseBody["model"] as List;
        return itemList.map((e) => AllNatureInjuryModel.fromJson(e)).toList();
      }else{
        throw ApiError.fromResponse(responseBody["msg"]);
      }
    }catch(e){
      _handleError(e);
    }
    return[];
  }

  Future<List<AllTypeIncidentModel>> getAllTypeOfIncident()async{
    const url = "${root}incident/getAllTypeOfIncident";
    final response = await authHttp.get(Uri.parse(url),headers: getHeaders());
    try{
      final responseBody = json.decode(response.body);
      if(responseBody["status"] == true){
        final itemList = responseBody["model"] as List;
        return itemList.map((e) => AllTypeIncidentModel.fromJson(e)).toList();
      }else{
        throw ApiError.fromResponse(responseBody["msg"]);
      }
    }catch(e){
      _handleError(e);
    }
    return[];
  }


  Future<List<AllBodyPartsModel>> getAllBodyParts()async{
    const url = "${root}incident/getAllBodyParts";
    final response = await authHttp.get(Uri.parse(url),headers: getHeaders());
    try{
      final responseBody = json.decode(response.body);
      if(responseBody["status"] == true){
        final itemList = responseBody["model"] as List;
        return itemList.map((e) => AllBodyPartsModel.fromJson(e)).toList();
      }else{
        throw ApiError.fromResponse(responseBody["msg"]);
      }
    }catch(e){
      _handleError(e);
    }
    return[];
  }


  Future<List<EmployeeShiftModel>> getEmployeeShift()async{
    const url = "${root}mastShift/getAllShift";
    final response = await authHttp.get(Uri.parse(url),headers: getHeaders());
    try{
      final responseBody = json.decode(response.body);
      if(responseBody["status"] == true){
        final itemList = responseBody["model"] as List;
        return itemList.map((e) => EmployeeShiftModel.fromJson(e)).toList();
      }else{
        throw ApiError.fromResponse(responseBody["msg"]);
      }
    }catch(e){
      _handleError(e);
    }
    return[];
  }

  //Save Incident

  Future<String?> getSaveObservation(
      Uint8List fileBytes,
      String incidentDateTime,
      String shift,
      String employeeCode,
      String employeeName,
      String age,
      String gender,
      String wrkGrp,
      String contractorName,
      String contCode,
      String plant,
      String plantCode,
      String deptName,
      String deptCode,
      String location,
      String responsibleShiftEngg,
      String responsibleHod,
      String contactNumber,
      String incidentType,
      String descpOfIncident,
      ) async {
    const url = "${root}incidentReport/saveNewIncidentReport";

    try {
      var request = http.MultipartRequest("POST", Uri.parse(url));
      authHttp.attachAuth(request);

      if (fileBytes.isNotEmpty) {
        request.files.add(http.MultipartFile.fromBytes(
          'image',
          fileBytes,
          filename: 'upload.jpg',
          contentType: MediaType('image', 'jpeg'),
        ));
      }

      request.fields['incidentDateTime'] = incidentDateTime;
      request.fields['shift'] = shift;
      request.fields['employeeCode'] = employeeCode;
      request.fields['employeeName'] = employeeName;
      request.fields['age'] = age;
      request.fields['gender'] = gender;
      request.fields['wrkGrp'] = wrkGrp;
      request.fields['contractorName'] = contractorName;
      request.fields['contCode'] = contCode;
      request.fields['plant'] = plant;
      request.fields['plantCode'] = plantCode;
      request.fields['deptName'] = deptName;
      request.fields['deptCode'] = deptCode;
      request.fields['location'] = location;
      request.fields['responsibleShiftEngg'] = responsibleShiftEngg;
      request.fields['responsibleHod'] = responsibleHod;
      request.fields['contactNumber'] = contactNumber;
      request.fields['incidentType'] = incidentType;
      request.fields['descpOfIncident'] = descpOfIncident;
      var res = await request.send();
      var results = await http.Response.fromStream(res);
      authHttp.check(results);
      var finalres = jsonDecode(results.body) as Map<String, dynamic>;

      if (finalres['status'] == true) {
        return finalres['msg'];
      } else {
        throw Exception(finalres['msg']);
      }
    } catch (e) {
      if (e is String) {
        throw Exception(e);
      }
      // Only wrap genuinely unexpected errors (network, parsing, etc.)
      throw Exception("An error occurred while saving the observation: $e");
    }

  }


  Future<String?> saveInvestigationReport({
    required Uint8List imageBytes,
    required String incidentUniqueId,
    required String reportDate,
    required List<Map<String, String>> team,
    required List<String> rootCauses,
    required List<Map<String, dynamic>> capa,
  }) async {
    const url = "${root}investigationReport/saveInvestigationReport";
    try {
      var request = http.MultipartRequest("POST", Uri.parse(url));
      authHttp.attachAuth(request);

      request.files.add(http.MultipartFile.fromBytes(
        'image',
        imageBytes,
        filename: 'upload.jpg',
        contentType: MediaType('image', 'jpeg'),
      ));

      request.fields['incidentUniqueId'] = incidentUniqueId;
      request.fields['reportDate'] = reportDate;
      request.fields['team'] = jsonEncode(team);
      request.fields['rootCauses'] = jsonEncode(rootCauses);
      request.fields['capa'] = jsonEncode(capa);

      var res = await request.send();
      var results = await http.Response.fromStream(res);
      authHttp.check(results);
      var finalres = jsonDecode(results.body) as Map<String, dynamic>;

      if (finalres['status'] == true) {
        return finalres['msg']?.toString();
      } else {
        throw Exception(finalres['msg']?.toString() ?? 'Save failed');
      }
    } catch (e) {
      if (e is String) throw Exception(e);
      throw Exception(
          "An error occurred while saving the investigation report: $e");
    }
  }

  Future<
      ({
        List<InvestigationReportResponse> items,
        int totalElements,
        int totalPages,
        int currentPage,
        int pageSize,
        bool hasNext,
        bool hasPrevious,
      })> getAllInvestigationReport({int page = 1, int pageSize = 10}) async {
    final url = Uri.parse(
        "${root}investigationReport/getAllInvestigationReport?page=$page&pageSize=$pageSize");
    try {
      final response = await authHttp.get(url, headers: getHeaders());
      if (response.statusCode < 200 || response.statusCode >= 300) {
        throw ApiError.fromResponse(
            'Server error ${response.statusCode}: ${response.body}');
      }
      final responseBody = json.decode(response.body);
      final model = (responseBody is Map) ? responseBody['model'] : null;

      int asInt(dynamic v, int fallback) =>
          v is int ? v : int.tryParse('${v ?? ''}') ?? fallback;
      bool asBool(dynamic v) => v is bool ? v : false;

      final rawItems = (model is Map) ? model['items'] : null;
      final items = (rawItems is List)
          ? rawItems
              .whereType<Map>()
              .map((e) => InvestigationReportResponse.fromJson(
                  e.cast<String, dynamic>()))
              .toList()
          : <InvestigationReportResponse>[];

      if (model is Map) {
        return (
          items: items,
          totalElements: asInt(model['totalElements'], items.length),
          totalPages: asInt(model['totalPages'], items.isEmpty ? 0 : 1),
          currentPage: asInt(model['currentPage'], page),
          pageSize: asInt(model['pageSize'], pageSize),
          hasNext: asBool(model['hasNext']),
          hasPrevious: asBool(model['hasPrevious']),
        );
      }
      return (
        items: items,
        totalElements: items.length,
        totalPages: items.isEmpty ? 0 : 1,
        currentPage: page,
        pageSize: pageSize,
        hasNext: false,
        hasPrevious: false,
      );
    } catch (e) {
      if (e is ApiError) rethrow;
      if (e is SocketException) throw ApiError.internet();
      if (e is TimeoutException) throw ApiError.timeOut();
      throw ApiError.fromResponse(e.toString());
    }
  }

  Future<List<InvestigationReportResponse>> getInvestigationReportByUniqueId(
      String incidentUniqueId) async {
    const url = "${root}investigationReport/getByIncidentUniqueId";
    try {
      final response = await authHttp.post(
        Uri.parse(url),
        body: json.encode({"incidentUniqueId": incidentUniqueId}),
        headers: getHeaders(),
      );
      if (response.statusCode < 200 || response.statusCode >= 300) {
        throw ApiError.fromResponse(
            'Server error ${response.statusCode}: ${response.body}');
      }
      final responseBody = json.decode(response.body);
      if (responseBody is Map && responseBody['status'] == true) {
        final raw = responseBody['model'];
        if (raw is List) {
          return raw
              .whereType<Map>()
              .map((e) => InvestigationReportResponse.fromJson(
                  e.cast<String, dynamic>()))
              .toList();
        }
        return <InvestigationReportResponse>[];
      }
      // status:false with "No Investigation Report found…" is a normal empty result
      return <InvestigationReportResponse>[];
    } catch (e) {
      if (e is ApiError) rethrow;
      if (e is SocketException) throw ApiError.internet();
      if (e is TimeoutException) throw ApiError.timeOut();
      throw ApiError.fromResponse(e.toString());
    }
  }

  Future<List<String>> getAllIncidentReportUniqueIds() async {
    const url = "${root}incidentReport/getAllUniqueIds";
    final response = await authHttp.get(Uri.parse(url), headers: getHeaders());
    try {
      final responseBody = json.decode(response.body);
      if (responseBody["status"] == true) {
        final itemList = responseBody["model"] as List;
        return itemList.map((e) => e.toString()).toList();
      } else {
        throw ApiError.fromResponse(responseBody["msg"]);
      }
    } catch (e) {
      _handleError(e);
    }
    return [];
  }

  Future<List<AllMedicalOfficerListModel>> getAllMedicalOfficerList()async{
    const url = "${root}incidentReport/getPendingForMedicalOfficer";
    final response = await authHttp.get(Uri.parse(url),headers: getHeaders());
    try{
      final responseBody = json.decode(response.body);
      if(responseBody["status"] == true){
        final itemList = responseBody["model"] as List;
        return itemList.map((e) => AllMedicalOfficerListModel.fromJson(e)).toList();
      }else{
        throw ApiError.fromResponse(responseBody["msg"]);
      }
    }catch(e){
      _handleError(e);
    }
    return[];
  }

  ///Save Medical Response

  Future<String?> saveMedicalResponse(Map<String, dynamic>data) async {
    const url = '${root}medicalOfficerResponse/saveMedicalOfficerResponse';
    final body = data;
    try {
      final response = await authHttp.post(Uri.parse(url), body: json.encode(body), headers: getHeaders());
      if (response.statusCode < 200 || response.statusCode >= 300) {
        throw ApiError.fromResponse(
            'Server error ${response.statusCode}: ${response.body}');
      }
      final dynamic responseBody;
      try {
        responseBody = json.decode(response.body);
      } on FormatException {
        throw ApiError.fromResponse(
            'Invalid response from server: ${response.body}');
      }
      if (responseBody is Map && responseBody['status'] == true) {
        return responseBody['message']?.toString();
      } else {
        final msg = (responseBody is Map)
            ? (responseBody['message'] ?? responseBody['msg'])?.toString()
            : null;
        throw ApiError.fromResponse(msg ?? 'Save failed');
      }
    } catch (e) {
      _handleError(e);
    }
    return null;
  }


  ///Complete Medical Response

  ///Safety Remark List

  Future<List<SafetyRemarkListModel>> getSafetyRemarkList()async{
    const url = "${root}medicalOfficerResponse/getPendingForSafety";
    final response = await authHttp.get(Uri.parse(url),headers: getHeaders());
    try{
      final responseBody = json.decode(response.body);
      if(responseBody["status"] == true){
        final itemList = responseBody["model"] as List;
        // Server may return numeric values for fields the model types as
        // String (employeeCode, contCode, plantCode, deptCode, contactNumber).
        // Stringify numeric values for any key except those the model genuinely
        // expects as int.
        const numericKeys = {'id', 'incidentReportId', 'age', 'restUpto'};
        Map<String, dynamic> coerce(Map e) {
          final out = <String, dynamic>{};
          e.forEach((k, v) {
            final key = k.toString();
            if (v is num && !numericKeys.contains(key)) {
              out[key] = v.toString();
            } else {
              out[key] = v;
            }
          });
          return out;
        }
        return itemList
            .whereType<Map>()
            .map((e) => SafetyRemarkListModel.fromJson(coerce(e)))
            .toList();
      }else{
        throw ApiError.fromResponse(responseBody["msg"]);
      }
    }catch(e){
      _handleError(e);
    }
    return[];
  }

  /// Complete Safety Remark

  Future<List<CompleteSafetyRemarkModel>> getCompleteSafetyRemark()async{
    const url = "${root}safetyRemarks/getCompletedForSafety";
    final response = await authHttp.get(Uri.parse(url),headers: getHeaders());
    try{
      final responseBody = json.decode(response.body);
      if(responseBody["status"] == true){
        final itemList = responseBody["model"] as List;
        // Server may return numeric values for fields the model types as
        // String (employeeCode, contCode, plantCode, deptCode, contactNumber,
        // restUpto). Stringify numeric values for any key except those the
        // model genuinely expects as int.
        const numericKeys = {'id', 'incidentReportId', 'age'};
        Map<String, dynamic> coerce(Map e) {
          final out = <String, dynamic>{};
          e.forEach((k, v) {
            final key = k.toString();
            if (v is num && !numericKeys.contains(key)) {
              out[key] = v.toString();
            } else {
              out[key] = v;
            }
          });
          return out;
        }
        return itemList
            .whereType<Map>()
            .map((e) => CompleteSafetyRemarkModel.fromJson(coerce(e)))
            .toList();
      }else{
        throw ApiError.fromResponse(responseBody["msg"]);
      }
    }catch(e){
      _handleError(e);
    }
    return[];
  }

  ///Complete Medical Response

  Future<List<CompleteMedicalResponseModel>> getCompleteMedicalResponse()async{
    const url = "${root}medicalOfficerResponse/getCompletedForMedicalOfficer";
    final response = await authHttp.get(Uri.parse(url),headers: getHeaders());
    try{
      final responseBody = json.decode(response.body);
      if(responseBody["status"] == true){
        final itemList = responseBody["model"] as List;
        // Server may return numeric values for fields the model types as
        // String (employeeCode, contCode, plantCode, deptCode, contactNumber,
        // etc.). Stringify numeric values for any key except the three the
        // model genuinely expects as int.
        const numericKeys = {'id', 'incidentReportId', 'age'};
        Map<String, dynamic> coerce(Map e) {
          final out = <String, dynamic>{};
          e.forEach((k, v) {
            final key = k.toString();
            if (v is num && !numericKeys.contains(key)) {
              out[key] = v.toString();
            } else {
              out[key] = v;
            }
          });
          return out;
        }
        return itemList
            .whereType<Map>()
            .map((e) => CompleteMedicalResponseModel.fromJson(coerce(e)))
            .toList();
      }else{
        throw ApiError.fromResponse(responseBody["msg"]);
      }
    }catch(e){
      _handleError(e);
    }
    return[];
  }

  /// Download FIR/Safety Remark PDF for the given incident unique ID.
  /// Returns the raw PDF bytes, or null on failure.
  Future<Uint8List?> downloadFirPdfByUid(String uniqueId) async {
    const url = "${root}firReport/downloadPdfByUid";
    try {
      final response = await authHttp.post(
        Uri.parse(url),
        body: json.encode({"uniqueId": uniqueId}),
        headers: getHeaders(),
      );
      if (response.statusCode == 200) {
        final contentType =
            (response.headers['content-type'] ?? '').toLowerCase();
        if (contentType.contains('application/pdf') ||
            contentType.contains('octet-stream')) {
          return response.bodyBytes;
        }
        // Some endpoints wrap responses in JSON {status, msg}.
        try {
          final responseBody = json.decode(response.body);
          if (responseBody is Map && responseBody['status'] == false) {
            throw ApiError.fromResponse(responseBody['msg'] ??
                responseBody['message'] ??
                'PDF download failed');
          }
        } catch (_) {
          // Body isn't JSON — fall through and treat as binary PDF.
        }
        return response.bodyBytes;
      }
      throw ApiError.fromResponse(
          'PDF download failed (${response.statusCode})');
    } catch (e) {
      _handleError(e);
    }
    return null;
  }

  ///Save Safety Remark

  Future<String?> saveSafetyRemarkResponse(Map<String, dynamic>data) async {
    const url = '${root}safetyRemarks/saveSafetyRemarks';
    final body = data;
    try {
      final response = await authHttp.post(Uri.parse(url), body: json.encode(body), headers: getHeaders());
      final responseBody = json.decode(response.body);
      if (responseBody['status'] == true) {
        return responseBody ['message'];
      } else {
        throw ApiError.fromResponse(responseBody['message']);
      }
    } catch (e) {
      _handleError(e);
    }
    return null;
  }


  /// All Incident

  Future<
      ({
        List<AllIncidentModel> items,
        int totalElements,
        int totalPages,
        int currentPage,
        int pageSize,
        bool hasNext,
        bool hasPrevious,
      })> getAllIncident(
    String uniqueId,
    String plant,
    String deptName,
    String responsibleShiftEngg,
    String status,
    String firDateTimeFrom,
    String firDateTimeTo,
    int page, {
    int pageSize = 10,
  }) async {
    const url = "${root}incidentReport/getIncidentReportFullViewByShiftEngg";
    final body = {
      "uniqueId": uniqueId,
      "plant": plant,
      "deptName": deptName,
      "responsibleShiftEngg": responsibleShiftEngg,
      "status": status,
      "firDateTimeFrom": firDateTimeFrom,
      "firDateTimeTo": firDateTimeTo,
      "page": page,
      "pageSize": pageSize,
    };
    try {
      final response = await authHttp.post(Uri.parse(url), body: json.encode(body), headers: getHeaders());
      if (response.statusCode < 200 || response.statusCode >= 300) {
        throw ApiError.fromResponse(
            'Server error ${response.statusCode}: ${response.body}');
      }
      final dynamic responseBody;
      try {
        responseBody = json.decode(response.body);
      } on FormatException {
        throw ApiError.fromResponse(
            'Invalid response from server: ${response.body}');
      }
      if (responseBody is Map && responseBody['status'] == true) {
        final model = responseBody['model'];
        final raw = (model is Map) ? model['items'] : model;
        // Server returns some code/number fields (employeeCode, contCode,
        // plantCode, deptCode, contactNumber, ...) as numbers even though the
        // model types them as String. Stringify numeric values for any key
        // except `id` and `age`, which the model genuinely expects as int.
        Map<String, dynamic> coerceIncidentJson(Map e) {
          const numericKeys = {'id', 'age'};
          final out = <String, dynamic>{};
          e.forEach((k, v) {
            final key = k.toString();
            if (v is num && !numericKeys.contains(key)) {
              out[key] = v.toString();
            } else {
              out[key] = v;
            }
          });
          return out;
        }
        final items = (raw is List)
            ? raw
                .whereType<Map>()
                .map((e) => AllIncidentModel.fromJson(coerceIncidentJson(e)))
                .toList()
            : <AllIncidentModel>[];
        int asInt(dynamic v, int fallback) =>
            v is int ? v : int.tryParse('${v ?? ''}') ?? fallback;
        bool asBool(dynamic v) => v is bool ? v : false;
        if (model is Map) {
          return (
            items: items,
            totalElements: asInt(model['totalElements'], items.length),
            totalPages: asInt(model['totalPages'], 1),
            currentPage: asInt(model['currentPage'], page),
            pageSize: asInt(model['pageSize'], pageSize),
            hasNext: asBool(model['hasNext']),
            hasPrevious: asBool(model['hasPrevious']),
          );
        }
        return (
          items: items,
          totalElements: items.length,
          totalPages: 1,
          currentPage: page,
          pageSize: pageSize,
          hasNext: false,
          hasPrevious: false,
        );
      } else {
        final msg = (responseBody is Map)
            ? (responseBody['msg'] ?? responseBody['message'])?.toString()
            : null;
        throw ApiError.fromResponse(msg ?? 'Failed to load incidents');
      }
    } catch (e) {
      if (e is ApiError) rethrow;
      if (e is SocketException) throw ApiError.internet();
      if (e is TimeoutException) throw ApiError.timeOut();
      throw ApiError.fromResponse(e.toString());
    }
  }


  _handleError(var e) {
    if (e is String) throw e;
    if (e is SocketException) throw ApiError.internet();
    if (e is TimeoutException) throw ApiError.timeOut();
    if (e is ApiError) throw e;
    throw ApiError.unKnown();
  }
}