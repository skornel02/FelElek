import 'package:dusza2019/blocs/groups_bloc.dart';
import 'package:dusza2019/other/hazizz_localizations.dart';
import 'package:dusza2019/pojos/pojo_group.dart';
import 'package:dusza2019/pojos/pojo_student.dart';
import 'package:dusza2019/widgets/dialogs/dialogs.dart';
import 'package:dusza2019/widgets/items/grade_item_widget.dart';
import 'package:dusza2019/widgets/items/student_item_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class StudentEditPage extends StatefulWidget {

  PojoStudent student;
  PojoGroup group;

  StudentEditPage({Key key, dynamic args}) : super(key: key){
    student = args[0];
    group = args[1];
  }

  @override
  _StudentEditPage createState() => _StudentEditPage();
}

class _StudentEditPage extends State<StudentEditPage> with AutomaticKeepAliveClientMixin {

  _StudentEditPage();

  @override
  void initState() {
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
                    Text("Diák: ${widget.student.name}", style: TextStyle(fontSize: 26)),
                    Text("Jegyek", style: TextStyle(fontSize: 20)),
                    Expanded(
                      child: ListView.builder(
                        // physics: BouncingScrollPhysics(),
                          itemCount: widget.student.grades.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GradeItemWidget(index: index, student: widget.student, group: widget.group);
                          }
                      )
                    ),

                  ],
                ),
                onRefresh: () async => BlocProvider.of<GroupsBloc>(context).dispatch(ReloadGroupEvent()) //await getData()
            ),
          )
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}


