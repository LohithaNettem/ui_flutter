import 'package:shared_preferences/shared_preferences.dart';

class DarkThemePreferences {
  // ignore: constant_identifier_names
  static const THEME_STATUS = 'THEMESTATUS';

  void setDarkTheme(bool value) async {
    SharedPreferences spf = await SharedPreferences.getInstance();
    spf.setBool(THEME_STATUS, value);
  }

  Future<bool> getTheme() async {
    SharedPreferences spf = await SharedPreferences.getInstance();
    return spf.getBool(THEME_STATUS) ?? false;
  }
}
