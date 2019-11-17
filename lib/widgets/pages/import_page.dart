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

class ImportPage extends StatelessWidget {
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
                Text(locText(context, key: "importTitle"), style: TextStyle(fontSize: 26)),
                IconButton(
                  icon: Icon(FontAwesomeIcons.fileImport),
                  color: Colors.transparent,
                  onPressed: () {},
                ),
              ]),
        SizedBox(height: 20),
        Container(
          child: Column(
              children: <Widget>[
                Text(locText(context, key: "csvTitle"), style: TextStyle(fontSize: 22)),
                Text(locText(context, key: "csvDescription")),
                RaisedButton(
                  child: Text(locText(context, key: "import").toUpperCase()),
                  onPressed: () {
                    BlocProvider.of<GroupsBloc>(context).dispatch(ImportCSVEvent());
                  },
                ),
              ],
          ),
        ),
        SizedBox(height: 20),
        Text(locText(context, key: "sheetsTitle"), style: TextStyle(fontSize: 22)),
        Container(
          child: Column(
              children: <Widget>[
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
                          )
                        ],
                      );
                    } else {
                      return LoginWidget();
                    }
                  },
                )
              ],
          )
        )
      ],
    ),
            )));
  }
}
