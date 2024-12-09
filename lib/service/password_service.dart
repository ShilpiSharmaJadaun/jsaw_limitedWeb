import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../error/api_error.dart';
import 'constant.dart';

class PasswordService{

  Future<String?> updatePassword(Map<String, dynamic>data) async {
    const url = '${root}employees/updatePassword';
    final body = data;
    try {
      final response = await http.post(Uri.parse(url),
          body: json.encode(body), headers: headers);
      final responseBody = json.decode(response.body);
      if (responseBody['status'] == true) {
        return responseBody ['msg'];
      }else{
        throw ApiError.fromResponse(responseBody['error']);
      }
    } catch (e) {
      print(e);
      _handleError(e);
    }
    // return null;
  }


  Future<String?> changePassword(Map<String, dynamic>data) async {
    const url = '${root}employees/changePassword';
    final body = data;
    try {
      final response = await http.post(Uri.parse(url),
          body: json.encode(body), headers: headers);
      final responseBody = json.decode(response.body);
      if (responseBody['status'] == true) {
        return responseBody ['msg'];
      }else{
        throw ApiError.fromResponse(responseBody['error']);
      }
    } catch (e) {
      print(e);
      _handleError(e);
    }
    // return null;
  }


  //Email

  Future<String?> changeEmail(Map<String, dynamic>data) async {
    const url = '${root}employees/updateEmployeeEmail';
    final body = data;
    try {
      final response = await http.post(Uri.parse(url),
          body: json.encode(body), headers: headers);
      final responseBody = json.decode(response.body);
      if (responseBody['status'] == true) {
        return responseBody ['msg'];
      }else{
        throw ApiError.fromResponse(responseBody['error']);
      }
    } catch (e) {
      print(e);
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