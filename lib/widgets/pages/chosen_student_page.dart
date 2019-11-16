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

  int animTime = 1300;

  AnimationController mechController;
  Animation<double> mechAnimation;




  AnimationController studentController;

  @override
  void initState() {
    super.initState();
    mechController = AnimationController(vsync: this, duration: Duration(milliseconds: 1000));

    mechAnimation = Tween(begin: 0.0, end: 500.0).animate(mechController);
    mechController.forward();

    studentController = AnimationController(vsync: this, duration: Duration(milliseconds: 1000));


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
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[

            Animator(
              tween: Tween<Offset>(begin: Offset(MediaQuery.of(context).size.width/2, 0), end: Offset(MediaQuery.of(context).size.width/2, MediaQuery.of(context).size.height)),
              duration: Duration(milliseconds: animTime),
              curve: Curves.easeInOut,
              cycles: 2,
              builder: (anim){
                return Transform.translate(
                  offset: anim.value,
                  child: new Image.asset(
                    'images/claw3.png',
                    width: 650,
                    height: 12000,
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),


            Animator(

              tween: Tween<Offset>(begin: Offset(MediaQuery.of(context).size.width/2, 0), end: Offset(MediaQuery.of(context).size.width/2, MediaQuery.of(context).size.height)),
              duration: Duration(milliseconds: 1300),
              curve: Curves.easeInOut,
              cycles: 2,
              builder: (anim){
                return Transform.translate(
                  offset: anim.value,
                  child: Container(
                    color: Colors.red,

                    width: 300,
                    height: 50,
                  ),
                );
              },
            )

          ],
        ),
      ),
    );
  }

}
