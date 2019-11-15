import 'package:dusza2019/blocs/path_bloc.dart';
import 'package:dusza2019/pojos/pojo_group.dart';
import 'package:dusza2019/pojos/pojo_student.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StudentItemWidget extends StatelessWidget{

  PojoStudent student;

  bool absentMode = false;

  StudentItemWidget({this.student});

  StudentItemWidget.absentMode({this.student}){
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
                              PathsBloc().dispatch(SetPathStudentEvent(student: student));
                              Navigator.pushNamed(context, "/student/edit", arguments: student);

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
