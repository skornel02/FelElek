import 'package:auto_size_text/auto_size_text.dart';
import 'package:dusza2019/blocs/groups_bloc.dart';
import 'package:dusza2019/blocs/selected_bloc.dart';
import 'package:dusza2019/managers/felelek_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dialogs.dart';

class AddGradeDialog extends StatefulWidget {
  AddGradeDialog({Key key}) : super(key: key);

  @override
  _AddGradeDialog createState() => new _AddGradeDialog();
}

class _AddGradeDialog extends State<AddGradeDialog> {
  final double width = 280;
  final double height = 90;

  int _currentGrade = 5;

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
                locText(context, key: "addGrade"),
                style: TextStyle(
                  fontSize: 25.0,
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
              DropdownButton(
                value: _currentGrade,
                onChanged: (value) {
                  setState(() {
                    _currentGrade = value;
                  });
                },
                items: [
                  DropdownMenuItem(child: Text("1"), value: 1),
                  DropdownMenuItem(child: Text("2"), value: 2),
                  DropdownMenuItem(child: Text("3"), value: 3),
                  DropdownMenuItem(child: Text("4"), value: 4),
                  DropdownMenuItem(child: Text("5"), value: 5),
                ],
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
                color: Colors.transparent),
            BlocBuilder(
              bloc: BlocProvider.of<SelectedBloc>(context),
              builder: (BuildContext context, SelectedState state) {
                if (state is SelectionReadyState) {
                  return FlatButton(
                      child: Center(
                        child: Text(
                          locText(context, key: "add").toUpperCase(),
                          style: TextStyle(),
                        ),
                      ),
                      onPressed: () async {
                        GroupsBloc bloc = BlocProvider.of<GroupsBloc>(context);
                        GroupEvent event = AddGradeEvent(
                            _currentGrade, state.student, state.group);
                        bloc.dispatch(event);
                        Navigator.of(context).pop(_currentGrade);
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
