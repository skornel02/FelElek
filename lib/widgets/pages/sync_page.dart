import 'package:dusza2019/blocs/google_login_bloc.dart';
import 'package:dusza2019/blocs/groups_bloc.dart';
import 'package:dusza2019/managers/felelek_localizations.dart';
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
            child: Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: <Widget>[
          SizedBox(height: 20),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(FontAwesomeIcons.arrowLeft),
                  color: Colors.black,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Text(locText(context, key: "syncTitle"), style: TextStyle(fontSize: 26)),
                IconButton(
                  icon: Icon(FontAwesomeIcons.fileImport),
                  color: Colors.transparent,
                  onPressed: () {},
                ),
              ]),
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
                    BlocBuilder(
                      bloc: BlocProvider.of<GroupsBloc>(context),
                      builder: (BuildContext context, _) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(locText(context, key: "lastEdit") + ": ",
                                    style: TextStyle(fontSize: 18)),
                                Expanded(
                                  child: FutureBuilder<SharedPreferences>(
                                    future: SharedPreferences.getInstance(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<SharedPreferences>
                                            snapshot) {
                                      switch (snapshot.connectionState) {
                                        case ConnectionState.none:
                                        case ConnectionState.waiting:
                                          return Center(
                                              child: CircularProgressIndicator());
                                        default:
                                          String datetimeString = snapshot.data
                                              .getString("DBLastUpdated");
                                          if (datetimeString != null) {
                                            DateTime datetime =
                                                DateTime.parse(datetimeString);
                                            return new Text(
                                                DateFormat('yyyy-MM-dd – kk:mm')
                                                    .format(datetime),
                                                style: TextStyle(fontSize: 16));
                                          }
                                      }
                                      return new Text("-",
                                          style: TextStyle(fontSize: 16));
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(locText(context, key: "lastSync") + ": ",
                                    style: TextStyle(fontSize: 18)),
                                Expanded(
                                  child: FutureBuilder<SharedPreferences>(
                                    future: SharedPreferences.getInstance(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<SharedPreferences>
                                            snapshot) {
                                      switch (snapshot.connectionState) {
                                        case ConnectionState.none:
                                        case ConnectionState.waiting:
                                          return Center(
                                              child: CircularProgressIndicator());
                                        default:
                                          String datetimeString = snapshot.data
                                              .getString("GDriveLastSync");
                                          if (datetimeString != null) {
                                            DateTime datetime =
                                                DateTime.parse(datetimeString);
                                            return new Text(
                                                DateFormat('yyyy-MM-dd – kk:mm')
                                                    .format(datetime),
                                                style: TextStyle(fontSize: 16));
                                          }
                                      }
                                      return new Text("-",
                                          style: TextStyle(fontSize: 16));
                                    },
                                  ),
                                ),
                              ],
                            )
                          ],
                        );
                      },
                    ),
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
      ),
    )));
  }
}
