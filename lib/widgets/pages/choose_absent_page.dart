import 'package:dusza2019/blocs/groups_bloc.dart';
import 'package:dusza2019/blocs/selected_bloc.dart';
import 'package:dusza2019/game_parts/winner_picker.dart';
import 'package:dusza2019/managers/felelek_localizations.dart';
import 'package:dusza2019/resources/spinner_data.dart';
import 'package:dusza2019/resources/pojos/pojo_group.dart';
import 'package:dusza2019/resources/pojos/pojo_student.dart';
import 'package:dusza2019/widgets/items/student_absent_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AbsentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: BlocProvider.of<SelectedBloc>(context),
        builder: (BuildContext context, SelectedState selectedState) {
          if (selectedState is SelectionReadyState) {
            PojoGroup group = selectedState.group;
            List<PojoStudent> absents = selectedState.absentStudents;
            return BlocBuilder(
                bloc: BlocProvider.of<GroupsBloc>(context),
                builder: (BuildContext context, GroupState groupState) {
                  if (groupState is LoadedGroupState) {
                    List<PojoStudent> nonAbsent = List.from(group.students);
                    absents.forEach((PojoStudent absent) {
                      nonAbsent.remove(absent);
                    });

                    return Scaffold(
                        body: SafeArea(
                            child: Column(children: <Widget>[
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            IconButton(
                                icon: Icon(FontAwesomeIcons.arrowLeft),
                                color: Colors.black,
                                onPressed: () {
                                  Navigator.pop(context);
                                }),
                            Text(
                              "${locText(context, key: "group")}: ${group.name}",
                              style: TextStyle(fontSize: 26),
                            ),
                            IconButton(
                                icon: Icon(FontAwesomeIcons.fileImport),
                                color: Colors.transparent,
                                onPressed: () {}),
                          ]),
                      Text(
                        "${nonAbsent.length} felhasználó jelen",
                        style: TextStyle(fontSize: 22),
                      ),
                      Expanded(
                          child: ListView.builder(
                              itemCount: group.students.length,
                              itemBuilder: (BuildContext context, int index) {
                                return StudentAbsentWidget(
                                    student: group.students[index],
                                    group: group);
                              })),
                      Builder(builder: (BuildContext context) {
                        if (nonAbsent.length > 0) {
                          return Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: SizedBox(
                                  height: 50,
                                  width: double.maxFinite,
                                  child: RaisedButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      child: Text("Kezdés",
                                          style: TextStyle(fontSize: 24)),
                                      onPressed: () {
                                        SpinnerData data = new SpinnerData(
                                            nonAbsent, pickWinner(nonAbsent));
                                        Navigator.pushNamed(
                                            context, "/absent/spinner",
                                            arguments: data);
                                      })));
                        }
                        return Container();
                      })
                    ])));
                  }
                  return Center(child: CircularProgressIndicator());
                });
          }
          return Center(child: CircularProgressIndicator());
        });
  }
}
