import 'package:dusza2019/blocs/groups_bloc.dart';
import 'package:dusza2019/blocs/selected_bloc.dart';
import 'package:dusza2019/other/hazizz_localizations.dart';
import 'package:dusza2019/pojos/pojo_group.dart';
import 'package:dusza2019/widgets/dialogs/dialogs.dart';
import 'package:dusza2019/widgets/items/student_edit_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GroupEditPage extends StatelessWidget {
  GroupEditPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: BlocProvider.of<SelectedBloc>(context),
        builder: (BuildContext context, SelectedState state) {
          if (state is SelectionReadyState) {
            PojoGroup group = state.group;
            return BlocBuilder(
              bloc: BlocProvider.of<GroupsBloc>(context),
              builder: (BuildContext context, GroupState state) {
                if(state is LoadedGroupState){
                  return Container(
                      child: Scaffold(
                          floatingActionButton: FloatingActionButton(
                            child: Icon(FontAwesomeIcons.plus),
                            onPressed: () {
                              showAddStudentDialog(context);
                            },
                          ),
                          body: SafeArea(
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
                          )));
                }
                return Center(child: CircularProgressIndicator());
              },
            );
          }
          return Center(child: CircularProgressIndicator());
        });
  }
}
