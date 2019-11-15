import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/easy_localization_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:dynamic_theme/dynamic_theme.dart';

import 'navigation/business_navigator.dart';
import 'navigation/route_generator.dart';
import 'other/app_state_manager.dart';
import 'other/hazizz_localizations.dart';
import 'other/hazizz_theme.dart';

String startPage;

ThemeData themeData;

bool newComer = false;

bool isLoggedIn = true;

bool isFromNotification = false;

String tasksTomorrowSerialzed;

//MainTabBlocs mainTabBlocs = MainTabBlocs();
//LoginBlocs loginBlocs = LoginBlocs();

Locale preferredLocale;

Future<bool> fromNotification() async {
  var flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  var notificationAppLaunchDetails =
  await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

  // var notificationAppLaunchDetails = await HazizzNotification.flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  print("from notif1: ${notificationAppLaunchDetails.didNotificationLaunchApp}");
  print("from notif2: ${notificationAppLaunchDetails.payload}");
  if(notificationAppLaunchDetails.didNotificationLaunchApp) {
    isFromNotification = true;
    String payload = notificationAppLaunchDetails.payload;
    if(payload != null) {
      tasksTomorrowSerialzed = payload;
    }
  }else{
    //isFromNotification = true;
  }
  return isFromNotification;
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

 // preferredLocale = await getPreferredLocale();

//  await HazizzMessageHandler().configure();

 // fromNotification();

  await AppState.appStartProcedure();

  themeData = await HazizzTheme.getCurrentTheme();



  if(!(await AppState.isNewComer())) {
    if(!(await AppState.isLoggedIn())) { // !(await AppState.isLoggedIn())
      isLoggedIn = false;
    }else {
      AppState.mainAppPartStartProcedure();
    }
  }else{
    isLoggedIn = false;
    newComer = true;
  }
  isLoggedIn  = true;
  newComer = false;

  runApp(EasyLocalization(child: HazizzApp()));
}

class HazizzApp extends StatefulWidget{
  @override
  _HazizzApp createState() => _HazizzApp();
}

class _HazizzApp extends State<HazizzApp> with WidgetsBindingObserver{
  // Locale preferredLocale;

  DateTime currentBackPressTime;

  DateTime lastActive;

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Future didChangeAppLifecycleState(AppLifecycleState state) async {
    print('App lifecycle state is $state');

    if(state == AppLifecycleState.paused){
      lastActive = DateTime.now();
    }

    if(state == AppLifecycleState.resumed){

      if(lastActive != null){

      }
    }

    if(state == AppLifecycleState.suspending){

    }
  }

  @override
  Widget build(BuildContext context) {
    if(isLoggedIn){
      if(!isFromNotification){
        startPage = "login";
      }else {
        startPage = "/tasksTomorrow";
      }
    }else if(newComer){
      startPage = "intro";
    }
    else{
      startPage = "login";
    }

    print("startpage: ${startPage}");

    return new DynamicTheme(
        data: (brightness) => themeData,
        themedWidgetBuilder: (context, theme) {
          return MaterialApp(
            navigatorKey: BusinessNavigator().navigatorKey,
            title: 'Hazizz Mobile',
            showPerformanceOverlay: false,
            theme: theme,
            initialRoute: /*"/tasksTomorrow",*/  startPage,
            onGenerateRoute: RouteGenerator.generateRoute,

            localizationsDelegates: [
              HazizzLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: getSupportedLocales(),



            localeResolutionCallback: (locale, supportedLocales) {
              // Check if the current device locale is supported
              print("prCode1: ${preferredLocale.toString()}");
              if(preferredLocale != null){
                print("prCode: ${preferredLocale.languageCode}, ${preferredLocale.countryCode}");
                return preferredLocale;
              }
              for(var supportedLocale in supportedLocales) {
                if(supportedLocale.languageCode == locale?.languageCode &&
                    supportedLocale.countryCode == locale.countryCode) {
                  setPreferredLocale(supportedLocale);
                  return supportedLocale;
                }
              }
              // If the locale of the device is not supported, use the first one
              // from the list (English, in this case).
              return supportedLocales.first;
            },

          );
        }
    );
  }
}