import 'dart:async';

import 'package:animator/animator.dart';
import 'package:dusza2019/blocs/groups_bloc.dart';
import 'package:dusza2019/blocs/selected_bloc.dart';
import 'package:dusza2019/navigation/business_navigator.dart';
import 'package:dusza2019/other/hazizz_localizations.dart';
import 'package:dusza2019/other/winner_data.dart';
import 'package:dusza2019/pojos/pojo_group.dart';
import 'package:dusza2019/pojos/pojo_student.dart';
import 'package:dusza2019/widgets/dialogs/dialogs.dart';
import 'package:dusza2019/widgets/items/student_edit_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChosenStudentPage extends StatefulWidget {
  final WinnerData winner;

  ChosenStudentPage({Key key, @required this.winner}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ChosenStudentPage();
}

class _ChosenStudentPage extends State<ChosenStudentPage>
    with TickerProviderStateMixin {
  int grade;

  int animTime = 1500;

  AnimationController mechController;
  Animation<double> mechAnimation;

  AnimationController studentController;
  Animation studentAnimation;

  AnimationController buttonController;
  Animation<double> buttonAnimation;

  @override
  void initState() {
    super.initState();
    mechController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));

    mechAnimation = Tween(begin: 0.0, end: 500.0).animate(mechController);
    mechController.forward();

    studentController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: animTime),
    );

    buttonController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));

    buttonAnimation = Tween(begin: 0.0, end: 1.0).animate(buttonController);
    Timer(Duration(milliseconds: animTime * 2), () {
      buttonController.forward();
    });

    Timer(Duration(milliseconds: animTime), () {
      studentController.forward();
    });

    mechController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        mechController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        mechController.forward();
      }
    });
  }

  @override
  void dispose() {
    mechController.dispose();
    studentController.dispose();
    buttonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    studentAnimation = Tween<Offset>(
            begin: Offset(MediaQuery.of(context).size.width / 2 - 100, MediaQuery.of(context).size.height),
            end: Offset(MediaQuery.of(context).size.width / 2 - 100, 130))
        .animate(CurvedAnimation(
            parent: studentController, curve: Curves.easeInOut));

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Animator(
              tween: Tween<Offset>(
                  begin: Offset(0, 200),
                  end: Offset(0, MediaQuery.of(context).size.height + 70)),
              duration: Duration(milliseconds: animTime),
              curve: Curves.easeInOut,
              cycles: 2,
              builder: (anim) {
                return Transform.translate(
                  offset: anim.value,
                  child: Transform.translate(
                    offset: Offset(0, -MediaQuery.of(context).size.height),
                    child: new Image.asset(
                      'assets/images/claw3.png',
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                );
              },
            ),
            Column(children: [
              AnimatedBuilder(
                animation: studentController,
                builder: (context, child) {
                  return Transform.translate(
                      offset: studentAnimation.value,
                      child: Column(
                        children: <Widget>[
                          Image.asset(
                            widget.winner.imgPath,
                            width: 200,
                            height: 200,
                            fit: BoxFit.scaleDown,
                          ),
                          Text(
                            widget.winner.student.name,
                            style: TextStyle(fontSize: 30),
                          )
                        ],
                      ));
                },
              ),
            ]),
            Positioned(
              bottom: 0,
              child: FadeTransition(
                  opacity: buttonAnimation,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 80,
                    child: Card(
                      margin: EdgeInsets.all(6),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            RaisedButton(
                              child: Text(locText(context, key: "back")),
                              onPressed: () {
                                BusinessNavigator()
                                    .currentState()
                                    .pushReplacementNamed('/');
                              },
                            ),
                            Builder(
                              builder: (context) {
                                if (grade == null) {
                                  return RaisedButton(
                                    child: Text("jegy hozzáadás"),
                                    onPressed: () async {
                                      BlocProvider.of<SelectedBloc>(context)
                                          .dispatch(SetSelectedStudent(
                                              widget.winner.student));
                                      showAddGradeDialog(context).then((int g) {
                                        setState(() {
                                          grade = g;
                                        });
                                      });
                                    },
                                  );
                                }
                                return Text(
                                  "Jegy: ${grade}",
                                  style: TextStyle(fontSize: 22),
                                );
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
