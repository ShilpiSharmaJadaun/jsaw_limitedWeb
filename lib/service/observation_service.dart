import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:jsaw_limited/model/allDepartment_model.dart';
import 'package:jsaw_limited/model/all_filter_observation_model.dart';
import 'package:jsaw_limited/model/allobservation_model.dart';
import 'package:http/http.dart' as http;
import 'package:jsaw_limited/model/allplant_model.dart';
import 'package:jsaw_limited/model/alltype_hazard_model.dart';
import 'package:jsaw_limited/model/allwork_group_model.dart';
import 'package:jsaw_limited/model/approve_compliance_model.dart';
import 'package:jsaw_limited/model/employeeResponsibility_model.dart';
import 'package:jsaw_limited/model/filterObservation_model.dart';
import 'package:jsaw_limited/model/generateExcel_model.dart';
import 'package:jsaw_limited/model/location_model.dart';
import 'package:jsaw_limited/model/observationby_uni_model.dart';
import 'package:jsaw_limited/model/plantHead_model.dart';
import 'package:jsaw_limited/model/priority_model.dart';
import 'package:jsaw_limited/model/raisedObservation_model.dart';
import 'package:jsaw_limited/model/raised_feedback_model.dart';
import 'package:jsaw_limited/model/uniqueId_model.dart';
import 'package:jsaw_limited/model/unithead_model.dart';
import '../error/api_error.dart';
import 'constant.dart';
import 'package:http_parser/http_parser.dart';
import 'package:web/web.dart' as html;

class ObservationService{

  // Future<List<AllObservationModel>> getAllObservation()async{
  //   const url = "${root}observation/getObservationAssignToEngg";
  //   final data = {'responsibilityEnggCode': html.window.localStorage['kEmployeeCode'].toString(),};
  //   final response = await http.post(Uri.parse(url), body: json.encode(data), headers: headers);
  //   try{
  //     final responseBody = json.decode(response.body);
  //     if(responseBody["status"] == true){
  //       final itemList = responseBody["model"] as List;
  //       return itemList.map((e) => AllObservationModel.fromJson(e)).toList();
  //     }else{
  //       throw ApiError.fromResponse(responseBody["error"]);
  //     }
  //   }catch(e){
  //     _handleError(e);
  //   }
  //   return[];
  // }

  Future<List<AllObservationModel>> getAllObservationsTillDate()async{
    const url = "${root}observation/getAllObservation";
    final response = await http.get(Uri.parse(url), headers: headers);
    try{
      final responseBody = json.decode(response.body);
      if(responseBody["status"] == true){
        final itemList = responseBody["model"] as List;
        return itemList.map((e) => AllObservationModel.fromJson(e)).toList();
      }else{
        throw ApiError.fromResponse(responseBody["error"]);
      }
    }catch(e){
      _handleError(e);
    }
    return[];
  }


  Future<List<ObservationbyUniModel>> getAllObservationBYUINandEmployee(String UNI, String raisedBy)async{
    const url = "${root}observation/getObservationResponseByUIN";
    final data = {'uniqueIdentificationNumber': UNI, 'observationRaisedByEmpUnqId': raisedBy};
    final response = await http.post(Uri.parse(url), body: json.encode(data),headers: headers);
    try{
      final responseBody = json.decode(response.body);
      if(responseBody["status"] == true){
        final itemList = responseBody["model"] as List;
        return itemList.map((e) => ObservationbyUniModel.fromJson(e)).toList();
      }else{
        throw ApiError.fromResponse(responseBody["msg"]);
      }
    }catch(e){
      _handleError(e);
    }
    return[];
  }

  //All Department API

  Future<List<AllPlantModel>> getAllPlant()async{
    const url = "${root}department/getAllDepartment";
    final data = {};
    final response = await http.post(Uri.parse(url), body: json.encode(data),headers: headers);
    try{
      final responseBody = json.decode(response.body);
      if(responseBody["status"] == true){
        final itemList = responseBody["model"] as List;
        return itemList.map((e) => AllPlantModel.fromJson(e)).toList();
      }else{
        throw ApiError.fromResponse(responseBody["msg"]);
      }
    }catch(e){
      _handleError(e);
    }
    return[];
  }

