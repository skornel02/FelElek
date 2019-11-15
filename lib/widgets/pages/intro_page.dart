import 'dart:async';

import 'package:dusza2019/blocs/google_login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:toast/toast.dart';

import "dart:math" show pi;

import '../../other/app_state_manager.dart';
import '../../navigation/business_navigator.dart';
import '../../other/hazizz_localizations.dart';
import '../../other/hazizz_theme.dart';
import '../dialogs/loading_dialog.dart';

class IntroPage extends StatefulWidget {

  IntroPage({Key key}) : super(key: key);

  @override
  _IntroPage createState() => _IntroPage();
}

class _IntroPage extends State<IntroPage> with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin{
  static const double angle = pi / 16;

  static const double dy = -86;

  TabController _tabController;
  
  
  GoogleLoginBloc googleLoginBloc;

  //List<Widget> slides;

  /*
  void _handleTabSelection() {
    setState(() {

    });
  }
  */

  bool joinLater = false;

  bool processingDeepLink = false;

  int groupId;





  var slides;

  @override
  void initState() {

    googleLoginBloc = GoogleLoginBloc();
    _tabController = new TabController(length: 2, vsync: this);
    //  _tabController.addListener(_handleTabSelection);
    super.initState();
  }



  @override
  void dispose() {
    // TODO: implement dispose

    googleLoginBloc.reset();

    //  LoginBlocs().googleLoginBloc().dispose();
    super.dispose();
  }

  Widget introPageBuilder(Widget title, Widget description, {int backgroundIndex}){
    return SingleChildScrollView(
      child: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height, //-  MediaQuery.of(context).padding.top,
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
            height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top,
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

  void exitIntro(){

    BusinessNavigator().currentState().pushReplacementNamed('/',);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left:20, right:20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[

              Container(
                child: Text("Elek orcája"),
                height: 80,
              ),
              Text("Üdv! Én vagyok Elek, a saját felelés-asszisztensed. Kezdjük is el!", textAlign: TextAlign.center),

              Text("A szinkronizációhoz nyomd meg a gombot:", textAlign: TextAlign.center,),


              Builder(
                builder: (context){
                  Widget googleSignInButtonWidget = GoogleSignInButton(
                    onPressed: (){
                      googleLoginBloc.dispatch(GoogleLoginButtonPressedEvent());
                    },
                  );

                  return BlocListener(
                    listener: (context, state){
                      print("log: ggoogle: $state");

                      if(state is GoogleLoginSuccessfulState){
                        AppState.proceedToApp(context);
                      }
                      else if(state is GoogleLoginWaitingState){

                      }else{
                      }
                    },
                      bloc: googleLoginBloc,
                      child: LoadingDialog(
                        show: false,
                          child: Padding(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: Column(
                                children: <Widget>[
                                  googleSignInButtonWidget
                                ],
                              )))
                  );
                },
              ),

              Text("Az importáláshoz pedig nyomd meg ezt a gombot", textAlign: TextAlign.center),

              RaisedButton(
                child: Text("IMPORTÁLÁS"),
                onPressed: (){

                },
              )

            ],
          ),
        )
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}


