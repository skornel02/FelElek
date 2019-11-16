import 'package:dusza2019/blocs/groups_bloc.dart';
import 'package:dusza2019/blocs/path_bloc.dart';
import 'package:dusza2019/other/hazizz_localizations.dart';
import 'package:dusza2019/pojos/pojo_group.dart';
import 'package:dusza2019/widgets/dialogs/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../items/group_item_widget.dart';

class GroupsPage extends StatefulWidget {
  GroupsPage({Key key}) : super(key: key);

  @override
  _GroupsPage createState() => _GroupsPage();
}

class _GroupsPage extends State<GroupsPage> with AutomaticKeepAliveClientMixin {
  PojoGroup selectedGroup;

  _GroupsPage();

  @override
  Widget build(BuildContext context) {
    return Container(
      //LogConsoleOnShake(
      // tag: "group",
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
            child: Icon(FontAwesomeIcons.plus),
            onPressed: () {
              showAddGroupDialog(context);
            },
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
                              Navigator.pushNamed(context, "/login");},
                          ),
                          Text(
                            locText(context, key: "groups"),
                            style: TextStyle(fontSize: 26),
                          ),
                          IconButton(
                            icon: Icon(FontAwesomeIcons.asterisk),
                            color: Colors.transparent,
                            onPressed: () {},
                          ),
                        ]),
                    Expanded(
                      child: BlocBuilder(
                          bloc: BlocProvider.of<GroupsBloc>(context),
                          builder: (BuildContext context, GroupState state) {
                            print("STATE: ${state.toString()}");
                            if (state is LoadedGroupState) {
                              List<PojoGroup> groups = state.groups;
                              return new ListView.builder(
                                  // physics: BouncingScrollPhysics(),
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
                    RaisedButton(
                      child: Text("Új felelés"),
                      onPressed: () {
                        if (PathsBloc().group != null) {}
                        Navigator.pushNamed(context, "/absent",
                            arguments: PathsBloc().group);
                      },
                    ),
                  ],
                ),
                onRefresh: () async => BlocProvider.of<GroupsBloc>(context)
                    .dispatch(ReloadGroupEvent()) //await getData()
                ),
          )),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
