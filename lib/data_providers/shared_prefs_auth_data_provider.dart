import 'package:netclick/data_providers/auth_data_provider.dart';
import 'package:netclick/models/user_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsAuthDataProvider extends AuthDataProvider{
  final SharedPreferences _prefs;
  static const String  tokenKey = 'token';
  static const String  userInfoKey = 'userInfo';
  SharedPrefsAuthDataProvider(this._prefs)
      : assert(_prefs != null);



  static Future<SharedPrefsAuthDataProvider> load() async {
    return SharedPrefsAuthDataProvider(await SharedPreferences.getInstance());
  }

  @override
  String getToken() {
    return _prefs.getString(tokenKey);
  }

  @override
  UserInfo getUserInfo() {
    return null;
  }

  @override
  void setToken(String token) {
   _prefs.setString(tokenKey, token);
  }

  @override
  void setUserInfo(UserInfo info) {
  }
}
