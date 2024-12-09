import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../error/api_error.dart';
import '../model/login_model.dart';
import 'constant.dart';
import 'dart:html'; // Import dart:html for web-specific features

class LoginService {

  Future<LoginModel?> logIn(String employeeId,String empNewPass) async {
    final data = {'empUnqId': employeeId, 'empNewPass' : empNewPass};
    const url = '${root}employees/loginPortal';
    try {
      final response = await http.post(Uri.parse(url), body: json.encode(data), headers: headers);
      final responseBody = json.decode(response.body);
      if (responseBody["status"] == true) {
        window.localStorage['kEmployeename'] = responseBody['model']['empName'];
        window.localStorage['kEmployeeCode'] = responseBody['model']['empUnqId'];
        window.localStorage['kEmployeePassStatus'] = responseBody['model']['empPassStatus'].toString();
        window.localStorage['kUserEmail'] = responseBody['model']['email'].toString();
        //window.localStorage['kstatCode'] = responseBody['model']['desgCode'].toString();
        window.localStorage['kstatCode'] = responseBody['model']['statCode'].toString();
        window.localStorage['kDesgnCode'] = responseBody['model']['desgCode'].toString();
        window.localStorage['kGradeCode'] = responseBody['model']['gradeCode'].toString();
        window.localStorage['khseCode'] = responseBody['model']['hseteamAuthorization'].toString();
        window.localStorage['kempAuthPlantHead'] = responseBody['model']['employeeAuthorizationForPlantUnitHead'].toString();
        window.localStorage['kreporting'] = responseBody['model']['reporting'].toString();
        window.localStorage['kResetPasswordAuth'] = responseBody['model']['resetPasswordAuth'].toString();

        // Get shared preferences instance
        // final SharedPreferences prefs = await SharedPreferences.getInstance();
        // prefs.setString('kEmployeeCode', responseBody['model']['empUnqId']);
        // prefs.setString('kEmployeeName', responseBody['model']['empName']);

        return  LoginModel.fromJson(responseBody["model"]);
      } else {
        throw ApiError.fromResponse(responseBody['msg']);
      }
    } catch (e, trace) {
      print("Error: $e");
      _handleError(e);
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
