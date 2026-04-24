import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:jsaw_limited/model/allBodyParts_model.dart';
import 'package:jsaw_limited/model/allContractor_model.dart';
import 'package:jsaw_limited/model/allNatureInjury_model.dart';
import 'package:jsaw_limited/model/allTypeIncident_model.dart';
import 'package:jsaw_limited/model/employeeBasicDetail_model.dart';
import 'package:jsaw_limited/model/employeeShift_model.dart';
import '../error/api_error.dart';
import 'constant.dart';

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
    const url = "${root}incident/getAllTypeOfInjury";
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

  _handleError(var e) {
    if (e is String) throw e;
    if (e is SocketException) throw ApiError.internet();
    if (e is TimeoutException) throw ApiError.timeOut();
    if (e is ApiError) throw e;
    throw ApiError.unKnown();
  }
}