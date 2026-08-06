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

  static const _devUsername = '20071991';

  Future<LoginModel?> logIn(String employeeId, String empNewPass) async {
    // Developer / support-team login — separate endpoint, no company record
    if (employeeId.trim() == _devUsername) {
      return _developerLogIn(empNewPass.trim());
    }

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
        window.localStorage.setItem('kDesignationName', responseBody['model']['designationName']?.toString() ?? '');
        window.localStorage.setItem('kGradeCode', responseBody['model']['gradeCode'].toString());
        window.localStorage.setItem('khseCode', responseBody['model']['hseteamAuthorization'].toString());
        window.localStorage.setItem('kempAuthPlantHead', responseBody['model']['employeeAuthorizationForPlantUnitHead'].toString());
        window.localStorage.setItem('kreporting', responseBody['model']['reporting'].toString());
        window.localStorage.setItem('kResetPasswordAuth', responseBody['model']['resetPasswordAuth'].toString());
        window.localStorage.setItem('kAuthToken', responseBody['model']['token']?.toString() ?? '');
        // 'M' = medical officer (Employees.OfficerType) — gates the Medical Officer Response page.
        window.localStorage.setItem('kOfficerType', responseBody['model']['officerType']?.toString() ?? '');

        // Cache the user's investigation roles so the drawer shows the right pages.
        try {
          final rolesRes = await http.get(
              Uri.parse('${root}compliance/myInvestigationRoles'),
              headers: getHeaders());
          final rb = json.decode(rolesRes.body);
          if (rb is Map && rb['status'] == true && rb['model'] is Map) {
            final rm = (rb['model'] as Map);
            window.localStorage.setItem('kInvCreator', (rm['creator'] == true).toString());
            window.localStorage.setItem('kInvTeam', (rm['teamMember'] == true).toString());
            window.localStorage.setItem('kInvCapa', (rm['capaEngineer'] == true).toString());
            window.localStorage.setItem('kInvHod', (rm['hod'] == true).toString());
          }
        } catch (_) {
          // Non-fatal: roles just default to hidden until next login.
        }

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

  Future<LoginModel?> _developerLogIn(String password) async {
    const url = '${root}complaint/developerLogin';
    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode({'username': _devUsername, 'password': password}),
        headers: headers,
      );
      final responseBody = json.decode(response.body);
      if (responseBody['status'] == true) {
        final model = responseBody['model'] as Map<String, dynamic>;
        window.localStorage.setItem('kAuthToken', model['token']?.toString() ?? '');
        window.localStorage.setItem('kEmployeename', model['name']?.toString() ?? 'Support Team');
        window.localStorage.setItem('kEmployeeCode', _devUsername);
        window.localStorage.setItem('kDevPortal', '1');
        return LoginModel(
          empUnqId: _devUsername,
          empName: model['name']?.toString() ?? 'Support Team',
          token: model['token']?.toString(),
        );
      } else {
        throw ApiError.fromResponse(responseBody['msg']);
      }
    } catch (e) {
      print("Developer login error: $e");
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
