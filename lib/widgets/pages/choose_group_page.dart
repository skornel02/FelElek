import 'package:dusza2019/blocs/groups_bloc.dart';
import 'package:dusza2019/blocs/selected_bloc.dart';
import 'package:dusza2019/other/felelek_localizations.dart';
import 'package:dusza2019/pojos/pojo_group.dart';
import 'package:dusza2019/widgets/dialogs/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../items/group_item_widget.dart';

class GroupsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
            floatingActionButton: Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: FloatingActionButton(
                child: Icon(FontAwesomeIcons.plus),
                onPressed: () {
                  showAddGroupDialog(context);
                },
              ),
            ),
            body: SafeArea(
                child: new RefreshIndicator(
                    child: Column(
                      children: <Widget>[
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              IconButton(
                                icon: Icon(FontAwesomeIcons.sync),
                                color: Colors.black,
                                onPressed: () {
                                  Navigator.pushNamed(context, "/login");
                                },
                              ),
                              Text(
                                locText(context, key: "groups"),
                                style: TextStyle(fontSize: 26),
                              ),
                              IconButton(
                                icon: Icon(FontAwesomeIcons.download),
                                color: Colors.black,
                                onPressed: () {
                                  Navigator.pushNamed(context, "/import");
                                },
                              ),
                            ]),
                        Expanded(
                          child: BlocBuilder(
                              bloc: BlocProvider.of<GroupsBloc>(context),
                              builder:
                                  (BuildContext context, GroupState state) {
                                if (state is LoadedGroupState) {
                                  List<PojoGroup> groups = state.groups;
                                  return new ListView.builder(
                                      itemCount: groups.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return GroupItemWidget(
                                            group: groups[index]);
                                      });
                                } else if (state is WaitingGroupState) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                return Center(
                                    child: Text(locText(context,
                                        key: "info_something_went_wrong")));
                              }),
                        ),
                        BlocBuilder(
                            bloc: BlocProvider.of<SelectedBloc>(context),
                            builder:
                                (BuildContext context, SelectedState state) {
                              if (state is SelectionReadyState &&
                                  state.group != null) {
                                return Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: SizedBox(
                                      height: 50,
                                      width: double.maxFinite,
                                      child: RaisedButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0)),
                                          child: Text("Új felelés",
                                              style: TextStyle(fontSize: 24)),
                                          onPressed: () {
                                            if (SelectedBloc().group != null) {}
                                            Navigator.pushNamed(
                                                context, "/absent",
                                                arguments: state.group);
                                          })),
                                );
                              }
                              return Center();
                            })
                      ],
                    ),
                    onRefresh: () async => BlocProvider.of<GroupsBloc>(context)
                        .dispatch(ReloadGroupEvent()) //await getData()
                    ))));
  }
}
