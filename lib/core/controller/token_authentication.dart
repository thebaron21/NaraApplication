import 'package:shared_preferences/shared_preferences.dart';

class TokenAuthentication {
  SharedPreferences _refs;

  TokenAuthentication() {
    init();
  }

  void init() async {
    _refs = await SharedPreferences.getInstance();
  }

  Future<bool> setToken({String token}) async {
    return await _refs.setString("token", token);
  }

  String getToken() {
    return _refs.getString("token");
  }
}

TokenAuthentication tokenAuthentication = TokenAuthentication();
