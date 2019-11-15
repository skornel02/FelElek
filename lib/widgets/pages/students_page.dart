import 'package:dusza2019/blocs/groups_bloc.dart';
import 'package:dusza2019/other/hazizz_localizations.dart';
import 'package:dusza2019/pojos/pojo_group.dart';
import 'package:dusza2019/pojos/pojo_student.dart';
import 'package:dusza2019/widgets/items/student_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StudentsPage extends StatefulWidget {

  PojoGroup group;

  StudentsPage({Key key, this.group}) : super(key: key);

  @override
  _StudentsPage createState() => _StudentsPage();
}

class _StudentsPage extends State<StudentsPage> with AutomaticKeepAliveClientMixin {

  GroupsBloc groupsBloc = new GroupsBloc();



  _StudentsPage();
  @override
  void initState() {
    groupsBloc.dispatch(FetchGroupEvent());


    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    List<PojoStudent> students = widget.group.students;

    print("");

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

          },
        ),
          body: SafeArea(
            child: new RefreshIndicator(
                child: Column(
                  children: <Widget>[
                    Text("${locText(context, key: "group")}: ${widget.group.name}", style: TextStyle(fontSize: 26),),

                    Text(locText(context, key: "students"), style: TextStyle(fontSize: 22),),
                    Expanded(
                      child:
                        ListView.builder(
                        // physics: BouncingScrollPhysics(),
                        itemCount: students.length,
                        itemBuilder: (BuildContext context, int index) {
                          return StudentItemWidget(student: students[index],);
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


