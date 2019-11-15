import 'package:dusza2019/blocs/groups_bloc.dart';
import 'package:dusza2019/blocs/path_bloc.dart';
import 'package:dusza2019/pojos/pojo_group.dart';
import 'package:dusza2019/pojos/pojo_student.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StudentItemWidget extends StatelessWidget{

  PojoStudent student;
  PojoGroup group;

  bool absentMode = false;

  StudentItemWidget({this.student, this.group});

  StudentItemWidget.absentMode({this.student, this.group}){
    absentMode = true;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 5,
        child: InkWell(

            child:
            Align(
                alignment: Alignment.centerLeft,
                child:
                Padding(
                    padding: const EdgeInsets.only(left: 8, /*top: 4, bottom: 4*/),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(FontAwesomeIcons.times),
                          color: Colors.red,
                          onPressed: (){
                            BlocProvider.of<GroupsBloc>(context)
                                .dispatch(RemoveStudentEvent(student, group));
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
                            if(absentMode){
                              // kiveni a listából

                            }else{
                              BlocProvider.of<GroupsBloc>(context)
                                  .dispatch(SetSelectedStudentEvent(student, group));
                              PathsBloc().dispatch(SetPathStudentEvent(student: student));
                              Navigator.pushNamed(context, "/student/edit", arguments: [student, group]);
                            }
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
