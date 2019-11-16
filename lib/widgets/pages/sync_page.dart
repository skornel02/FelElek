import 'package:dusza2019/blocs/google_login_bloc.dart';
import 'package:dusza2019/blocs/groups_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../login_widget.dart';

class SyncPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(
      children: <Widget>[
        SizedBox(height: 20),
        Text("Szinkronizáció", style: TextStyle(fontSize: 26)),
        SizedBox(height: 20),
        BlocBuilder(
          bloc: BlocProvider.of<GoogleLoginBloc>(context),
          builder: (BuildContext context, GoogleLoginState state) {
            if (state is GoogleLoginSuccessfulState) {
              return Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(state.email, style: TextStyle(fontSize: 18)),
                      IconButton(
                        icon: Icon(FontAwesomeIcons.signOutAlt),
                        onPressed: () {
                          BlocProvider.of<GoogleLoginBloc>(context)
                              .dispatch(GoogleLoginResetEvent());
                        },
                      )
                    ],
                  ),
                  BlocBuilder(bloc: BlocProvider.of<GroupsBloc>(context),
                    builder: (BuildContext context, GroupState) {
                      return Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("Utoljára szerkesztve:",
                                  style: TextStyle(fontSize: 18)),
                              FutureBuilder<SharedPreferences>(
                                future: SharedPreferences.getInstance(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<SharedPreferences> snapshot) {
                                  switch (snapshot.connectionState) {
                                    case ConnectionState.none:
                                    case ConnectionState.waiting:
                                      return Center(child: CircularProgressIndicator());
                                    default:
                                      String datetimeString = snapshot.data.getString("DBLastUpdated");
                                      DateTime datetime =
                                      DateTime.parse(datetimeString);
                                      if (datetimeString != null) {
                                        return new Text(
                                            DateFormat('yyyy-MM-dd – kk:mm')
                                                .format(datetime),
                                            style: TextStyle(fontSize: 16));
                                      }
                                  }
                                  return new Text("-", style: TextStyle(fontSize: 16));
                                },
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("Legutolsó szinkron:",
                                  style: TextStyle(fontSize: 18)),
                              FutureBuilder<SharedPreferences>(
                                future: SharedPreferences.getInstance(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<SharedPreferences> snapshot) {
                                  switch (snapshot.connectionState) {
                                    case ConnectionState.none:
                                    case ConnectionState.waiting:
                                      return Center(child: CircularProgressIndicator());
                                    default:
                                      String datetimeString = snapshot.data.getString("GDriveLastSync");
                                      DateTime datetime =
                                      DateTime.parse(datetimeString);
                                      if (datetimeString != null) {
                                        return new Text(
                                            DateFormat('yyyy-MM-dd – kk:mm')
                                                .format(datetime),
                                            style: TextStyle(fontSize: 16));
                                      }
                                  }
                                  return new Text("-", style: TextStyle(fontSize: 16));
                                },
                              ),
                            ],
                          )
                        ],
                      );
                    },),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(FontAwesomeIcons.sync),
                          color: Colors.blue,
                          onPressed: () {
                            BlocProvider.of<GroupsBloc>(context).dispatch(
                                SyncWithGoogleDriveEvent(state.accessToken));
                          },
                        )
                      ])
                ],
              );
            } else {
              return LoginWidget();
            }
          },
        ),
      ],
    )));
  }
}
