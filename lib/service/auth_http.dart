import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:web/web.dart' show window;
import '../main.dart' show navigatorKey;
import '../routes/app_routes.dart';
import 'constant.dart';

/// Thin wrapper around `package:http` that auto-injects the JWT (via
/// `getHeaders()`) and redirects to login when the backend returns 401.
class AuthHttp {
  bool _redirecting = false;

  Future<http.Response> post(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    final response = await http.post(url,
        headers: headers, body: body, encoding: encoding);
    _check(response);
    return response;
  }

  Future<http.Response> get(Uri url, {Map<String, String>? headers}) async {
    final response = await http.get(url, headers: headers);
    _check(response);
    return response;
  }

  Future<http.Response> put(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    final response =
        await http.put(url, headers: headers, body: body, encoding: encoding);
    _check(response);
    return response;
  }

  Future<http.Response> patch(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    final response = await http.patch(url,
        headers: headers, body: body, encoding: encoding);
    _check(response);
    return response;
  }

  Future<http.Response> delete(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    final response = await http.delete(url,
        headers: headers, body: body, encoding: encoding);
    _check(response);
    return response;
  }

  /// Use for multipart uploads. Call after `Response.fromStream(...)`.
  void check(http.Response response) => _check(response);

  /// Use to attach the auth header to a `MultipartRequest` before `.send()`.
  void attachAuth(http.MultipartRequest request) {
    request.headers.addAll(getHeaders());
  }

  void _check(http.Response response) {
    if (response.statusCode != 401) return;
    if (_redirecting) return;
    _redirecting = true;
    _clearAuthAndGoToLogin();
  }

  void _clearAuthAndGoToLogin() {
    window.localStorage.removeItem('kAuthToken');
    final nav = navigatorKey.currentState;
    if (nav != null) {
      nav.pushNamedAndRemoveUntil(AppRoutes.loginPage, (_) => false);
    }
    // Allow another redirect on a future 401 once navigation settles.
    Future.delayed(const Duration(seconds: 1), () => _redirecting = false);
  }
}

final authHttp = AuthHttp();
