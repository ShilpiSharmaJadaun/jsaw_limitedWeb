import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../error/api_error.dart';
import '../model/login_model.dart';
import 'constant.dart';
import 'package:web/web.dart' show window;

class LoginService {

  Future<LoginModel?> logIn(String employeeId,String empNewPass) async {
    final data = {'empUnqId': employeeId, 'empNewPass' : empNewPass};
    const url = '${root}employees/loginPortal';
    try {
      final response = await http.post(Uri.parse(url), body: json.encode(data), headers: headers);
      final responseBody = json.decode(response.body);
      if (responseBody["status"] == true) {
        window.localStorage.setItem('kEmployeename', responseBody['model']['empName']);
        window.localStorage.setItem('kEmployeeCode', responseBody['model']['empUnqId']);
        window.localStorage.setItem('kEmployeePassStatus', responseBody['model']['empPassStatus'].toString());
        window.localStorage.setItem('kUserEmail', responseBody['model']['email'].toString());
        //window.localStorage.setItem('kstatCode', responseBody['model']['desgCode'].toString());
        window.localStorage.setItem('kstatCode', responseBody['model']['statCode'].toString());
        window.localStorage.setItem('kdeptCode', responseBody['model']['deptCode'].toString());
        window.localStorage.setItem('kDesgnCode', responseBody['model']['desgCode'].toString());
        window.localStorage.setItem('kGradeCode', responseBody['model']['gradeCode'].toString());
        window.localStorage.setItem('khseCode', responseBody['model']['hseteamAuthorization'].toString());
        window.localStorage.setItem('kempAuthPlantHead', responseBody['model']['employeeAuthorizationForPlantUnitHead'].toString());
        window.localStorage.setItem('kreporting', responseBody['model']['reporting'].toString());
        window.localStorage.setItem('kResetPasswordAuth', responseBody['model']['resetPasswordAuth'].toString());

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
