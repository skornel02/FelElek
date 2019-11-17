import 'package:dusza2019/blocs/selected_bloc.dart';
import 'package:dusza2019/resources/pojos/pojo_group.dart';
import 'package:dusza2019/resources/pojos/pojo_student.dart';
import 'package:dusza2019/widgets/dialogs/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StudentEditorWidget extends StatelessWidget {
  final PojoStudent student;
  final PojoGroup group;

  StudentEditorWidget({this.student, this.group});

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
                        IconButton(
                          icon: Icon(FontAwesomeIcons.times),
                          color: Colors.red,
                          onPressed: () async {
                            await showDeleteStudentDialog(context, student, group);
                          },
                        ),
                        Text(student.name,
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w700
                          ),
                        ),
                        IconButton(
                          icon: Icon(FontAwesomeIcons.edit),
                          onPressed: (){
                              BlocProvider.of<SelectedBloc>(context)
                                  .dispatch(SetSelectedStudent(student));
                              Navigator.pushNamed(context, "/student/edit");
                          },
                        ),
                      ],
                    )
                )
            )
        )
    );
  }
}
