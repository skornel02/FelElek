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

class StudentEditPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: BlocProvider.of<GroupsBloc>(context),
        builder: (BuildContext context, GroupState state) {
          if (state is LoadedGroupState) {
            PojoStudent student = state.selectedStudent;
            PojoGroup group = state.selectedGroup;
            return Container(
              child: Scaffold(
                  floatingActionButton: FloatingActionButton(
                    child: Icon(FontAwesomeIcons.plus),
                    onPressed: () {
                      showAddGradeDialog(context);
                    },
                  ),
                  body: SafeArea(
                    child: new RefreshIndicator(
                        child: Column(
                          children: <Widget>[
                            Text("Diák: ${student.name}",
                                style: TextStyle(fontSize: 26)),
                            Text("Jegyek", style: TextStyle(fontSize: 20)),
                            Expanded(
                                child: ListView.builder(
                                    // physics: BouncingScrollPhysics(),
                                    itemCount: student.grades.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return GradeItemWidget(
                                          index: index,
                                          student: student,
                                          group: group);
                                    })),
                          ],
                        ),
                        onRefresh: () async =>
                            BlocProvider.of<GroupsBloc>(context)
                                .dispatch(ReloadGroupEvent()) //await getData()
                        ),
                  )),
            );
          }
          return Center(child: CircularProgressIndicator());
        });
  }
}
