import 'package:animator/animator.dart';
import 'package:dusza2019/blocs/groups_bloc.dart';
import 'package:dusza2019/other/hazizz_localizations.dart';
import 'package:dusza2019/pojos/pojo_group.dart';
import 'package:dusza2019/pojos/pojo_student.dart';
import 'package:dusza2019/widgets/dialogs/dialogs.dart';
import 'package:dusza2019/widgets/items/student_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChosenStudentPage extends StatefulWidget {

  PojoStudent student;

  ChosenStudentPage({Key key, @required this.student}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: BlocProvider.of<GroupsBloc>(context),
        builder: (BuildContext context, GroupState state) {
          print(state);
          if (state is LoadedGroupState) {
            PojoGroup group = state.selectedGroup;
            return Container(
              //LogConsoleOnShake(
              child: Scaffold(
                  key: Key(group.students.length.toString() + "-" + group.uuId),
                  /* appBar: AppBar(
          title: Text(locText(context, key: "groups")),
        ),
        */
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
                                      return StudentItemWidget(
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
                  child: Container(
                    color: Colors.red,

                    width: 300,
                    height: 50,
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
