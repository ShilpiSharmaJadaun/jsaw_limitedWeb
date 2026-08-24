import 'dart:convert';
import 'package:flutter/foundation.dart' show debugPrint, kDebugMode;
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
    final sw = Stopwatch()..start();
    final response = await http.post(url,
        headers: headers, body: body, encoding: encoding);
    _log(response, sw);
    _check(response);
    return response;
  }

  Future<http.Response> get(Uri url, {Map<String, String>? headers}) async {
    final sw = Stopwatch()..start();
    final response = await http.get(url, headers: headers);
    _log(response, sw);
    _check(response);
    return response;
  }

  Future<http.Response> put(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    final sw = Stopwatch()..start();
    final response =
        await http.put(url, headers: headers, body: body, encoding: encoding);
    _log(response, sw);
    _check(response);
    return response;
  }

  Future<http.Response> patch(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    final sw = Stopwatch()..start();
    final response = await http.patch(url,
        headers: headers, body: body, encoding: encoding);
    _log(response, sw);
    _check(response);
    return response;
  }

  Future<http.Response> delete(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    final sw = Stopwatch()..start();
    final response = await http.delete(url,
        headers: headers, body: body, encoding: encoding);
    _log(response, sw);
    _check(response);
    return response;
  }

  /// Use for multipart uploads. Call after `Response.fromStream(...)`.
  void check(http.Response response) {
    _log(response, null);
    _check(response);
  }

  /// Use to attach the auth header to a `MultipartRequest` before `.send()`.
  void attachAuth(http.MultipartRequest request) {
    request.headers.addAll(getHeaders());
    if (kDebugMode) {
      debugPrint('[HTTP] → ${request.method} ${_path(request.url)} (multipart, '
          '${request.fields.keys.join(',')}${request.files.isEmpty ? '' : ', files=${request.files.length}'})');
    }
  }

  // ---- debug tracing (debug builds only) ------------------------------------
  String _path(Uri u) => u.toString().replaceFirst(root, '/');

  void _log(http.Response response, Stopwatch? sw) {
    if (!kDebugMode) return;
    final req = response.request;
    final method = req?.method ?? '?';
    final path = req == null ? '?' : _path(req.url);
    final ms = sw == null ? '' : ' ${sw.elapsedMilliseconds}ms';
    final code = response.statusCode;
    String tail = '';
    try {
      final body = response.body;
      if (code >= 400) {
        tail = ' | ${body.length > 300 ? body.substring(0, 300) : body}';
      } else {
        final j = json.decode(body);
        if (j is Map) {
          final model = j['model'];
          final size = model is List ? ' list=${model.length}' : (model is Map ? ' map' : '');
          tail = ' | status=${j['status']} msg=${j['msg'] ?? j['message']}$size';
        }
      }
    } catch (_) {}
    debugPrint('[HTTP] $method $path → $code$ms$tail');
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