  //for department

  Future<List<AllDepartmentModel>> getDepartment(String deptCode)async{
    const url = "${root}stations/getAllStationByDeptCode";
    final data = {'deptCode' : deptCode};
    final response = await http.post(Uri.parse(url), body: json.encode(data),headers: headers);
    try{
      final responseBody = json.decode(response.body);
      if(responseBody["status"] == true){
        final itemList = responseBody["model"] as List;
        return itemList.map((e) => AllDepartmentModel.fromJson(e)).toList();
      }else{
        throw ApiError.fromResponse(responseBody["msg"]);
      }
    }catch(e){
      _handleError(e);
    }
    return[];
  }


  //Responsible Employee
  Future<List<EmployeeResponsibilityModel>> getResponsibilityEmployee(String deptCode, String stateCode, String gradeCode, String empUqn)async{
    const url = "${root}employees/getEmployeeForResponsibility";
    final data = {'deptCode' : deptCode, "statCode" : stateCode, "gradeCode" : gradeCode, "empUnqId":empUqn };
    final response = await http.post(Uri.parse(url), body: json.encode(data),headers: headers);
    try{
      final responseBody = json.decode(response.body);
      if(responseBody["status"] == true){
        final itemList = responseBody["model"] as List;
        return itemList.map((e) => EmployeeResponsibilityModel.fromJson(e)).toList();
      }else{
        throw ApiError.fromResponse(responseBody["msg"]);
      }
    }catch(e){
      _handleError(e);
    }
    return[];
  }

  //Work Group

  Future<List<AllWorkGroupModel>> getAllWorkGroup()async{
    const url = "${root}workgroup/findAllWorkGroup";
    final response = await http.get(Uri.parse(url),headers: headers);
    try{
      final responseBody = json.decode(response.body);
      if(responseBody["status"] == true){
        final itemList = responseBody["model"] as List;
        return itemList.map((e) => AllWorkGroupModel.fromJson(e)).toList();
      }else{
        throw ApiError.fromResponse(responseBody["msg"]);
      }
    }catch(e){
      _handleError(e);
    }
    return[];
  }

  //Priority

  Future<List<PriorityModel>> getPriority()async{
    const url = "${root}priorityStatus/getAllPriority";
    final response = await http.get(Uri.parse(url),headers: headers);
    try{
      final responseBody = json.decode(response.body);
      if(responseBody["status"] == true){
        final itemList = responseBody["model"] as List;
        return itemList.map((e) => PriorityModel.fromJson(e)).toList();
      }else{
        throw ApiError.fromResponse(responseBody["msg"]);
      }
    }catch(e){
      _handleError(e);
    }
    return[];
  }

  //location

  Future<List<LocationModel>> getAllLocation(String deptCode)async{
    const url = "${root}locations/findAllLocationByDeptCode";
    final data = {'deptCode' : deptCode};
    final response = await http.post(Uri.parse(url), body: json.encode(data),headers: headers);
    try{
      final responseBody = json.decode(response.body);
      if(responseBody["status"] == true){
        final itemList = responseBody["model"] as List;
        return itemList.map((e) => LocationModel.fromJson(e)).toList();
      }else{
        throw ApiError.fromResponse(responseBody["msg"]);
      }
    }catch(e){
      _handleError(e);
    }
    return[];
  }

  //all type hazard
  Future<List<AllTypeHazardModel>> getAllTypehazard()async{
    const url = "${root}hazardCategory/getAllTypeAHazardCategories";
    final response = await http.get(Uri.parse(url),headers: headers);
    try{
      final responseBody = json.decode(response.body);
      if(responseBody["status"] == true){
        final itemList = responseBody["model"] as List;
        return itemList.map((e) => AllTypeHazardModel.fromJson(e)).toList();
      }else{
        throw ApiError.fromResponse(responseBody["msg"]);
      }
    }catch(e){
      _handleError(e);
    }
    return[];
  }

  //raised observation

