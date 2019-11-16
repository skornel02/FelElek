import 'dart:async';

import 'package:dusza2019/blocs/google_login_bloc.dart';
import 'package:dusza2019/blocs/groups_bloc.dart';
import 'package:dusza2019/widgets/login_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import "dart:math" show pi;

import '../../other/app_state_manager.dart';
import '../../navigation/business_navigator.dart';
import '../dialogs/loading_dialog.dart';

class IntroPage extends StatelessWidget {
  static const double angle = pi / 16;

  static const double dy = -86;

  bool joinLater = false;

  bool processingDeepLink = false;

  int groupId;

  var slides;

  void exitIntro() {
    BusinessNavigator().currentState().pushReplacementNamed(
          '/',
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              width: 200,
              height: 200,
              child: CircleAvatar(
                child: Transform.translate(
                  offset: Offset(0, 0),
                  child: Container(
                      decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          image: new DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage("assets/images/elek.png"),
                          ))),
                ),
              ),
            ),
            Text(
                "Üdv! Én vagyok Elek, a saját felelés-asszisztensed. Kezdjük is el!",
                style: TextStyle(fontSize: 17),
                textAlign: TextAlign.center),
            BlocBuilder(
              bloc: BlocProvider.of<GoogleLoginBloc>(context),
              builder: (BuildContext context, GoogleLoginState state) {
                if (state is GoogleLoginSuccessfulState) {
                  //Update cache
                  BlocProvider.of<GroupsBloc>(context)
                      .dispatch(SyncWithGoogleDriveEvent(state.accessToken));
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        state.email,
                        style: TextStyle(fontSize: 18),
                      ),
                      IconButton(
                        icon: Icon(FontAwesomeIcons.signOutAlt),
                        onPressed: () {
                          BlocProvider.of<GoogleLoginBloc>(context)
                              .dispatch(GoogleLoginResetEvent());
                        },
                      )
                    ],
                  );
                } else {
                  return Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Text(
                          "A szinkronizációhoz jelentkezzen be:",
                          style: TextStyle(fontSize: 17),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      LoginWidget()
                    ],
                  );
                }
              },
            ),
            Text("Az importáláshoz pedig nyomd meg ezt a gombot",
                style: TextStyle(fontSize: 17), textAlign: TextAlign.center),
            RaisedButton(
              child: Text("IMPORTÁLÁS"),
              onPressed: () {},
            ),
            RaisedButton(
              child: Text("Tovább"),
              onPressed: () {
                exitIntro();
              },
            )
          ],
        ),
      )),
    );
  }
}
