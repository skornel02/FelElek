import 'package:dusza2019/widgets/pages/choose_absent_page.dart';
import 'package:dusza2019/widgets/pages/chosen_student_page.dart';
import 'package:dusza2019/widgets/pages/edit_student_page.dart';
import 'package:dusza2019/widgets/pages/choose_group_page.dart';
import 'package:dusza2019/widgets/pages/import_page.dart';
import 'package:dusza2019/widgets/pages/sync_page.dart';
import 'package:dusza2019/widgets/pages/sync_page.dart';
import 'package:dusza2019/widgets/pages/spinner_page.dart';
import 'package:dusza2019/widgets/pages/edit_group_page.dart';
import 'package:flutter/material.dart';

import '../widgets/pages/intro_page.dart';


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
      case '/login':
        return MaterialPageRoute(builder: (_) => SyncPage());
      case '/import':
        return MaterialPageRoute(builder: (_) => ImportPage());
      case 'intro':
        return MaterialPageRoute(builder: (_) => IntroPage());
      case '/':
        return MaterialPageRoute(builder: (_) => GroupsPage());//MaterialPageRoute(builder: (_) => MainTabHosterPage());
      case '/student':
        return MaterialPageRoute(builder: (_) => GroupEditPage());
      case '/student/edit':
        return MaterialPageRoute(builder: (_) => StudentEditPage());
      case '/absent':
        assert(args != null);
        return MaterialPageRoute(builder: (_) => AbsentPage());
      case '/absent/spinner':
        assert(args != null);
        return MaterialPageRoute(builder: (_) => SpinnerPage(spinnerData: args,));
      case '/absent/spinner/chosen_student':
        assert(args != null);
        return MaterialPageRoute(builder: (_) => ChosenStudentPage(winner: args,));
      default:
        String errorLog = "log: route: ${settings.name}, args: ${settings.arguments}";
        return _errorRoute(errorLog);
    }
  }
}

