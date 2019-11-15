import 'package:dusza2019/blocs/groups_bloc.dart';
import 'package:dusza2019/other/hazizz_localizations.dart';
import 'package:dusza2019/pojos/pojo_group.dart';
import 'package:dusza2019/pojos/pojo_student.dart';
import 'package:dusza2019/widgets/dialogs/dialogs.dart';
import 'package:dusza2019/widgets/items/student_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GroupEditPage extends StatefulWidget {

  PojoGroup group;

  GroupEditPage({Key key, this.group}) : super(key: key);

  @override
  _GroupEditPage createState() => _GroupEditPage();
}

class _GroupEditPage extends State<GroupEditPage> with AutomaticKeepAliveClientMixin {

  _GroupEditPage();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<PojoStudent> students = widget.group.students;

    return Container(//LogConsoleOnShake(
      child: Scaffold(
        key: Key(students.length.toString() + "-" + widget.group.uuId),
        /* appBar: AppBar(
          title: Text(locText(context, key: "groups")),
        ),
        */
        floatingActionButton: FloatingActionButton(
          child: Icon(FontAwesomeIcons.plus),
          onPressed: (){
            showAddStudentDialog(context);
          },
        ),
          body: SafeArea(
            child: new RefreshIndicator(
                child: Column(
                  children: <Widget>[
                    Text("${locText(context, key: "group")}: ${widget.group.name}", style: TextStyle(fontSize: 26),),
                    Text("${widget.group.students.length} felhasználó",
                      style: TextStyle(fontSize: 22),),
                    Expanded(
                      child:
                        ListView.builder(
                        // physics: BouncingScrollPhysics(),
                        itemCount: students.length,
                        itemBuilder: (BuildContext context, int index) {
                          return StudentItemWidget(student: students[index], group: widget.group);
                        }
                      )
                    ),
                  ],
                ),
                onRefresh: () async =>  BlocProvider.of<GroupsBloc>(context)
                    .dispatch(ReloadGroupEvent()) //await getData()
            ),
          )
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}


