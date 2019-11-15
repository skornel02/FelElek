import 'package:dusza2019/widgets/pages/group_page.dart';
import 'package:dusza2019/widgets/pages/login_page.dart';
import 'package:dusza2019/widgets/pages/login_page.dart';
import 'package:flutter/material.dart';

import '../widgets/pages/intro_page.dart';
import '../widgets/pages/main_tab_hoster.dart';


class RouteGenerator{
  static Route<dynamic> _errorRoute(String errorLog) {
    print("navigation error: $errorLog");
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text(errorLog),
        ),
      );
    });
  }

  static Route generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    print("navigating to ${settings.name} with arguments: ${settings.arguments}");


    switch (settings.name) {
      case 'login':
        return MaterialPageRoute(builder: (_) => LoginPage());
      case 'registration':
      //    return MaterialPageRoute(builder: (_) => RegistrationPage());
      case 'intro':
        return MaterialPageRoute(builder: (_) => IntroPage());
      case '/':
        return MaterialPageRoute(builder: (_) => GroupsPage());//MaterialPageRoute(builder: (_) => MainTabHosterPage());
      case '/group':
        return MaterialPageRoute(builder: (_) => GroupsPage());
      default:
        String errorLog = "log: route: ${settings.name}, args: ${settings.arguments}";
        return _errorRoute(errorLog);
    }
  }
}

