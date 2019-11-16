import 'dart:async';

import 'package:animator/animator.dart';
import 'package:dusza2019/blocs/groups_bloc.dart';
import 'package:dusza2019/blocs/selected_bloc.dart';
import 'package:dusza2019/other/hazizz_localizations.dart';
import 'package:dusza2019/other/winner_data.dart';
import 'package:dusza2019/pojos/pojo_group.dart';
import 'package:dusza2019/pojos/pojo_student.dart';
import 'package:dusza2019/widgets/dialogs/dialogs.dart';
import 'package:dusza2019/widgets/items/student_edit_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChosenStudentPage extends StatefulWidget {

  final WinnerData winner;

  ChosenStudentPage({Key key, @required this.winner}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: BlocProvider.of<SelectedBloc>(context),
        builder: (BuildContext context, SelectedState state) {
          print(state);
          if (state is SelectionReadyState) {
            PojoGroup group = state.group;
            return Container(
              //LogConsoleOnShake(
              child: Scaffold(
                  key: Key(group.students.length.toString() + "-" + group.uuId),
                  floatingActionButton: FloatingActionButton(
                    child: Icon(FontAwesomeIcons.plus),
                    onPressed: () {
                      showAddStudentDialog(context);
                    },
                  ),
                  body: SafeArea(
                    child: new RefreshIndicator(
                        child: Column(
                          children: <Widget>[
                            Text(
                              "${locText(context, key: "group")}: ${group.name}",
                              style: TextStyle(fontSize: 26),
                            ),
                            Text(
                              "${group.students.length} felhasználó",
                              style: TextStyle(fontSize: 22),
                            ),
                            Expanded(
                                child: ListView.builder(
                                  // physics: BouncingScrollPhysics(),
                                    itemCount: group.students.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return StudentEditorWidget(
                                          student: group.students[index],
                                          group: group);
                                    })),
                          ],
                        ),
                        onRefresh: () async =>
                            BlocProvider.of<GroupsBloc>(context)
                                .dispatch(ReloadGroupEvent())),
                  )),
            );
          }
          return Center(child: CircularProgressIndicator());
        });
  }

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
                            widget.winner.imgPath,
                            width: 200,
                            height: 200,
                            fit: BoxFit.scaleDown,
                          ),
                          Text(widget.winner.student.name, style: TextStyle(fontSize: 30),)
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
