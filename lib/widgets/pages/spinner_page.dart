
import 'package:dusza2019/game_parts/game.dart';
import 'package:dusza2019/game_parts/student_sprite.dart';
import 'package:dusza2019/pojos/pojo_student.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class SpinnerPage extends StatefulWidget {

  List<PojoStudent> choseStudents;

  SpinnerPage({Key key, this.choseStudents}) : super(key: key);

  @override
  _SpinnerPage createState() => _SpinnerPage();
}

class _SpinnerPage extends State<SpinnerPage> with AutomaticKeepAliveClientMixin {

  _SpinnerPage();
  @override
  void initState() {


    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

  //  List<StudentWidget> students = [];

    return Container(
      child: Scaffold(

          body: SafeArea(
            child: Container(

              child: Builder(
                builder: (context){

                  Game game = MyGame(MediaQuery.of(context).size);

                  return game.widget;






                  /*
                  if(students.isEmpty){
                    students.add(StudentWidget(x_position: - screenWidth - 50, y_position: screenHeight/2, ));
                  }

                  for(int i = 0; i < students.length; i++){

                    setState(() {
                      students[i].x_position += students[i].x_velocity;
                    });

                    return Transform.translate(
                      offset: Offset(students[i].x_position, students[i].y_position),
                      child: students[i],
                    );
                  }
                  return Container();
                  */


                },
              ),



            )
          )
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}