  Future<List<RaisedObservationModel>> getAllRaisedObservation(String empUnqCode)async{
    const url = "${root}observation/getObservationByEmpId";
    final data = {'observationRaisedByEmpUnqId' : empUnqCode};
    final response = await http.post(Uri.parse(url), body: json.encode(data),headers: headers);
    try{
      final responseBody = json.decode(response.body);
      if(responseBody["status"] == true){
        final itemList = responseBody["model"] as List;
        return itemList.map((e) => RaisedObservationModel.fromJson(e)).toList();
      }else{
        throw ApiError.fromResponse(responseBody["msg"]);
      }
    }catch(e){
      _handleError(e);
    }
    return[];
  }

  //Save Observation

  Future<String?> getSaveObservation(
      Uint8List fileBytes,
      String observationRaisedBy,
      String observationRaisedByEmpUnqId,
      String plantDeptName,
      String plantDeptCode,
      String locationName,
      String observationPoint,
      String responsibilityEnggName,
      String responsibilityEnggCode,
      String responsibilityHODName,
      String responsibilityHODEmpUnqID,
      String stationName,
      String stationCode,
      String priorityStatusName,
      String remarks,
      String hazardCategoryName,
      String status,
      String wrkGrp,
      String priorityStatusColor,
      String updatedByEmpId,
      String updatedByEmpName,
      String categoryName,
      String correctiveMeasure,
      String plantHead,
      String plantHeadName,
      String plantHeadEmail,
      String observationOccurrenceTime,
      String unitPlantCode,
      String unitPlantName,
      String unitEmpName,
      String unitEmpUnqId,
      String unitEmpEmail,
      String rootCause
      ) async {
    const url = "${root}observation/saveNewObservation";

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

      request.fields['observationRaisedBy'] = observationRaisedBy;
      request.fields['observationRaisedByEmpUnqId'] = observationRaisedByEmpUnqId;
      request.fields['plantDeptName'] = plantDeptName;
      request.fields['plantDeptCode'] = plantDeptCode;
      request.fields['locationName'] = locationName;
      request.fields['observationPoint'] = observationPoint;
      request.fields['responsibilityEnggName'] = responsibilityEnggName;
      request.fields['responsibilityEnggCode'] = responsibilityEnggCode;
      request.fields['responsibilityHODName'] = responsibilityHODName;
      request.fields['responsibilityHODEmpUnqID'] = responsibilityHODEmpUnqID;
      request.fields['StationName'] = stationName;
      request.fields['Station_Code'] = stationCode;
      request.fields['priorityStatusName'] = priorityStatusName;
      request.fields['remarks'] = remarks;
      request.fields['hazardCategoryName'] = hazardCategoryName;
      request.fields['status'] = status;
      request.fields['wrkGrp'] = wrkGrp;
      request.fields['priorityStatusColor'] = priorityStatusColor;
      request.fields['updatedByEmpId'] = updatedByEmpId;
      request.fields['updatedByEmpName'] = updatedByEmpName;
      request.fields['categoryName'] = categoryName;
      request.fields['plantHeadCode'] = plantHead;
      request.fields['plantHeadName'] = plantHeadName;
      request.fields['plantHeadEmail'] = plantHeadEmail;
      request.fields['correctiveMeasure'] = correctiveMeasure;
      request.fields['observationOccurrenceTime'] = observationOccurrenceTime;
      request.fields['unitPlantCode'] = unitPlantCode;
      request.fields['unitPlantName'] = unitPlantName;
      request.fields['unitEmpName'] = unitEmpName;
      request.fields['unitEmpUnqId'] = unitEmpUnqId;
      request.fields['unitEmpEmail'] = unitEmpEmail;
      request.fields["rootCauseOnlyNearMiss"] = rootCause;

      var res = await request.send();
      var results = await http.Response.fromStream(res);
      var finalres = jsonDecode(results.body) as Map<String, dynamic>;

      if (finalres['status'] == true) {
        return finalres['msg'];
      } else {
        throw Exception(finalres['msg']);
      }
    } catch (e) {
      throw Exception("An error occurred while saving the observation.");
    }
  }

  //update Observation

  Future<String?> getUpdateObservation(Map<String, dynamic>data) async {
    const url = '${root}observation/observationsUpdate';
    final body = data;
    try {
      final response = await http.patch(Uri.parse(url), body: json.encode(body), headers: getHeaders());
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

  //suggestion

  Future<String?> getSuggestion(
      Uint8List fileBytes,
      String issueTitle,
      String issueDescription,
      String dateTimeOfOccurrence,
      String softwareVersion,
      String operatingSystem,
      String severity,
      String empUnId,
      String empName,
      String status,

      ) async {
    const url = "${root}complaint/saveNewComplaint";

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

      request.fields['issueTitle'] = issueTitle;
      request.fields['issueDescription'] = issueDescription;
      request.fields['dateTimeOfOccurrence'] = dateTimeOfOccurrence;
      request.fields['softwareVersion'] = softwareVersion;
      request.fields['operatingSystem'] = operatingSystem;
      request.fields['severity'] = severity;
      request.fields['empUnId'] = empUnId;
      request.fields['empName'] = empName;
      request.fields['status'] = status;

      var res = await request.send();
      var results = await http.Response.fromStream(res);
      var finalres = jsonDecode(results.body) as Map<String, dynamic>;

      if (finalres['status'] == true) {
        return finalres['msg'];
      } else {
        throw Exception(finalres['msg']);
      }
    } catch (e) {
      throw Exception("An error occurred while saving the observation.");
    }
  }



  //raised feedback list

  Future<List<SuggestionFeedbackModel>> getSuggestionFeedbackList()async{
    const url = "${root}complaint/getAllComplaint";
    final response = await http.get(Uri.parse(url),headers: headers);
    try{
      final responseBody = json.decode(response.body);
      if(responseBody["status"] == true){
        final itemList = responseBody["model"] as List;
        return itemList.map((e) => SuggestionFeedbackModel.fromJson(e)).toList();
      }else{
        throw ApiError.fromResponse(responseBody["msg"]);
      }
    }catch(e){
      _handleError(e);
    }
    return[];
 }

 //update Com[pliance

  Future<String?> getCompliance(
      Uint8List fileBytes,
      String uniqueIdentificationNumber,
      String observationText,
      String actionTaken,
      String status,
      String remarks,
      String updatedByEmpId,
      String updatedByEmpName,
      String updatedByEmail,
      String raisedByEmpID,) async {
    const url = "${root}observation/updateObservationResponse";

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

      request.fields['uniqueIdentificationNumber'] = uniqueIdentificationNumber;
      request.fields['observationText'] = observationText;
      request.fields['actionTaken'] = actionTaken;
      request.fields['status'] = status;
      request.fields['remarks'] = remarks;
      request.fields['updatedByEmpId'] = updatedByEmpId;
      request.fields['updatedByEmpName'] = updatedByEmpName;
      request.fields['updatedByEmail'] = updatedByEmail;
      request.fields['raisedByEmpID'] = raisedByEmpID;

      var res = await request.send();
      var results = await http.Response.fromStream(res);
      var finalres = jsonDecode(results.body) as Map<String, dynamic>;

      if (finalres['status'] == true) {
        return finalres['msg'];
      } else {
        throw Exception(finalres['msg']);
      }
    } catch (e) {
      throw Exception("An error occurred while saving the observation.");
    }
  }


  // approve compliance

  Future<List<ApproveComplianceModel>> getComplianceList()async{
    const url = "${root}observation/getAllObservationByStatus";
    final data = {'status' : 'COMPLIANCE'};
     try{
       final response = await http.post(Uri.parse(url),headers: headers, body: json.encode(data));
       final responseBody = json.decode(response.body);
      if(responseBody["status"] == true){
        final itemList = responseBody["model"] as List;
        return itemList.map((e) => ApproveComplianceModel.fromJson(e)).toList();
      }else{
        ApiError.fromResponse(responseBody["msg"]);
      }
    }catch(e,stackTrace){
      print(stackTrace);
      _handleError(e);
    }
    return[];
  }

  //COMPLAINCE APPROVE

  Future<String?> getComplianceApproveReject(Map<String, dynamic>data) async {
    const url = "${root}observation/updateObservationResponse2";
    final body = data;
    try {
      final response = await http.post(Uri.parse(url), body: json.encode(body), headers: headers);
      final responseBody = json.decode(response.body);
      if (responseBody['status'] == true) {
        return responseBody ['msg'];
      } else {
        throw ApiError.fromResponse(responseBody['msg']);
      }
    } catch (e) {
      _handleError(e);
    }
    return null;
  }

  //update priority


  Future<String?> getPriorityUpdate(Map<String, dynamic>data) async {
    const url = '${root}priorityStatus/updatsePrioritysDiscription';
    final body = data;
    try {
      final response = await http.patch(Uri.parse(url), body: json.encode(body), headers: getHeaders());
      final responseBody = json.decode(response.body);
      if (responseBody['status'] == true) {
        return responseBody ['msg'];
      } else {
        throw ApiError.fromResponse(responseBody['msg']);
      }
    } catch (e) {
      _handleError(e);
    }
    return null;
  }


