import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:jsaw_limited/model/allSafetyObservationByManager_Graph_model.dart';
import 'package:http/http.dart' as http;
import 'package:jsaw_limited/model/departmentgraphExport_model.dart';
import 'package:jsaw_limited/model/graph2_model.dart';
import 'package:jsaw_limited/model/hazardGraphExport_model.dart';
import 'package:jsaw_limited/model/hazard_graph_model.dart';
import 'package:jsaw_limited/model/stationwise_graph_export.dart';
import 'package:jsaw_limited/model/stationwise_graph_tableexport_model.dart';
import 'package:jsaw_limited/model/stationwise_graphtable_model.dart';
import 'package:jsaw_limited/model/userwise_table_export.dart';
import 'package:jsaw_limited/model/userwise_tablegraph_model.dart';
import '../error/api_error.dart';
import '../model/allDesignation_model.dart';
import '../model/allsafetyObservationRaisedModelbyengg_model.dart';
import '../model/allsafetyobservationraised_pieGrpah_model.dart';
import '../model/observation_status_List_model.dart';
import '../model/observationstatus_model.dart';
import 'constant.dart';
import 'package:web/web.dart' show window;

class GraphService{

  Future<List<AllSafetyObservationByManagerandEnggModel>> getSafetyBymanagerGraph(String startDate, String endDate)async{
    const url = "${root}observation/allSafetyObservationsByTheManagersAndEngineers";
    final body = {
      "startDate": startDate ,
      "endDate": endDate ,
      "designationName": ""
    };
    final response = await http.post(Uri.parse(url),headers: headers, body: json.encode(body));
    try{
      final responseBody = json.decode(response.body);

      if(responseBody["status"] == true){
        final itemList = responseBody["model"] as List;
        print("Session ID: ${responseBody['sessionID']}");
        window.localStorage.setItem('kgraph1session', responseBody['sessionID'].toString());
        return itemList.map((e) => AllSafetyObservationByManagerandEnggModel.fromJson(e)).toList();
      }else{
        ApiError.fromResponse(responseBody["msg"]);
      }
    }catch(e){
      _handleError(e);
    }
    return[];
  }


  Future<List<AllSafetyObservationRaisedByManagerandEnggModel>> getSafetyRaisedBymanagerGraph(String startDate, String endDate)async{
    const url = "${root}observation/allSafetyObservationsByTheManagersAndEngineersRaised";
    final body = {
      "startDate": startDate ,
      "endDate": endDate ,
      "sessionID": ""
    };
    final response = await http.post(Uri.parse(url),headers: headers, body: json.encode(body));
    try{
      final responseBody = json.decode(response.body);

      if(responseBody["status"] == true){
        final itemList = responseBody["model"] as List;
        print("Session ID: ${responseBody['sessionID']}");
        window.localStorage.setItem('kgraph5session', responseBody['sessionID'].toString());
        return itemList.map((e) => AllSafetyObservationRaisedByManagerandEnggModel.fromJson(e)).toList();
      }else{
        ApiError.fromResponse(responseBody["msg"]);
      }
    }catch(e){
      _handleError(e);
    }
    return[];
  }

  Future<List<AllSafetyObservationRaisedByManagerandEnggModelPieChart>> getSafetyRaisedBymanagerPieGraph(String startDate, String endDate)async{
    const url = "${root}observation/getObservationStatusCountsWithDateFilter";
    final body = {
      "startDate": startDate ,
      "endDate": endDate ,
    };
    final response = await http.post(Uri.parse(url),headers: headers, body: json.encode(body));
    try{
      final responseBody = json.decode(response.body);

      if(responseBody["status"] == true){
        final itemList = responseBody["model"] as List;
        return itemList.map((e) => AllSafetyObservationRaisedByManagerandEnggModelPieChart.fromJson(e)).toList();
      }else{
        ApiError.fromResponse(responseBody["msg"]);
      }
    }catch(e){
      _handleError(e);
    }
    return[];
  }

