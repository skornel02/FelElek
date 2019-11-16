import 'dart:async';

import 'package:animator/animator.dart';
import 'package:dusza2019/blocs/groups_bloc.dart';
import 'package:dusza2019/blocs/selected_bloc.dart';
import 'package:dusza2019/other/hazizz_localizations.dart';
import 'package:dusza2019/pojos/pojo_group.dart';
import 'package:dusza2019/pojos/pojo_student.dart';
import 'package:dusza2019/widgets/dialogs/dialogs.dart';
import 'package:dusza2019/widgets/items/student_edit_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChosenStudentPage extends StatefulWidget {

  PojoStudent student;

  ChosenStudentPage({Key key, @required this.student}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ChosenStudentPage();
}



class _ChosenStudentPage extends State<ChosenStudentPage> with TickerProviderStateMixin{

  int animTime = 1500;

  AnimationController mechController;
  Animation<double> mechAnimation;


  AnimationController studentController;
  Animation studentAnimation;

  @override
  void initState() {
    super.initState();
    mechController = AnimationController(vsync: this, duration: Duration(milliseconds: 1000));

    mechAnimation = Tween(begin: 0.0, end: 500.0).animate(mechController);
    mechController.forward();

    studentController = AnimationController(vsync: this, duration: Duration(milliseconds: animTime), );

    Timer(Duration(milliseconds: (animTime/2 + 750).round()), () {
      studentController.forward();

    });


    mechController.addStatusListener((status) {
    if (status == AnimationStatus.completed) {
      mechController.reverse();
    }
    else if (status == AnimationStatus.dismissed) {
      mechController.forward();
    }
    });

  }

  @override
  void dispose() {
    mechController.dispose();
    studentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    studentAnimation =
        Tween<Offset>(begin: Offset(90, MediaQuery.of(context).size.height), end: Offset(90, 130)).animate(CurvedAnimation(parent: studentController, curve: Curves.easeInOut));


    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[

            Animator(
              tween: Tween<Offset>(begin: Offset(0, 200), end: Offset(0, MediaQuery.of(context).size.height + 70)),
              duration: Duration(milliseconds: animTime),
              curve: Curves.easeInOut,
              cycles: 2,
              builder: (anim){
                return Transform.translate(
                  offset: anim.value,
                  child: Transform.translate(
                    offset: Offset(0, -MediaQuery.of(context).size.height),
                    child: new Image.asset(
                      'assets/images/claw3.png',
                      width: 650,
                      height: 12000,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                );
              },
            ),

            Column(
              children: [

                AnimatedBuilder(
                  animation: studentController,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: studentAnimation.value,
                      child: Column(
                        children: <Widget>[
                          Image.asset(
                            'assets/images/ember-20.png',
                            width: 200,
                            height: 200,
                            fit: BoxFit.scaleDown,
                          ),
                          Text("Kovács Janó", style: TextStyle(fontSize: 30),)
                        ],
                      )

                    );
                  },
                ),


              ]
            ),


          ],
        ),
      ),
    );
  }

}
