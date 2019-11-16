import 'package:auto_size_text/auto_size_text.dart';
import 'package:dusza2019/blocs/groups_bloc.dart';
import 'package:dusza2019/other/hazizz_localizations.dart';
import 'package:dusza2019/pojos/pojo_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dialogs.dart';

class AddGradeDialog extends StatefulWidget {


  AddGradeDialog({Key key}) : super(key: key);


  @override
  _AddGradeDialog createState() => new _AddGradeDialog();
}

class _AddGradeDialog extends State<AddGradeDialog> {

  final double width = 300;
  final double height = 190;

  TextEditingController _gradeTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var dialog = HazizzDialog(width: width, height: height,
        header: Container(
          width: width,
          color: Theme.of(context).primaryColor,
          child: Padding(
            padding: const EdgeInsets.all(5),
            child:
            AutoSizeText( "Add grade",
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.w700,
              ),
              maxLines: 1,
              minFontSize: 20,
              maxFontSize: 30,

            ),
          ),
        ),
        content: Container(
          child: Stack(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      TextField(
                        style: TextStyle(fontSize: 22),
                        inputFormatters:[
                          LengthLimitingTextInputFormatter(1),
                        ],
                        autofocus: true,

                        controller: _gradeTextEditingController,
                        textInputAction: TextInputAction.send,
                      ),
                    ],
                  )
              ),
            ],
          ),
        ),
        actionButtons: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FlatButton(
                child: Center(
                  child: Text(locText(context, key: "cancel").toUpperCase()),
                ),
                onPressed: () {
                  Navigator.of(context).pop(null);
                },
                color: Colors.transparent
            ),
            FlatButton(

                child: Center(
                  child: Text(locText(context, key: "add"),
                    style: TextStyle(
                      //  fontFamily: 'Montserrat',
                    ),
                  ),
                ),
                onPressed: () async {
                  GroupsBloc bloc = BlocProvider.of<GroupsBloc>(context);
                  GroupEvent event = AddGradeEvent(int.parse(_gradeTextEditingController.text),
                      bloc.selectedStudent,
                      bloc.selectedGroup);
                  bloc.dispatch(event);
                  Navigator.of(context).pop();
                }
            ),
          ],
        )
    );
    return dialog;
  }
}