  Future<List<ObservationStatusListModel>> getObservationStatusList()async{

    const url = "${root}observation/getObservationStatusCountsList";

    final response = await http.get(Uri.parse(url),headers: headers);
    try{
      final responseBody = json.decode(response.body);
      if(responseBody["status"] == true){
        final itemList = responseBody["model"] as List;
        return itemList.map((e) => ObservationStatusListModel.fromJson(e)).toList();
      }else{
        throw ApiError.fromResponse(responseBody["msg"]);
      }
    }catch(e){
      _handleError(e);
    }
    return [];
  }

  Future<List<Graph2Model>> getGraph2Data(String startDate, String endDate) async {
    const url = "${root}observation/graph2";
    final body = {
      "startDate": startDate ,
      "endDate": endDate ,
      "designationName": ""
    };
    try {
      final response = await http.post(Uri.parse(url), headers: headers, body: json.encode(body));

      if (response.statusCode == 200) {

    //  Decode the response and directly access the 'model' field
    final Map<String, dynamic> data = json.decode(response.body);

    // Print the sessionID
    print("Session ID: ${data['sessionID']}");
    window.localStorage.setItem('kGraph2session', data['sessionID'].toString());
    // Map the 'model' field to a List<Graph2Model>
    return (data['model'] as List<dynamic>)
        .map((json) => Graph2Model.fromJson(json))
        .toList();
        // List<dynamic> data = json.decode(response.body);
        // return data.map((json) => Graph2Model.fromJson(json)).toList();
      } else {
        print('Request failed with status: ${response.statusCode}');
        throw Exception('NO DATA FOUND');
      }
    } catch (e) {
      print('Error occurred: $e');
      throw _handleError(e);
    }
  }


  Future<List<UserWiseTableGraphModel>> getUserwiseData(String startDate, String endDate, String designationCode)async{
    const url = "${root}observation/GraphUserWise";

    final body = {
      "startDate": startDate ,
      "endDate": endDate ,
      "designationName": designationCode
    };
    final response = await http.post(Uri.parse(url),headers: headers, body: json.encode(body));
    try{
      final responseBody = json.decode(response.body);
      if(responseBody["status"] == true){
        window.localStorage.setItem('kGraph3sessionID', responseBody['sessionID'].toString());
        final itemList = responseBody["model"] as List;
        return itemList.map((e) => UserWiseTableGraphModel.fromJson(e)).toList();
      }else{
        ApiError.fromResponse(responseBody["msg"]);
      }
    }catch(e){
      _handleError(e);
    }
    return[];
  }

  Future<List<StationWiseGraphTableModel>> getStationwiseData(String startDate, String endDate)async{
    const url = "${root}observation/GraphStationsWise";
    final body = {
      "startDate": startDate ,
      "endDate": endDate ,
      "designationName": ""
    };
    final response = await http.post(Uri.parse(url),body: json.encode(body),headers: headers);
    try{
      final responseBody = json.decode(response.body);
      if(responseBody["status"] == true){
        print("Session ID: ${responseBody['sessionID']}");
        window.localStorage.setItem('kGraph4sessionID', responseBody['sessionID'].toString());
        final itemList = responseBody["model"] as List;
        return itemList.map((e) => StationWiseGraphTableModel.fromJson(e)).toList();
      }else{
        ApiError.fromResponse(responseBody["msg"]);
      }
    }catch(e){
      _handleError(e);
    }
    return[];
  }

  Future<List<HazardGraphModel>> getHazardGraphData(String startDate, String endDate)async{
    const url = "${root}observation/findObservationCountAndPercentageByHazardCategory";
    final body = {
      "startDate": startDate ,
      "endDate": endDate ,
    };
    final response = await http.post(Uri.parse(url),body: json.encode(body),headers: headers);
    try{
      final responseBody = json.decode(response.body);
      if(responseBody["status"] == true){
        final itemList = responseBody["model"] as List;
        return itemList.map((e) => HazardGraphModel.fromJson(e)).toList();
      }else{
        ApiError.fromResponse(responseBody["msg"]);
      }
    }catch(e){
      _handleError(e);
    }
    return[];
  }

