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

class IntroPage extends StatefulWidget {
  IntroPage({Key key}) : super(key: key);

  @override
  _IntroPage createState() => _IntroPage();
}

class _IntroPage extends State<IntroPage>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  static const double angle = pi / 16;

  static const double dy = -86;

  bool joinLater = false;

  bool processingDeepLink = false;

  int groupId;

  var slides;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Widget introPageBuilder(Widget title, Widget description,
      {int backgroundIndex}) {
    return SingleChildScrollView(
      child: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery
                .of(context)
                .size
                .height, //-  MediaQuery.of(context).padding.top,
            //  width: MediaQuery.of(context).size.width,
            /*  child: SvgPicture.asset(
              "assets/images/hatter-$backgroundIndex.svg",
              // semanticsLabel: 'Acme Logo'
              fit: BoxFit.fitHeight,

              height: MediaQuery.of(context).size.height -  MediaQuery.of(context).padding.top,
              width: MediaQuery.of(context).size.width,
            ),
            */
          ),
          Container(
            height: MediaQuery
                .of(context)
                .size
                .height -
                MediaQuery
                    .of(context)
                    .padding
                    .top,
            //    width: MediaQuery.of(context).size.width,
            child: Center(
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      SafeArea(
                        child: Container(
                          // height: 100,
                          // child: NotebookBackgroundWidget()
                        ),
                      ),
                      Center(child: title)
                    ],
                  ),
                  // description,
                  Expanded(child: description)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

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
                  child: Text("Elek orcája"),
                  height: 80,
                ),
                Text(
                    "Üdv! Én vagyok Elek, a saját felelés-asszisztensed. Kezdjük is el!",
                    textAlign: TextAlign.center),
                BlocBuilder(
                  bloc: BlocProvider.of<GoogleLoginBloc>(context),
                  builder: (BuildContext context, GoogleLoginState state)  {
                    if (state is GoogleLoginSuccessfulState) {
                      //Update cache
                      BlocProvider.of<GroupsBloc>(context)
                          .dispatch(SyncWithGoogleDriveEvent(state.accessToken));
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(state.email, style: TextStyle(fontSize: 18),),
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
                          Text(
                            "A szinkronizációhoz jelentkezzen be:",
                            textAlign: TextAlign.center,
                          ),
                          LoginWidget()
                        ],
                      );
                    }
                  },
                ),
                Text("Az importáláshoz pedig nyomd meg ezt a gombot",
                    textAlign: TextAlign.center),
                RaisedButton(
                  child: Text("IMPORTÁLÁS"),
                  onPressed: () {},
                ),
                RaisedButton(
                  child: Text("Tovább"),
                  onPressed: () {
                    Navigator.pushNamed(context, "/");
                  },
                )
              ],
            ),
          )),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}
