import 'package:dusza2019/widgets/dialogs/add_group_dialog.dart';
import 'package:dusza2019/widgets/dialogs/add_user_dialog.dart';
import 'package:flutter/material.dart';

import '../../other/hazizz_localizations.dart';
import '../../other/hazizz_theme.dart';
import 'add_grade_dialog.dart';


// 280 min width
class HazizzDialog extends Dialog{

  static const double buttonBarHeight = 48.0;

  final Widget header, content;

  final Widget actionButtons;

  final double height, width;

  HazizzDialog({this.header, this.content, this.actionButtons,@required this.height,@required this.width}){
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Container(
            height: height + buttonBarHeight,
            width: width,
            decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
            child: Column(
              children: <Widget>[
                Container(
                  //  height: 64.0,
                  width: width*2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                    ),
                    //   color: Theme.of(context).primaryColor
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
                  child: Builder(
                      builder: (BuildContext context){
                        if(content != null){
                          return content;
                        }
                        return Container();
                      }
                  ),
                ),
                //  Spacer(),

                //  SizedBox(height: 20.0),

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
            )
        ));
  }
}

Future showAddGroupDialog(BuildContext context,) async{
  var d = AddGroupDialog();
  var result = showDialog(context: context, builder: (context2){
    return d;
  });
  return result;
}

Future showAddStudentDialog(BuildContext context,) async{
  var d = AddStudentDialog();
  var result = showDialog(context: context, builder: (context2){
    return d;
  });
  return result;
}

Future<int> showAddGradeDialog(BuildContext context,) async{
  var result = await showDialog(context: context, builder: (context2){
    return AddGradeDialog();
  });
  return result;
}

Future<bool> showDeleteTaskDialog(context, {@required int taskId}) async {

  double height = 80;
  double width = 200;

  bool success = false;

  bool pressed = false;

  HazizzDialog hazizzDialog = new HazizzDialog(
      header:
      Container(
        height: height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
            color: HazizzTheme.warningColor
        ),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            locText(context, key: "areyousure_delete_task"),
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
      content:
      Container(),
      actionButtons:
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FlatButton(
              child: Center(
                child: Text(
                    locText(context, key: "cancel").toUpperCase()
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              color: Colors.transparent
          ),
          FlatButton(
              child: Center(
                child: Text(
                  locText(context, key: "delete").toUpperCase(),
                  style: TextStyle(
                      color: HazizzTheme.warningColor),
                ),
              ),
              onPressed: () async {

              },
              color: Colors.transparent
          ),
        ],
      )
      ,height: height,width: width);

  await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return hazizzDialog;
      }
  );
  return success;
}
