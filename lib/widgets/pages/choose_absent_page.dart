import 'package:dusza2019/blocs/groups_bloc.dart';
import 'package:dusza2019/other/hazizz_localizations.dart';
import 'package:dusza2019/pojos/pojo_group.dart';
import 'package:dusza2019/pojos/pojo_student.dart';
import 'package:dusza2019/widgets/items/student_edit_item_widget.dart';
import 'package:flutter/material.dart';

class AbsentPage extends StatefulWidget {

  PojoGroup group;

  AbsentPage({Key key, this.group}) : super(key: key);

  @override
  _AbsentPage createState() => _AbsentPage();
}

class _AbsentPage extends State<AbsentPage> with AutomaticKeepAliveClientMixin {

  GroupsBloc groupsBloc = new GroupsBloc();

  List<PojoStudent> choseStudents;

  _AbsentPage();
  @override
  void initState() {
    groupsBloc.dispatch(ReloadGroupEvent());

    choseStudents = widget.group.students;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {



    return Container(
      child: Scaffold(

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
                            itemCount: choseStudents.length,
                            itemBuilder: (BuildContext context, int index) {
                              return StudentItemWidget(student: choseStudents[index],);
                            }
                        )
                    ),
                    RaisedButton(
                      child: Text(locText(context, key: "next")),
                      onPressed: (){
                        Navigator.pushNamed(context, "/absent/spinner", arguments: choseStudents);
                      },
                    )
                  ],
                ),
                onRefresh: () async => groupsBloc.dispatch(ReloadGroupEvent()) //await getData()
            ),
          )
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}


