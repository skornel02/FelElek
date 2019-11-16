import 'package:dusza2019/blocs/selected_bloc.dart';
import 'package:dusza2019/pojos/pojo_group.dart';
import 'package:dusza2019/pojos/pojo_student.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StudentAbsentWidget extends StatelessWidget {
  PojoStudent student;
  PojoGroup group;

  StudentAbsentWidget({this.student, this.group});

  @override
  Widget build(BuildContext context) {
    return Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 5,
        child: InkWell(
            child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                    padding: const EdgeInsets.only(
                      left: 8, /*top: 4, bottom: 4*/
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          student.name + " (${student.grades.length} jegy)",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w700),
                        ),
                        BlocBuilder(
                          bloc: BlocProvider.of<SelectedBloc>(context),
                          builder: (BuildContext context, SelectedState state) {
                            if (state is SelectionReadyState){
                              bool absent = state.absentStudents.contains(student);
                              return Checkbox(
                                value: absent,
                                onChanged: (bool next) {
                                  BlocProvider.of<SelectedBloc>(context)
                                      .dispatch(SetAbsentStudent(student, next));
                                },
                              );
                            }
                            return Center(child: CircularProgressIndicator());
                          },
                        )
                      ],
                    )))));
  }
}
