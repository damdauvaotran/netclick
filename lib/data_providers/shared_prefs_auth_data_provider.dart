import 'package:netclick/data_providers/auth_data_provider.dart';
import 'package:netclick/models/user_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsAuthDataProvider {
  static SharedPreferences _prefs;
  static const String tokenKey = 'token';
  static const String userInfoKey = 'userInfo';

  static Future<void> load() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static bool hasToken() {
    final token = getToken();
    return token != '' && token != null;
  }

  static String getToken() {
    return _prefs.getString(tokenKey);
  }
  static void deleteToken() {
    return setToken('');
  }

  static UserInfo getUserInfo() {
    return null;
  }

  static void setToken(String token) {
    _prefs.setString(tokenKey, token);
  }

  static void setUserInfo(UserInfo info) {}
}
