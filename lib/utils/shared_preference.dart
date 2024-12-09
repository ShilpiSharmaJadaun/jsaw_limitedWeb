import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static SharedPreferences? _prefs;

  static Future<SharedPreferences> _getInstance() async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!;
  }

  static Future<String> getEmployeeName() async {
    final SharedPreferences prefs = await _getInstance();
    return prefs.getString('kEmployeeName') ?? ''; // Provide a default value
  }

  static Future<String> getEmployeeCode() async {
    final SharedPreferences prefs = await _getInstance();
    return prefs.getString('kEmployeeCode') ?? ''; // Provide a default value if needed
  }

// Add more getters and setters as needed for other preferences
}
