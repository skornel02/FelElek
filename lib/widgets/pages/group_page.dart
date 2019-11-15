import 'package:dusza2019/blocs/groups_bloc.dart';
import 'package:dusza2019/other/hazizz_localizations.dart';
import 'package:dusza2019/pojos/pojo_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../group_item_widget.dart';


class GroupsPage extends StatefulWidget {

  GroupsPage({Key key}) : super(key: key);

  @override
  _GroupsPage createState() => _GroupsPage();
}

class _GroupsPage extends State<GroupsPage> with AutomaticKeepAliveClientMixin {

  GroupsBloc groupsBloc = new GroupsBloc();


  _GroupsPage();

  @override
  void initState() {
    groupsBloc.dispatch(FetchGroupEvent());


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(//LogConsoleOnShake(
      // tag: "group",
      child: Scaffold(
       /* appBar: AppBar(
          title: Text(locText(context, key: "groups")),
        ),
        */
        body: SafeArea(
          child: new RefreshIndicator(
            child: Column(
              children: <Widget>[

                Text(locText(context, key: "groups"), style: TextStyle(fontSize: 26),),
                Expanded(
                  child: BlocBuilder(
                      bloc: groupsBloc,
                      builder: (BuildContext context, GroupState state) {
                        if (state is LoadedGroupState) {
                          List<PojoGroup> groups = groupsBloc.groups;
                          return new ListView.builder(
                            // physics: BouncingScrollPhysics(),
                              itemCount: groups.length,
                              itemBuilder: (BuildContext context, int index) {
                                return GroupItemWidget(group: groups[index]);
                              }
                          );
                        } else if (state is WaitingGroupState) {
                          return Center(child: CircularProgressIndicator(),);
                        }
                        return Center(
                            child: Text(locText(context, key: "info_something_went_wrong")));
                      }
                  ),
                ),
                RaisedButton(
                  child: Text("Új felelés"),
                  onPressed: (){

                  },
                ),

              ],
            ),
            onRefresh: () async => groupsBloc.dispatch(FetchGroupEvent()) //await getData()
          ),
        )
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}


