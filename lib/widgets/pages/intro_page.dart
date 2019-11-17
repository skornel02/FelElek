import 'package:dusza2019/blocs/google_login_bloc.dart';
import 'package:dusza2019/blocs/groups_bloc.dart';
import 'package:dusza2019/managers/felelek_localizations.dart';
import 'package:dusza2019/widgets/login_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import "dart:math" show pi;
import '../../navigation/business_navigator.dart';

class IntroPage extends StatelessWidget {
  static const double angle = pi / 16;
  static const double dy = -86;

  void exitIntro() {
    BusinessNavigator().currentState().pushReplacementNamed('/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[

          Image.asset("assets/images/hatter-02.png",
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.fitHeight,
          ),
          SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      width: 200,
                      height: 200,
                      child: CircleAvatar(
                        backgroundColor: Theme.of(context).backgroundColor,
                        child: Transform.translate(
                          offset: Offset(0, 0),
                          child: Container(
                              decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: new DecorationImage(
                                    fit: BoxFit.fill,
                                    image: AssetImage("assets/images/elek2.png"),
                                  )
                              )
                          ),
                        ),
                      ),
                    ),
                    Text(locText(context, key: "introGreeting"),
                        style: TextStyle(fontSize: 17), textAlign: TextAlign.center),
                    BlocBuilder(
                      bloc: BlocProvider.of<GoogleLoginBloc>(context),
                      builder: (BuildContext context, GoogleLoginState state) {
                        if (state is GoogleLoginSuccessfulState) {
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
                        }
                        return Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Text(
                                locText(context, key: "introLogInToSync"),
                                style: TextStyle(fontSize: 17),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            LoginWidget()
                          ],
                        );
                      },
                    ),

                    RaisedButton(
                      child: Text(locText(context, key: "proceed")),
                      onPressed: () {
                        exitIntro();
                      },
                    )
                  ],
                ),
              )),

        ],
      )
    );
  }
}
