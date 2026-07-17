import 'package:web/web.dart' show window;

const root = 'http://103.107.26.146:8078/JSAW/';
// const root = 'http://103.107.26.146:8079/JSAW/';
// const root = 'http://localhost:8091/JSAW/';

/// Bump this alongside pubspec.yaml's version on each release.
const appVersion = '1.0.0';

const headers = <String, String>{
  'Accept': 'Application/json',
  'Content-Type' : 'Application/json',
};

Map<String, String> getHeaders(){
  final token = window.localStorage.getItem('kAuthToken') ?? '';
  return {
    'Accept': 'Application/json',
    'Content-Type' : 'Application/json',
    if (token.isNotEmpty) 'Authorization': 'Bearer $token',
  };
}

/// Dealer Login

// userName  = 100002
// password = 12345

///115163
///123
