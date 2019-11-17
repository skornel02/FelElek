import 'package:dusza2019/blocs/groups_bloc.dart';
import 'package:dusza2019/blocs/selected_bloc.dart';
import 'package:dusza2019/managers/felelek_localizations.dart';
import 'package:dusza2019/resources/pojos/pojo_group.dart';
import 'package:dusza2019/resources/pojos/pojo_student.dart';
import 'package:dusza2019/widgets/dialogs/dialogs.dart';
import 'package:dusza2019/widgets/items/grade_item_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class StudentEditPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: BlocProvider.of<SelectedBloc>(context),
        builder: (BuildContext context, SelectedState state) {
          if (state is SelectionReadyState) {
            PojoStudent student = state.student;
            PojoGroup group = state.group;
            return BlocBuilder(
              bloc: BlocProvider.of<GroupsBloc>(context),
              builder: (BuildContext context, GroupState state) {
                if (state is LoadedGroupState) {
                  return Container(
                    child: Scaffold(
                        floatingActionButton: FloatingActionButton(
                          child: Icon(FontAwesomeIcons.plus),
                          onPressed: () {
                            showAddGradeDialog(context);
                          },
                        ),
                        body: SafeArea(
                            child: Column(
                          children: <Widget>[
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  IconButton(
                                    icon: Icon(FontAwesomeIcons.arrowLeft),
                                    color: Colors.black,
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                  Text(
                                      "${locText(context, key: "student")}: ${student.name}",
                                      style: TextStyle(fontSize: 26)),
                                  IconButton(
                                    icon: Icon(FontAwesomeIcons.fileImport),
                                    color: Colors.transparent,
                                    onPressed: () {},
                                  ),
                                ]),
                            Text(
                                toBeginningOfSentenceCase(
                                    locText(context, key: "grades")),
                                style: TextStyle(fontSize: 20)),
                            Expanded(
                                child: ListView.builder(
                                    itemCount: student.grades.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return GradeItemWidget(
                                          index: index,
                                          student: student,
                                          group: group);
                                    })),
                          ],
                        ))),
                  );
                }
                return Center(child: CircularProgressIndicator());
              },
            );
          }
          return Center(child: CircularProgressIndicator());
        });
  }
}
