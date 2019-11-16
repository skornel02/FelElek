import 'package:dusza2019/blocs/groups_bloc.dart';
import 'package:dusza2019/other/hazizz_localizations.dart';
import 'package:dusza2019/pojos/pojo_group.dart';
import 'package:dusza2019/widgets/dialogs/dialogs.dart';
import 'package:dusza2019/widgets/items/student_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GroupEditPage extends StatelessWidget {
  GroupEditPage({Key key}) : super(key: key);

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
}
