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

    void nextPage(){
      _tabController.animateTo(_tabController.index+1,  duration: Duration(milliseconds:  2000));
    }


    EdgeInsets padding = MediaQuery.of(context).padding;
    double height = MediaQuery.of(context).size.height;

    double height1 = height - padding.top - padding.bottom;

    // 5 db
    List<Color> gradientColor = [HazizzTheme.blue, Colors.green, Colors.yellow,  Colors.red, HazizzTheme.blue];

    slides = [
      Builder(
        builder: (context){
          Widget googleSignInButtonWidget = GoogleSignInButton(
            onPressed: (){
              googleLoginBloc.dispatch(GoogleLoginButtonPressedEvent());
            },
          );

          return BlocBuilder(
              bloc: googleLoginBloc,
              builder: (context, state){

                bool _isLoading;

                print("log: ggoogle: $state");

                if(state is GoogleLoginSuccessfulState){
                  _isLoading = false;


                  AppState.mainAppPartStartProcedure();
                  nextPage();
                }
                else if(state is GoogleLoginWaitingState){
                  _isLoading = true;

                }else{
                  _isLoading = false;
                }

                return LoadingDialog(
                  child: introPageBuilder(Transform.translate(
                    offset: const Offset(0.0, -30.0),
                    child: Container(
                      // padding: const EdgeInsets.all(8.0),
                      //  color: const Color(0xFF7F7F7F),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 0.0),
                        child: Image.asset(
                          'assets/images/Logo.png',
                        ),
                      ),
                    ),
                  ), Column(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8),
                        child: Center(
                            child: Text(locText(context, key: "hazizz_intro"), style: TextStyle(fontSize: 19), textAlign: TextAlign.center)
                        ),
                      ),

                    ),

                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Column(
                          children: <Widget>[
                            googleSignInButtonWidget
                          ],
                        ),
                      ),
                    )
                  ],),
                    backgroundIndex: 1,
                  ),
                  show: _isLoading,
                );
              }

          );
        },
      ),

      introPageBuilder(Padding(
        padding: const EdgeInsets.only(top: 44.0),
        child: Text(locText(context, key: "about_group_title"), style: TextStyle(fontSize: 40, fontWeight: FontWeight.w800), textAlign: TextAlign.center,),
      ),
          Padding(
            padding: const EdgeInsets.only(top: 60.0, left: 8, right:8),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[

                // Text(locText(context, key: "login"), style: TextStyle(fontSize: 40, fontWeight: FontWeight.w800, color: HazizzTheme.blue, ),),

                Text(locText(context, key: "about_group_description1"), style: TextStyle(fontSize: 20), textAlign: TextAlign.center,),


                Text(locText(context, key: "about_group_description2"), style: TextStyle(fontSize: 20), textAlign: TextAlign.center,),

                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[


                      FloatingActionButton(child: Icon(FontAwesomeIcons.chevronRight),
                        onPressed: (){
                          nextPage();
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),

          backgroundIndex: 2
      ),

    ];

    return WillPopScope(
      onWillPop: _onWillPop,

      child: Scaffold(
        //   resizeToAvoidBottomPadding: false,
        body: SafeArea(
          child: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            controller: _tabController,
            children: slides,
          ),
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    return await false;
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}


