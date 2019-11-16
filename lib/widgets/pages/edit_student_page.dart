import 'package:dusza2019/blocs/selected_bloc.dart';
import 'package:dusza2019/pojos/pojo_group.dart';
import 'package:dusza2019/pojos/pojo_student.dart';
import 'package:dusza2019/widgets/dialogs/dialogs.dart';
import 'package:dusza2019/widgets/items/grade_item_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StudentEditPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: BlocProvider.of<SelectedBloc>(context),
        builder: (BuildContext context, SelectedState state) {
          if (state is SelectionReadyState) {
            PojoStudent student = state.student;
            PojoGroup group = state.group;
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
                      Text("Diák: ${student.name}",
                          style: TextStyle(fontSize: 26)),
                      Text("Jegyek", style: TextStyle(fontSize: 20)),
                      Expanded(
                          child: ListView.builder(
                              // physics: BouncingScrollPhysics(),
                              itemCount: student.grades.length,
                              itemBuilder: (BuildContext context, int index) {
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
        });
  }
}
