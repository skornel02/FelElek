import 'package:auto_size_text/auto_size_text.dart';
import 'package:dusza2019/blocs/groups_bloc.dart';
import 'package:dusza2019/other/felelek_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dialogs.dart';

class AddGroupDialog extends StatefulWidget {
  AddGroupDialog({Key key}) : super(key: key);

  @override
  _AddGroupDialog createState() => new _AddGroupDialog();
}

class _AddGroupDialog extends State<AddGroupDialog> {
  final double width = 300;
  final double height = 130;

  TextEditingController _gradeTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var dialog = DialogHelper(
        width: width,
        height: height,
        header: Container(
          width: width,
          color: Theme.of(context).primaryColor,
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Center(
              child: AutoSizeText(
                "Add group",
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
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(30),
                        ],
                        autofocus: true,
                        controller: _gradeTextEditingController,
                        textInputAction: TextInputAction.send,
                      ),
                    ],
                  )),
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
                color: Colors.transparent),
            FlatButton(
                child: Center(
                  child: Text(
                    locText(context, key: "add"),
                    style: TextStyle(),
                  ),
                ),
                onPressed: () async {
                  GroupEvent event =
                      AddGroupEvent(_gradeTextEditingController.text);
                  BlocProvider.of<GroupsBloc>(context).dispatch(event);
                  Navigator.of(context).pop();
                }),
          ],
        ));
    return dialog;
  }
}
