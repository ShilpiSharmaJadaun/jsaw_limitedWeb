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
        // Null-safe: several Employees columns (EmpName, Email, StatCode, …)
        // can be NULL for real accounts; a bare `as String` here threw
        // "type 'Null' is not a subtype of type 'String'" at login.
        final model = (responseBody['model'] as Map?) ?? const {};
        String str(String key) => model[key]?.toString() ?? '';
        window.localStorage.setItem('kEmployeename', str('empName'));
        window.localStorage.setItem('kEmployeeCode', str('empUnqId'));
        window.localStorage.setItem('kEmployeePassStatus', str('empPassStatus'));
        window.localStorage.setItem('kUserEmail', str('email'));
        window.localStorage.setItem('kstatCode', str('statCode'));
        window.localStorage.setItem('kdeptCode', str('deptCode'));
        window.localStorage.setItem('kDesgnCode', str('desgCode'));
        window.localStorage.setItem('kDesignationName', str('designationName'));
        window.localStorage.setItem('kGradeCode', str('gradeCode'));
        window.localStorage.setItem('khseCode', str('hseteamAuthorization'));
        window.localStorage.setItem('kempAuthPlantHead', str('employeeAuthorizationForPlantUnitHead'));
        window.localStorage.setItem('kreporting', str('reporting'));
        window.localStorage.setItem('kResetPasswordAuth', str('resetPasswordAuth'));
        window.localStorage.setItem('kAuthToken', str('token'));
        // 'M' = medical officer (Employees.OfficerType) — gates the Medical Officer Response page.
        window.localStorage.setItem('kOfficerType', str('officerType'));

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
        // msg can be NULL for some backend failures — a bare String cast here
        // threw "type 'Null' is not a subtype of type 'String'" at login.
        // HTTP 5xx (e.g. DB unreachable) arrives as a Spring error body with
        // "message"/"error" instead of "msg".
        final m = responseBody is Map ? responseBody : const {};
        final msg = (m['msg'] ?? m['message'] ?? m['error'])?.toString();
        throw ApiError.fromResponse(response.statusCode >= 500
            ? 'Server is not responding (${response.statusCode}). Please try again in a moment.'
            : (msg == null || msg.trim().isEmpty)
                ? 'Login failed, please try again'
                : msg);
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
