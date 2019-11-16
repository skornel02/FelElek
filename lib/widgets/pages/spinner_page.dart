import 'package:dusza2019/game_parts/game.dart';
import 'package:dusza2019/game_parts/student_sprite.dart';
import 'package:dusza2019/other/spinner_data.dart';
import 'package:dusza2019/pojos/pojo_student.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class SpinnerPage extends StatelessWidget {

  final spinnerData;

  SpinnerPage({Key key, this.spinnerData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD

  //  List<StudentWidget> students = [];
=======
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    //  List<StudentWidget> students = [];
>>>>>>> a169c4de9a5c6ed2f83ba2e416151265e1d1c0e1

    return Container(
      child: Scaffold(body: SafeArea(child: Container(
        child: Builder(
          builder: (context) {
            Game game = MyGame(
                screenSize: MediaQuery.of(context).size, pojoStudents: List());
            return game.widget;
          },
        ),
      ))),
    );
  }
}
