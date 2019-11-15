import 'package:dusza2019/blocs/groups_bloc.dart';
import 'package:dusza2019/other/hazizz_localizations.dart';
import 'package:dusza2019/pojos/pojo_student.dart';
import 'package:dusza2019/widgets/dialogs/dialogs.dart';
import 'package:dusza2019/widgets/items/grade_item_widget.dart';
import 'package:dusza2019/widgets/items/student_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class GradePage extends StatefulWidget {

  PojoStudent student;

  GradePage({Key key, this.student}) : super(key: key);

  @override
  _GradePage createState() => _GradePage();
}

class _GradePage extends State<GradePage> with AutomaticKeepAliveClientMixin {

  GroupsBloc groupsBloc = new GroupsBloc();



  _GradePage();

  @override
  void initState() {
    groupsBloc.dispatch(FetchGroupEvent());


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(//LogConsoleOnShake(
      // tag: "group",
      child: Scaffold(
        /* appBar: AppBar(
          title: Text(locText(context, key: "groups")),
        ),
        */
          floatingActionButton: FloatingActionButton(
            child: Icon(FontAwesomeIcons.plus),
            onPressed: (){
              showAddGradeDialog(context);
            },
          ),
          body: SafeArea(
            child: new RefreshIndicator(
                child: Column(
                  children: <Widget>[

                    Text(locText(context, key: "grades"), style: TextStyle(fontSize: 26),),
                    Expanded(
                      child: ListView.builder(
                        // physics: BouncingScrollPhysics(),
                          itemCount: widget.student.grades.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GradeItemWidget(grade: widget.student.grades[index]);
                          }
                      )
                    ),

                  ],
                ),
                onRefresh: () async => groupsBloc.dispatch(FetchGroupEvent()) //await getData()
            ),
          )
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}


