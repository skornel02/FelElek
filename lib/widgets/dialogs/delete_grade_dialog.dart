import 'package:auto_size_text/auto_size_text.dart';
import 'package:dusza2019/blocs/groups_bloc.dart';
import 'package:dusza2019/managers/felelek_localizations.dart';
import 'package:dusza2019/resources/pojos/pojo_group.dart';
import 'package:dusza2019/resources/pojos/pojo_student.dart';
import 'package:dusza2019/widgets/dialogs/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteGradeDialog extends StatelessWidget {
  final int index;
  final PojoStudent student;
  final PojoGroup group;

  DeleteGradeDialog({Key key, this.index, this.student, this.group})
      : super(key: key);

  final double width = 300;
  final double height = 80;

  @override
  Widget build(BuildContext context) {
    var dialog = DialogHelper(
        width: width,
        height: height,
        header: Container(
          width: width,
          color: Colors.red,
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Center(
              child: AutoSizeText(
                locText(context, key: "gradeRemovalConfirmation"),
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
                      BlocProvider.of<GroupsBloc>(context)
                          .dispatch(RemoveGradeEvent(index, student, group));
                      Navigator.of(context).pop();
                    });
              },
            )
          ],
        ));
    return dialog;
  }
}
