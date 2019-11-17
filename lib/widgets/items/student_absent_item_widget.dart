import 'package:auto_size_text/auto_size_text.dart';
import 'package:dusza2019/blocs/selected_bloc.dart';
import 'package:dusza2019/resources/pojos/pojo_group.dart';
import 'package:dusza2019/resources/pojos/pojo_student.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StudentAbsentWidget extends StatelessWidget {
  final PojoStudent student;
  final PojoGroup group;
  final double chance;

  StudentAbsentWidget({this.student, this.group, this.chance});

  @override
  Widget build(BuildContext context) {
    String percentage = (chance * 100).toStringAsFixed(0) + "%";
    if(percentage == "0%" && chance != 0.0)
      percentage = "<1%";

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
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: AutoSizeText(
                              student.name,
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w700),
                              maxLines: 2,
                              minFontSize: 16,
                              maxFontSize: 22,
                            ),
                          ),

                          // Spacer(),

                          Text(
                            "($percentage)",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w700),
                          ),
                          BlocBuilder(
                              bloc: BlocProvider.of<SelectedBloc>(context),
                              builder:
                                  (BuildContext context, SelectedState state) {
                                if (state is SelectionReadyState) {
                                  bool absent =
                                      state.absentStudents.contains(student);
                                  return Checkbox(
                                      value: absent,
                                      onChanged: (bool next) {
                                        BlocProvider.of<SelectedBloc>(context)
                                            .dispatch(SetAbsentStudent(
                                                student, next));
                                      });
                                }
                                return Center(
                                    child: CircularProgressIndicator());
                              })
                        ])))));
  }
}
