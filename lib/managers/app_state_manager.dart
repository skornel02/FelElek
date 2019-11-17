import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../resources/app_info.dart';

class AppState{

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


}