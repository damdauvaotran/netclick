import 'package:netclick/models/user_info.dart';

abstract class AuthDataProvider {
  String getToken();
  void setToken(String token);
  UserInfo getUserInfo();
  void setUserInfo(UserInfo info);
}