import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

ThemeData theme(BuildContext context) {
  return Theme.of(context);
}

class FelElekTheme {
  static const Color red = Color.fromRGBO(242, 5, 48, 1),
      grey = Color.fromRGBO(64, 100, 115, 1),
      yellow = Color.fromRGBO(242, 226, 5, 1),
      orange = Color.fromRGBO(242, 116, 5, 1),
      dark_red = Color.fromRGBO(140, 3, 3, 1);

  static final Color formColor = Colors.grey.withAlpha(120);

  static Color get warningColor => red;

  static final ThemeData lightThemeData = new ThemeData(
    textTheme: TextTheme(
      body1: TextStyle(fontFamily: "Nunito", fontWeight: FontWeight.w600),
      body2: TextStyle(fontFamily: "Nunito", fontWeight: FontWeight.w600),
      title: TextStyle(fontFamily: "Nunito", fontWeight: FontWeight.w800),
      caption: TextStyle(fontFamily: "Nunito", fontWeight: FontWeight.w600),
      display2: TextStyle(fontFamily: "Nunito", fontWeight: FontWeight.w600),
      display3: TextStyle(fontFamily: "Nunito", fontWeight: FontWeight.w600),
      display4: TextStyle(fontFamily: "Nunito", fontWeight: FontWeight.w600),
      headline: TextStyle(fontFamily: "Nunito", fontWeight: FontWeight.w600),
      overline: TextStyle(fontFamily: "Nunito", fontWeight: FontWeight.w600),
      subhead: TextStyle(fontFamily: "Nunito", fontWeight: FontWeight.w600),
      display1: TextStyle(fontFamily: "Nunito", fontWeight: FontWeight.w600),
      subtitle: TextStyle(fontFamily: "Nunito", fontWeight: FontWeight.w600),
      button: TextStyle(fontFamily: "Nunito", fontWeight: FontWeight.w800),
    ),
    buttonColor: orange,
    brightness: Brightness.light,
    accentColor: red,
    primaryColorDark: dark_red,
    primaryColor: orange,
    errorColor: red,
  );

  static final ThemeData darkThemeData = new ThemeData(
    textTheme: TextTheme(
      body1: TextStyle(fontFamily: "Nunito", fontWeight: FontWeight.w600),
      body2: TextStyle(fontFamily: "Nunito", fontWeight: FontWeight.w600),
      title: TextStyle(fontFamily: "Nunito", fontWeight: FontWeight.w800),
      caption: TextStyle(fontFamily: "Nunito", fontWeight: FontWeight.w600),
      display2: TextStyle(fontFamily: "Nunito", fontWeight: FontWeight.w600),
      display3: TextStyle(fontFamily: "Nunito", fontWeight: FontWeight.w600),
      display4: TextStyle(fontFamily: "Nunito", fontWeight: FontWeight.w600),
      headline: TextStyle(fontFamily: "Nunito", fontWeight: FontWeight.w600),
      overline: TextStyle(fontFamily: "Nunito", fontWeight: FontWeight.w600),
      subhead: TextStyle(fontFamily: "Nunito", fontWeight: FontWeight.w600),
      display1: TextStyle(fontFamily: "Nunito", fontWeight: FontWeight.w600),
      subtitle: TextStyle(fontFamily: "Nunito", fontWeight: FontWeight.w600),
      button: TextStyle(fontFamily: "Nunito", fontWeight: FontWeight.w800),
    ),
    brightness: Brightness.light,
    accentColor: red,
    primaryColorDark: dark_red,
    primaryColor: orange,
    errorColor: red,
  );

  static const String _key_theme = "_key_theme";

  static const String _value_dark = "dark";
  static const String _value_light = "light";

  static Future<bool> isDark() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String theme = sharedPreferences.getString(_key_theme);
    if (theme == _value_dark) {
      return true;
    }
    return false;
  }

  static Future<bool> isLight() async {
    return !(await isDark());
  }

  static Future<void> setDark() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(_key_theme, _value_dark);
  }

  static Future<void> setLight() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(_key_theme, _value_light);
  }

  static Future<ThemeData> getCurrentTheme() async {
    if (await isDark()) {
      return FelElekTheme.darkThemeData;
    } else {
      return FelElekTheme.lightThemeData;
    }
  }
}
