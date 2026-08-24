import '../model/activeEmployeeLookup_model.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:jsaw_limited/model/allHod_model.dart';
import 'package:jsaw_limited/model/allemployee_model.dart';
import 'package:jsaw_limited/model/employeefromAppReporting_model.dart';
import 'package:http/http.dart' as http;
import '../error/api_error.dart';
import 'constant.dart';
import 'auth_http.dart';

class EmployeeReportingService{

  Future<List<EmployeeFromAppReportingModel>> getAllEmployeeReporting()async{
    const url = "${root}reportingto/allEmployeeFromAppReporting";
    final response = await authHttp.get(Uri.parse(url),headers: getHeaders());
    try{
      final responseBody = json.decode(response.body);
      if(responseBody["status"] == true){
        final itemList = responseBody["model"] as List;
        return itemList.map((e) => EmployeeFromAppReportingModel.fromJson(e)).toList();
      }else{
        throw ApiError.fromResponse(responseBody["msg"]);
      }
    }catch(e){
      _handleError(e);
    }
    return[];
  }

  Future<List<AllHodModel>?> getAllHod(String empCode)async{
    const url = "${root}reportingto/findAllHodByEmp";
    final body = {"reportResEmpCode" : empCode};
    try {
      final response = await authHttp.post(Uri.parse(url), body: json.encode(body),headers: getHeaders());
      final responseBody = json.decode(response.body);
      if (responseBody['status'] == true) {
        final itemList = responseBody["model"] as List;
        return itemList.map((e) => AllHodModel.fromJson(e)).toList();
      } else {
        throw ApiError.fromResponse(responseBody['msg']);
      }
    } catch (e) {
      _handleError(e);
    }
    return [];
  }

  Future<List<AllEmployeeModel>> getAllEmployee()async{
    const url = "${root}employees/getAllEmployees";
    final response = await authHttp.get(Uri.parse(url),headers: getHeaders());
    try{
      final responseBody = json.decode(response.body);
      if(responseBody["status"] == true){
        final itemList = responseBody["model"] as List;
        return itemList.map((e) => AllEmployeeModel.fromJson(e)).toList();
      }else{
        throw ApiError.fromResponse(responseBody["msg"]);
      }
    }catch(e){
      _handleError(e);
    }
    return[];
  }

  /// ACTIVE employees with station / grade / designation names resolved by
  /// the backend (`employees/getActiveEmployeeLookup`). Used by the
  /// Investigation "Root Cause – Inquired With" picker (point 6).
  Future<List<ActiveEmployeeLookupModel>> getActiveEmployeeLookup() async {
    const url = "${root}employees/getActiveEmployeeLookup";
    final response = await authHttp.get(Uri.parse(url), headers: getHeaders());
    try {
      final responseBody = json.decode(response.body);
      if (responseBody["status"] == true) {
        final itemList = responseBody["model"] as List;
        return itemList
            .map((e) => ActiveEmployeeLookupModel.fromJson(e))
            .toList();
      } else {
        throw ApiError.fromResponse(responseBody["msg"]);
      }
    } catch (e) {
      _handleError(e);
    }
    return [];
  }

  Future<List<AllEmployeeModel>> getAllCompOutSourcAuthUser() async {
    const url = "${root}employees/getAllCompOutSourcAuthUser";
    final response = await authHttp.get(Uri.parse(url), headers: getHeaders());
    try {
      final responseBody = json.decode(response.body);
      if (responseBody["status"] == true) {
        final itemList = responseBody["model"] as List;
        return itemList.map((e) => AllEmployeeModel.fromJson(e)).toList();
      } else {
        throw ApiError.fromResponse(responseBody["msg"]);
      }
    } catch (e) {
      _handleError(e);
    }
    return [];
  }

  //update HOD

  Future<String?> updateHod(Map<String, dynamic>data) async {
    const url = '${root}reportingto/updateByEmpCode';
    final body = data;
    try {
      final response = await authHttp.post(Uri.parse(url), body: json.encode(body), headers: getHeaders());
      final responseBody = json.decode(response.body);
      if (responseBody['status'] == true) {
        return responseBody ['msg'];
      }else{
        throw ApiError.fromResponse(responseBody['error']);
      }
    } catch (e) {
      _handleError(e);
    }
    // return null;
  }

  //insert HOD

  Future<String?> insertHODEmployee(Map<String, dynamic>data) async {
    const url = '${root}reportingto/insertHodCode';
    final body = data;
    try {
      final response = await authHttp.post(Uri.parse(url), body: json.encode(body), headers: getHeaders());
      final responseBody = json.decode(response.body);
      if (responseBody['status'] == true) {
        return responseBody ['msg'];
      }else{
        throw ApiError.fromResponse(responseBody['error']);
      }
    } catch (e) {
      _handleError(e);
    }
    // return null;
  }

  //Delete HOD

  Future<String?> deleteHODEmployee(Map<String, dynamic>data) async {
    const url = '${root}reportingto/deleteByReportResEmpCode';
    final body = data;
    try {
      final response = await authHttp.post(Uri.parse(url), body: json.encode(body), headers: getHeaders());
      final responseBody = json.decode(response.body);
      if (responseBody['status'] == true) {
        return responseBody ['msg'];
      }else{
        throw ApiError.fromResponse(responseBody['error']);
      }
    } catch (e) {
      _handleError(e);
    }
    // return null;
  }

  _handleError(var e) {
    if (e is String) throw e;
    if (e is SocketException) throw ApiError.internet();
    if (e is TimeoutException) throw ApiError.timeOut();
    if (e is ApiError) throw e;
    throw ApiError.unKnown();
  }
}
