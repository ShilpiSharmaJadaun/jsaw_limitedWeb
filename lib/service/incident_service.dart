import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:jsaw_limited/model/allBodyParts_model.dart';
import 'package:jsaw_limited/model/allContractor_model.dart';
import 'package:jsaw_limited/model/allIncidentList_model.dart';
import 'package:jsaw_limited/model/allNatureInjury_model.dart';
import 'package:jsaw_limited/model/allTypeIncident_model.dart';
import 'package:jsaw_limited/model/employeeBasicDetail_model.dart';
import 'package:jsaw_limited/model/employeeShift_model.dart';
import '../error/api_error.dart';
import 'constant.dart';
import 'package:http_parser/http_parser.dart';

class IncidentService{

  Future<List<AllContractorModel>> getAllContractorList()async{
    const url = "${root}incident/getAllContactor";
    final response = await http.get(Uri.parse(url),headers: headers);
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
    final response = await http.get(Uri.parse(url),headers: headers);
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
    final response = await http.get(Uri.parse(url),headers: headers);
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
    final response = await http.get(Uri.parse(url),headers: headers);
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
    final response = await http.get(Uri.parse(url),headers: headers);
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
    final response = await http.get(Uri.parse(url),headers: headers);
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
      String workInjury,
      String descpOfIncident,
      ) async {
    const url = "${root}incidentReport/saveNewIncidentReport";

    try {
      var request = http.MultipartRequest("POST", Uri.parse(url));

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
      request.fields['workInjury'] = workInjury;
      request.fields['descpOfIncident'] = descpOfIncident;
      var res = await request.send();
      var results = await http.Response.fromStream(res);
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


  Future<List<AllIncidentListModel>> getAllIncidentList()async{
    const url = "${root}incidentReport/getAllIncidentReport";
    final response = await http.get(Uri.parse(url),headers: headers);
    try{
      final responseBody = json.decode(response.body);
      if(responseBody["status"] == true){
        final itemList = responseBody["model"] as List;
        return itemList.map((e) => AllIncidentListModel.fromJson(e)).toList();
      }else{
        throw ApiError.fromResponse(responseBody["msg"]);
      }
    }catch(e){
      _handleError(e);
    }
    return[];
  }

  _handleError(var e) {
    if (e is String) throw e;
    if (e is SocketException) throw ApiError.internet();
    if (e is TimeoutException) throw ApiError.timeOut();
    if (e is ApiError) throw e;
    throw ApiError.unKnown();
  }
}