import 'package:dusza2019/resources/pojos/pojo_group.dart';
import 'package:dusza2019/resources/pojos/pojo_student.dart';
import 'package:dusza2019/widgets/dialogs/dialogs.dart';
import 'package:flutter/material.dart';
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
        child: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Stack(
              children: <Widget>[

                Positioned(
                  left: 0,
                  child: IconButton(
                    icon: Icon(FontAwesomeIcons.times),
                    color: Colors.red,
                    onPressed: () async {
                      await showDeleteGradeDialog(context, index, student, group);
                    },
                  ),
                ),

                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(grade.toString(),
                      style: TextStyle(
                          fontSize: 22, fontWeight: FontWeight.w700
                      ),
                    ),
                  ),
                ),

                Container(),

              ],
            )
        )


    );
  }
}
