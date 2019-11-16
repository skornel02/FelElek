import 'package:dusza2019/blocs/groups_bloc.dart';
import 'package:dusza2019/pojos/pojo_group.dart';
import 'package:dusza2019/pojos/pojo_student.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GradeItemWidget extends StatelessWidget {
  final int index;
  final int grade;
  final PojoStudent student;
  final PojoGroup group;

  GradeItemWidget({this.index, this.student, this.group})
      : grade = student.grades[index];

  @override
  Widget build(BuildContext context) {
    return Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 5,
        child: InkWell(
            child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(grade.toString(),
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w700)),
                          IconButton(
                              icon: Icon(FontAwesomeIcons.times),
                              color: Colors.red,
                              onPressed: () {
                                BlocProvider.of<GroupsBloc>(context).dispatch(
                                    RemoveGradeEvent(index, student, group));
                              }),
                        ])))));
  }
}