  Future<DepartmentgraphExportModel?> generateExport()async{
    const url = "${root}observation/departmentGraphExport";
    final body = {
      "startDate": "" ,
      "endDate": "" ,
      "designationName": "",
      "sessionID": window.localStorage.getItem('kgraph1session') ,
    };
    try {
     final response = await http.post(Uri.parse(url), body: json.encode(body),headers: headers);
      final responseBody = json.decode(response.body);
      if (responseBody['status'] == true) {
        return DepartmentgraphExportModel.fromJson(responseBody["model"]);
      } else {
        ApiError.fromResponse(responseBody['msg']);
      }
    } catch (e) {
      _handleError(e);
    }
    return const DepartmentgraphExportModel();
  }

  Future<HazardGraphExportModel?> generateHazardGraphExport()async{
    const url = "${root}observation/HazardGraphExport";
    final body = {
      "startDate": "" ,
      "endDate": "" ,
    };
    try {
      final response = await http.post(Uri.parse(url), body: json.encode(body),headers: headers);
      final responseBody = json.decode(response.body);
      if (responseBody['status'] == true) {
        return HazardGraphExportModel.fromJson(responseBody["model"]);
      } else {
        ApiError.fromResponse(responseBody['msg']);
      }
    } catch (e) {
      _handleError(e);
    }
    return const HazardGraphExportModel();
  }

  Future<StationWiseGraphExportModel?> generateStationWiseExport(String startDate, String endDate)async{
    const url = "${root}observation/stationGraphExport";
    final body = {
      "startDate":"",
      "endDate":"",
      "designationName":"",
      "sessionID": window.localStorage.getItem('kGraph2session') ,
    };

    try {
      final response = await http.post(Uri.parse(url),body: json.encode(body), headers: headers);
      final responseBody = json.decode(response.body);
      if (responseBody['status'] == true) {
        return StationWiseGraphExportModel.fromJson(responseBody["model"]);
      } else {
        ApiError.fromResponse(responseBody['msg']);
      }
    } catch (e) {
      print(e);
      _handleError(e);
    }
    return const StationWiseGraphExportModel();
  }

  Future<UserWiseTableExport?> generateUserwiseTableExport(String startDate, String endDate, String designation)async{
    const url = "${root}observation/userWiseTableExport";
    final body = {
      "startDate":"",
      "endDate":"",
      "designationName":"",
      "sessionID": window.localStorage.getItem('kGraph3sessionID') ,
      //116500
    };

    try {
      final response = await http.post(Uri.parse(url),body: json.encode(body), headers: headers);
      final responseBody = json.decode(response.body);
      if (responseBody['status'] == true) {
        return UserWiseTableExport.fromJson(responseBody["model"]);
      } else {
        ApiError.fromResponse(responseBody['msg']);
      }
    } catch (e) {
      _handleError(e);
    }
    return const UserWiseTableExport();
  }

  Future<StationWiseTableExportModel?> generateStationWiseTableExport(String startDate, String endDate,)async{
    const url = "${root}observation/stationWiseTableExport";
    final body = {
      "startDate":"",
      "endDate":"",
      "designationName":"",
      "sessionID": window.localStorage.getItem('kGraph4sessionID') ,
    };
    try {
      final response = await http.post(Uri.parse(url),body: json.encode(body), headers: headers);
      final responseBody = json.decode(response.body);
      if (responseBody['status'] == true) {
        return StationWiseTableExportModel.fromJson(responseBody["model"]);
      } else {
        ApiError.fromResponse(responseBody['msg']);
      }
    } catch (e) {
      _handleError(e);
    }
    return const StationWiseTableExportModel();
  }

  Future<List<AllDesignationModel>> getAllDesignation()async{
    const url = "${root}observation/getAllDesignation";
    final response = await http.get(Uri.parse(url),headers: headers);
    try{
      final responseBody = json.decode(response.body);
      if(responseBody["status"] == true){
        final itemList = responseBody["model"] as List;
        return itemList.map((e) => AllDesignationModel.fromJson(e)).toList();
      }else{
         ApiError.fromResponse(responseBody["msg"]);
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