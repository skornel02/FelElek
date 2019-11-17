import 'package:auto_size_text/auto_size_text.dart';
import 'package:dusza2019/blocs/groups_bloc.dart';
import 'package:dusza2019/managers/felelek_localizations.dart';
import 'package:dusza2019/resources/pojos/pojo_group.dart';
import 'package:dusza2019/widgets/dialogs/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteGroupDialog extends StatelessWidget {
  final PojoGroup group;

  DeleteGroupDialog(this.group, {Key key}) : super(key: key);

  final double width = 300;
  final double height = 80;

  @override
  Widget build(BuildContext context) {
    var dialog = DialogHelper(
        width: width,
        height: height,
        header: Container(
          height: height,
          width: width,
          color: Colors.red,
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Center(
              child: AutoSizeText(
                "Biztos hogy törlőd a csoportot?",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
                maxLines: 2,
                minFontSize: 16,
                maxFontSize: 22,
              ),
            ),
          ),
        ),
        actionButtons: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FlatButton(
                child: Center(
                  child: Text(locText(context, key: "no").toUpperCase()),
                ),
                onPressed: () {
                  Navigator.of(context).pop(null);
                },
                color: Colors.transparent),
            Builder(
              builder: (BuildContext context) {
                return FlatButton(
                    child: Center(
                      child: Text(
                        locText(context, key: "yes").toUpperCase(),
                        style: TextStyle(),
                      ),
                    ),
                    onPressed: () {
                      GroupsBloc bloc = BlocProvider.of<GroupsBloc>(context);
                      GroupEvent event = RemoveGroupEvent(group);
                      bloc.dispatch(event);
                      Navigator.pop(context);
                    });
              },
            )
          ],
        ));
    return dialog;
  }
}
