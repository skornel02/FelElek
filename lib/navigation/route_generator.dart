import 'package:dusza2019/widgets/GroupInheritedWidget.dart';
import 'package:dusza2019/widgets/pages/absent_page.dart';
import 'package:dusza2019/widgets/pages/edit_student_page.dart';
import 'package:dusza2019/widgets/pages/group_page.dart';
import 'package:dusza2019/widgets/pages/login_page.dart';
import 'package:dusza2019/widgets/pages/login_page.dart';
import 'package:dusza2019/widgets/pages/spinner_page.dart';
import 'package:dusza2019/widgets/pages/students_page.dart';
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
      case 'login':
        return MaterialPageRoute(builder: (_) => LoginPage());
      case 'registration':
      //    return MaterialPageRoute(builder: (_) => RegistrationPage());
      case 'intro':
        return MaterialPageRoute(builder: (_) => IntroPage());
      case '/':
        return MaterialPageRoute(builder: (_) => GroupsPage());//MaterialPageRoute(builder: (_) => MainTabHosterPage());
      case '/student':
        assert(args != null);
        return MaterialPageRoute(builder: (_) => StudentsPage(group: args,));
      case '/student/edit':
        assert(args != null);
        return MaterialPageRoute(builder: (_) => GradePage(student: args,));
      case '/absent':
        assert(args != null);
        return MaterialPageRoute(builder: (_) => AbsentPage(group: args,));
      case '/absent/spinner':
        assert(args != null);
        return MaterialPageRoute(builder: (_) => SpinnerPage(choseStudents: args,));
      default:
        String errorLog = "log: route: ${settings.name}, args: ${settings.arguments}";
        return _errorRoute(errorLog);
    }
  }
}

