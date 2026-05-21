import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:jsaw_limited/model/allhazard_cat_model.dart';
import 'package:jsaw_limited/model/alltoday_observation_model.dart';
import 'package:jsaw_limited/model/observationstatus_model.dart';
import 'package:jsaw_limited/model/top3hazard_model.dart';
import '../error/api_error.dart';
import 'constant.dart';
import 'auth_http.dart';
import 'package:http/http.dart' as http;

class DashboardService{

  Future<List<AllTodayObservationModel>> getAllTodayObservation(String hazardCategory)async{
    const url = "${root}observation/getAllTodayObservation";
    final data = {'hazardCategory': hazardCategory};
    final response = await authHttp.post(Uri.parse(url), body: json.encode(data),headers: getHeaders());
    try{
      final responseBody = json.decode(response.body);
      if(responseBody["status"] == true){
        final itemList = responseBody["model"] as List;
        return itemList.map((e) => AllTodayObservationModel.fromJson(e)).toList();
      }else{
        return[];
        throw ApiError.fromResponse(responseBody["msg"]);
      }
    }catch(e){
      _handleError(e);
    }
    return[];
  }

  Future<List<AllHazardCatModel>> getAllHazardList()async{
    const url = "${root}hazardCategory/getAllHazardCategory";
    final response = await authHttp.get(Uri.parse(url),headers: getHeaders());
    try{
      final responseBody = json.decode(response.body);
      if(responseBody["status"] == true){
        final itemList = responseBody["model"] as List;
        return itemList.map((e) => AllHazardCatModel.fromJson(e)).toList();
      }else{
        throw ApiError.fromResponse(responseBody["msg"]);
      }
    }catch(e){
      _handleError(e);
    }
    return[];
  }

  Future<ObservationStatusModel> getObservationStatus()async{

    const url = "${root}observation/getObservationStatusCounts";

    final response = await authHttp.get(Uri.parse(url),headers: getHeaders());
    try{
      final responseBody = json.decode(response.body);
      if(responseBody["status"] == true){
        return ObservationStatusModel.fromJson(responseBody["model"]);
      }else{
        throw ApiError.fromResponse(responseBody["msg"]);
      }
    }catch(e){
      _handleError(e);
    }
    return const ObservationStatusModel();
  }


  Future<List<Top3HazardModel>> gettop3hazard()async{
    const url = "${root}observation/getTop3HazardCategories";
    final response = await authHttp.get(Uri.parse(url),headers: getHeaders());
    try{
      final responseBody = json.decode(response.body);
      if(responseBody["status"] == true){
        final itemList = responseBody["model"] as List;
        return itemList.map((e) => Top3HazardModel.fromJson(e)).toList();
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