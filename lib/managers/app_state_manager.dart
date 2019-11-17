import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../resources/app_info.dart';

class AppState{

  static bool b_seenIntro = false;
  static bool b_seenGroupItemIntro = false;

  static init() async {
    b_seenIntro = await seenIntro();
    b_seenGroupItemIntro = await seenGroupItemIntro();
  }

  static const key_seenGroupItemIntro = "key_seenGroupItemIntro2";
  static const key_seenIntro = "key_seenIntro";
  static const key_newComer = "key_newComer";
  static const value_newComer_false = "value_newComer_false";
  static const key_isLoggedIn = "key_isLoggedIn";

  static bool logInProcedureDone = true;

  static Future proceedToApp(BuildContext context) async {
    Navigator.popAndPushNamed(context, "/");
  }

  static Future<void> appStartProcedure() async {
    await FelElekAppInfo().initialize();
    Crashlytics.instance.enableInDevMode = true;
    FlutterError.onError = Crashlytics.instance.recordFlutterError;
  }

  static Future setNotNewComer() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString(key_newComer, value_newComer_false);
  }

  static Future<bool> isNewComer() async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    String newComer = sp.getString(key_newComer);
    if(newComer == value_newComer_false){
      return false;
    }
    return true;
  }

  static Future setHaveSeenIntro() async {
    b_seenIntro = true;
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setBool(key_seenIntro, true);
  }

  static Future<bool> seenIntro() async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    bool s = sp.getBool(key_seenIntro);
    if(s == null){
      return false;
    }
    return s;
  }

  static Future setHaveSeenGroupItemIntro() async {
    b_seenGroupItemIntro = true;
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setBool(key_seenGroupItemIntro, true);
  }

  static Future<bool> seenGroupItemIntro() async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    bool s = sp.getBool(key_seenGroupItemIntro);
    if(s == null){
      return false;
    }
    return s;
  }


}