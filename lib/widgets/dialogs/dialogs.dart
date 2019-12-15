import 'package:dusza2019/resources/pojos/pojo_group.dart';
import 'package:dusza2019/resources/pojos/pojo_student.dart';
import 'package:dusza2019/widgets/dialogs/add_group_dialog.dart';
import 'package:dusza2019/widgets/dialogs/add_student_dialog.dart';
import 'package:flutter/material.dart';

import 'add_grade_dialog.dart';
import 'delete_grade_dialog.dart';
import 'delete_group_dialog.dart';
import 'delete_student_dialog.dart';

// 280 min width
class DialogHelper extends Dialog {
  static const double buttonBarHeight = 48.0;

  Widget decor;
  final Widget header, content;
  final Widget actionButtons;
  final double height, width;

  DialogHelper(
      {this.decor,
      this.header,
      this.content,
      this.actionButtons,
      @required this.height,
      @required this.width}) {
    if (decor == null) {
      decor = Container(
        width: 10,
        height: 10,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Stack(
          children: <Widget>[
            Container(
                height: height + buttonBarHeight,
                width: width,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: width * 2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                        ),
                        child: Center(child: header),
                      ),
                    ),
                    Expanded(
                      child: Builder(builder: (BuildContext context) {
                        if (content != null) {
                          return content;
                        }
                        return Container();
                      }),
                    ),
                    Center(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          actionButtons,
                        ],
                      ),
                    )
                  ],
                )),
            decor,
          ],
        ));
  }
}

Future showAddGroupDialog(
  BuildContext context,
) async {
  var d = AddGroupDialog();
  var result = showDialog(
      context: context,
      builder: (context2) {
        return d;
      });
  return result;
}

Future showAddStudentDialog(
  BuildContext context,
) async {
  var d = AddStudentDialog();
  var result = showDialog(
      context: context,
      builder: (context2) {
        return d;
      });
  return result;
}

Future<int> showAddGradeDialog(
  BuildContext context,
) async {
  var result = await showDialog(
      context: context,
      builder: (context2) {
        return AddGradeDialog();
      });
  return result;
}

Future<int> showDeleteGroupDialog(
  BuildContext context,
  PojoGroup group,
) async {
  var result = await showDialog(
      context: context,
      builder: (context2) {
        return DeleteGroupDialog(group);
      });
  return result;
}

Future<int> showDeleteStudentDialog(
    BuildContext context, PojoStudent student, PojoGroup group) async {
  var result = await showDialog(
      context: context,
      builder: (context2) {
        return DeleteStudentDialog(student: student, group: group);
      });
  return result;
}

Future<int> showDeleteGradeDialog(BuildContext context, int index,
    PojoStudent student, PojoGroup group) async {
  var result = await showDialog(
      context: context,
      builder: (context2) {
        return DeleteGradeDialog(index: index, student: student, group: group);
      });
  return result;
}
