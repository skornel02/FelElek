
import 'package:dusza2019/navigation/business_navigator.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_info.dart';

class AppState{

  static const key_newComer = "key_newComer";
  static const value_newComer_false = "value_newComer_false";
  static const key_isLoggedIn = "key_isLoggedIn";

  static bool logInProcedureDone = true;


  /*
  static Future setUserData({@required PojoMeInfo meInfo}) async {
    InfoCache.setMyId(meInfo.id);
    InfoCache.setMyUsername(meInfo.username);
    InfoCache.setMyDisplayName(meInfo.displayName);

    if(meInfo is PojoMeInfoPrivate){
    }
  }

  */

  static Future proceedToApp(BuildContext context) async {
    // MainTabBlocs().initialize();
    await mainAppPartStartProcedure();
    Navigator.popAndPushNamed(context, "/");
  }

  static Future logInProcedure() async {
    // set islogged in to true
    logInProcedureDone = false;

    print("logInProcedure: 0");
    var sh = await SharedPreferences.getInstance();
    sh.setBool(key_isLoggedIn, true);

    logInProcedureDone = true;
  }


  static Future<void> appStartProcedure() async {
    await HazizzAppInfo().initalize();
  //  await Connection.listener();
    Crashlytics.instance.enableInDevMode = true;
    FlutterError.onError = Crashlytics.instance.recordFlutterError;


  }

  static Future<void> mainAppPartStartProcedure() async {

    // await TokenManager.fetchRefreshTokens(username: (await InfoCache.getMyUserData()).username, refreshToken: await TokenManager.getRefreshToken());

    //  RequestSender._internal();
    print("mainAppPartStartProcedure 1");
  //  LoginBlocs().googleLoginBloc.dispatch(SocialLoginResetEvent());
   // MainTabBlocs().initialize();
    print("mainAppPartStartProcedure 6");
  //  UserDataBlocs().initialize();
    print("mainAppPartStartProcedure 7");

  }

  static Future logoutProcedure() async {
   // RequestSender().lock();
   // await GoogleLoginBloc().logout();
    var sh = await SharedPreferences.getInstance();
    sh.setBool(key_isLoggedIn, false);
   // InfoCache.forgetMyUser();
  }

  static Future logout() async {
    await logoutProcedure();
    var sh = await SharedPreferences.getInstance();
    bool isLoggedIn = sh.getBool(key_isLoggedIn);
    if(!isLoggedIn){
      BusinessNavigator().currentState().pushNamedAndRemoveUntil('login', (Route<dynamic> route) => false);
    }
    //  Navigator.of(context).pushNamedAndRemoveUntil('login', (Route<dynamic> route) => false);
  }



  static Future<bool> isLoggedIn() async {
    var sh = await SharedPreferences.getInstance();
    bool isLoggedIn = sh.getBool(key_isLoggedIn);
    isLoggedIn ??= false;

    return isLoggedIn;
  }


  static Future setIsntNewComer() async {
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