//filter observation
  Future<List<FilterObservationModel>> getFilterObservation(int page,
      String stationCode, String startDate, String endDate,String location,
      String plantDeptCode, String status,String hazardCategory, String responsibilityEnggCode, String observationRaisedByEmpUnqId) async {
    final url = '${root}observation/filterObservation?page=$page&size=10';
    final body = {
      "stationCode": stationCode,
      "startDate": startDate,
      "endDate": endDate,
      "location": location,
      "plantDeptCode": plantDeptCode,
      "status": status,
      "hazardCategory": hazardCategory,
      "responsibilityEnggCode": responsibilityEnggCode,
      "observationRaisedByEmpUnqId": observationRaisedByEmpUnqId
    };
    try {
      final response = await http.post(Uri.parse(url),headers: getHeaders(),body: json.encode(body));
      final responseBody = json.decode(response.body);
      if(responseBody["status"] == true){
        final itemList = responseBody["model"] as List;
        return itemList.map((e) => FilterObservationModel.fromJson(e)).toList();
      }else{
        return [];
      }
    } catch (e) {
      _handleError(e);
    }
    return [];
  }

  //filter observation2
  Future<AllFilterObservationModel> getAllFilterObservation(int page,
      String stationCode, String startDate, String endDate,String location,
      String plantDeptCode, String status,String hazardCategory, String responsibilityEnggCode,
      String observationRaisedByEmpUnqId, String sessionID, String uniqueId) async {
    final url = '${root}observation/filterObservation?page=$page&size=10';
    final body = {
      "stationCode": stationCode,
      "startDate": startDate,
      "endDate": endDate,
      "location": location,
      "plantDeptCode": plantDeptCode,
      "status": status,
      "hazardCategory": hazardCategory,
      "responsibilityEnggCode": responsibilityEnggCode,
      "observationRaisedByEmpUnqId": observationRaisedByEmpUnqId,
      "sessionID": sessionID,
      "uniqueIdentificationNumber": uniqueId
    };
    try {
      final response = await http.post(Uri.parse(url),headers: getHeaders(),body: json.encode(body));
      final responseBody = json.decode(response.body);
      if(responseBody["status"] == true){
        html.window.localStorage.removeItem('ksessionID');
        html.window.localStorage.removeItem('kRaisedSessionID');
        html.window.localStorage.removeItem('kReceivedsessionID');
        html.window.localStorage.removeItem('kAllSessionID');
        html.window.localStorage.setItem('ksessionID', responseBody['sessionID'].toString());
        html.window.localStorage.setItem('kRaisedSessionID', responseBody['sessionID'].toString());
        html.window.localStorage.setItem('kReceivedsessionID', responseBody['sessionID'].toString());
        html.window.localStorage.setItem('kAllSessionID', responseBody['sessionID'].toString());
        print(html.window.localStorage.getItem('kAllSessionID'));
        return AllFilterObservationModel.fromJson(responseBody);
      }else{
        return const AllFilterObservationModel();
      }
    } catch (e) {
      _handleError(e);
    }
    return const AllFilterObservationModel();
  }




  // responsible HOD

  Future<List<EmployeeResponsibilityModel>> getResponsibleHOD(String deptCode, String stateCode, String gradeCode, String responsibleEnggCode)async{
    const url = "${root}reportingto/findAllHodByEmp";
    final data = {'deptCode' : deptCode, "statCode" : stateCode, "gradeCode" : gradeCode, "reportResEmpCode" :responsibleEnggCode };
    final response = await http.post(Uri.parse(url), body: json.encode(data),headers: headers);
    try{
      final responseBody = json.decode(response.body);
      if(responseBody["status"] == true){
        final itemList = responseBody["model"] as List;
        return itemList.map((e) => EmployeeResponsibilityModel.fromJson(e)).toList();
      }else{
        return[];
      }
    }catch(e){
      _handleError(e);
    }
    return[];
  }

  //Unique Id

  Future<List<UniqueIdModel>> getUniqueIdList()async{
    const url = "${root}observation/getAllObservation";
    final response = await http.get(Uri.parse(url),headers: headers);
    try{
      final responseBody = json.decode(response.body);
      if(responseBody["status"] == true){
        final itemList = responseBody["model"] as List;
        return itemList.map((e) => UniqueIdModel.fromJson(e)).toList();
      }else{
        return[];
      }
    }catch(e){
      _handleError(e);
    }
    return[];
  }


  //plant Head

  Future<List<PlantHeadModel>> getPlantHead(String plantCode)async{

    const url = "${root}plantHead/findPlantHeadByPlantCode";
    final data = {'plantCode' : plantCode};

    final response = await http.post(Uri.parse(url),body: json.encode(data),headers: headers);
    try{
      final responseBody = json.decode(response.body);
      if(responseBody["status"] == true){
        final itemList = responseBody["model"] as List;
        return itemList.map((e) => PlantHeadModel.fromJson(e)).toList();
      }else{
        throw ApiError.fromResponse(responseBody["msg"]);
      }
    }catch(e){
      _handleError(e);
    }
    return [];
  }

  //unitHead

  Future<List<UnitHeadModel>> getUnitHead(String plantCode)async{

    const url = "${root}unitHead/findAllUnitHead";
    final data = {'unitPlantCode' : "001"};

    final response = await http.post(Uri.parse(url),body: json.encode(data),headers: headers);
    try{
      final responseBody = json.decode(response.body);
      if(responseBody["status"] == true){
        final itemList = responseBody["model"] as List;
        return itemList.map((e) => UnitHeadModel.fromJson(e)).toList();
      }else{
        throw ApiError.fromResponse(responseBody["msg"]);
      }
    }catch(e){
      _handleError(e);
    }
    return [];
  }

  //generate Excel
  Future<GenerateExcelModel?> generateExcel(String sessionID)async{
    const url = "${root}observation/genrateExcelFileForAllObsevation";
    // final response = await http.get(Uri.parse(url), headers: headers);
     final body = {"sessionID" : sessionID};
    try {
      final response = await http.post(Uri.parse(url), body: json.encode(body),headers: getHeaders());
      final responseBody = json.decode(response.body);
      if (responseBody['status'] == true) {
        return GenerateExcelModel.fromJson(responseBody["model"]);
      } else {
        throw ApiError.fromResponse(responseBody['msg']);
      }
    } catch (e) {
      _handleError(e);
    }
    return const GenerateExcelModel();
  }

  //change Observation Image

  Future<String?> changeObservationImage(
      Uint8List fileBytes,
      String uniqueIdentificationNumber,
      ) async {
    const url = "${root}observation/updateObservationImage";

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

      request.fields['uniqueIdentificationNumber'] = uniqueIdentificationNumber;

      var res = await request.send();
      var results = await http.Response.fromStream(res);
      var finalres = jsonDecode(results.body) as Map<String, dynamic>;

      if (finalres['status'] == true) {
        return finalres['msg'];
      } else {
        throw Exception(finalres['msg']);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  ///Delete Observation

  Future<String?> deleteObservation(Map<String, dynamic>data) async {
    const url = '${root}observation/deleteObservation';
    final body = data;
    try {
      final response = await http.delete(Uri.parse(url), body: json.encode(body), headers: headers);
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