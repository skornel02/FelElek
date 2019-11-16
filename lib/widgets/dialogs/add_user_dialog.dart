import 'package:auto_size_text/auto_size_text.dart';
import 'package:dusza2019/blocs/groups_bloc.dart';
import 'package:dusza2019/blocs/selected_bloc.dart';
import 'package:dusza2019/other/felelek_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dialogs.dart';

class AddStudentDialog extends StatefulWidget {
  AddStudentDialog({Key key}) : super(key: key);

  @override
  _AddStudentDialog createState() => new _AddStudentDialog();
}

class _AddStudentDialog extends State<AddStudentDialog> {
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
                "Add student",
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
                          LengthLimitingTextInputFormatter(40),
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
            BlocBuilder(
              bloc: BlocProvider.of<SelectedBloc>(context),
              builder: (BuildContext context, SelectedState state) {
                if (state is SelectionReadyState) {
                  return FlatButton(
                      child: Center(
                        child: Text(
                          locText(context, key: "add"),
                        ),
                      ),
                      onPressed: () async {
                        GroupsBloc bloc = BlocProvider.of<GroupsBloc>(context);
                        GroupEvent event = AddStudentEvent(
                            _gradeTextEditingController.text, state.group);
                        bloc.dispatch(event);
                        Navigator.of(context).pop();
                      });
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            )
          ],
        ));
    return dialog;
  }
}
