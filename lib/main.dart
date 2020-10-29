import 'dart:async';
import 'package:dusza2019/blocs/google_login_bloc.dart';
import 'package:dusza2019/blocs/groups_bloc.dart';
import 'package:dusza2019/blocs/selected_bloc.dart';
import 'package:dusza2019/blocs/sheets_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/easy_localization_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:dynamic_theme/dynamic_theme.dart';

import 'navigation/business_navigator.dart';
import 'navigation/route_generator.dart';
import 'managers/app_state_manager.dart';
import 'managers/felelek_localizations.dart';
import 'resources/felelek_theme.dart';

String startPage;
ThemeData themeData;
bool newComer = false;
Locale preferredLocale;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppState.appStartProcedure();

  themeData = await FelElekTheme.getCurrentTheme();
  newComer = await AppState.isNewComer();
  AppState.setNotNewComer();

  await AppState.init();

  runApp(EasyLocalization(child: FelElekApp()));
}

class FelElekApp extends StatefulWidget {
  @override
  _FelElekApp createState() => _FelElekApp();
}

class _FelElekApp extends State<FelElekApp> with WidgetsBindingObserver {
  // Locale preferredLocale;
  DateTime currentBackPressTime;
  DateTime lastActive;

  GroupsBloc groupsBloc = new GroupsBloc();
  GoogleLoginBloc googleBloc = new GoogleLoginBloc();
  SelectedBloc selectedBloc = new SelectedBloc();
  SheetBloc sheetBloc = new SheetBloc();

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    groupsBloc.dispatch(ReloadGroupEvent());
    googleBloc.dispatch(GoogleCheckAlreadyLoggedIn());
    sheetBloc.dispatch(StartupEvent());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Future didChangeAppLifecycleState(AppLifecycleState state) async {
    print('App lifecycle state is $state');

    if (state == AppLifecycleState.paused) {
      lastActive = DateTime.now();
    }

    if (state == AppLifecycleState.resumed) {
      if (lastActive != null) {}
    }
  }

  @override
  Widget build(BuildContext context) {
    startPage = newComer ? "/intro" : "/";

    print("Starting page: $startPage");

    return new DynamicTheme(
        data: (brightness) => themeData,
        themedWidgetBuilder: (context, theme) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<GroupsBloc>(
                builder: (_) => groupsBloc,
              ),
              BlocProvider<GoogleLoginBloc>(
                builder: (_) => googleBloc,
              ),
              BlocProvider<SelectedBloc>(
                builder: (_) => selectedBloc,
              ),
              BlocProvider<SheetBloc>(
                builder: (_) => sheetBloc,
              )
            ],
            child: MaterialApp(
              navigatorKey: BusinessNavigator().navigatorKey,
              title: 'FelElek',
              showPerformanceOverlay: false,
              theme: theme,
              initialRoute: startPage,
              onGenerateRoute: RouteGenerator.generateRoute,
              localizationsDelegates: [
                FelElekLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              supportedLocales: getSupportedLocales(),
              localeResolutionCallback: (locale, supportedLocales) {
                print("prCode1: ${preferredLocale.toString()}");
                if (preferredLocale != null) {
                  print(
                      "prCode: ${preferredLocale.languageCode}, ${preferredLocale.countryCode}");
                  return preferredLocale;
                }
                for (var supportedLocale in supportedLocales) {
                  if (supportedLocale.languageCode == locale?.languageCode &&
                      supportedLocale.countryCode == locale.countryCode) {
                    setPreferredLocale(supportedLocale);
                    return supportedLocale;
                  }
                }
                return supportedLocales.first;
              },
            ),
          );
        });
  }
}
