import 'dart:async';
import 'dart:math' as math;
import 'dart:math';
import 'package:dusza2019/other/app_state_manager.dart';
import 'package:dusza2019/other/hazizz_localizations.dart';
import 'package:dusza2019/other/hazizz_theme.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class MainTabHosterPage extends StatefulWidget {

//  MainTabBlocs mainTabBlocs;

  MainTabHosterPage({Key key}) : super(key: key){
   // mainTabBlocs = MainTabBlocs();
  }

  @override
  _MainTabHosterPage createState() => _MainTabHosterPage();

}

class _MainTabHosterPage extends State<MainTabHosterPage> with TickerProviderStateMixin{

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


  TabController _tabController;

  Widget tasksTabPage = Container();

  String displayName = "name";

  bool processingDeepLink = false;

  bool isDark = false;

  bool doEvent = false;

  void _handleTabSelection() {
    if(_tabController.index == 2){
    }
    setState(() {

    });
  }

  AnimationController animationController;

  Animation animation;

  @override
  void initState() {

    _tabController = new TabController(length: 3, vsync: this, initialIndex: 0); //widget.mainTabBlocs.initialIndex

    _tabController.addListener(_handleTabSelection);

    HazizzTheme.isDark().then((value){
      setState(() {
        isDark = value;
      });
    });

    animationController = new AnimationController(
      vsync: this,
      duration: new Duration(milliseconds: 2300 + Random().nextInt(500) ),
    );

    animationController.forward();


    animation =  new Tween(
        begin: 0.0,
        end: 500.0//-math.pi/50,// -math.pi/6
    ).animate(new CurvedAnimation(
      parent: animationController,
      curve: Curves.elasticOut,
      reverseCurve: Curves.elasticOut,
    ));

    if(Random().nextInt(3) == 1){
      doEvent = true;
    }

    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  DateTime currentBackPressTime;

  Future<bool> onWillPop(){
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(locText(context, key: "press_again_to_exit")),
        duration: Duration(seconds: 3),
      ));

      return Future.value(false);
    }
    return Future.value(true);
  }


  @override
  Widget build(BuildContext context) {

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return WillPopScope(
        onWillPop: onWillPop,
        child: Stack(
          children: <Widget>[

            Scaffold(
              key: _scaffoldKey,
              // backgroundColor: widget.color,
              appBar: AppBar(
                leading: IconButton(
                    icon: Icon(FontAwesomeIcons.bars),
                    onPressed: () => _scaffoldKey.currentState.openDrawer()
                ),
                title: Padding(
                  padding: const EdgeInsets.only(top: 4, ),
                  child: Text(locText(context, key: "hazizz"), style: TextStyle(fontWeight: FontWeight.w700, fontFamily: "Nunito", fontSize: 21),),
                ),

                bottom: TabBar(
                    controller: _tabController,
                    tabs: [
                      Tab(text: "1", icon: Icon(FontAwesomeIcons.bookOpen),),
                      Tab(text: "2", icon: Icon(FontAwesomeIcons.calendarAlt)),
                      Tab(text: "4", icon: Icon(FontAwesomeIcons.calendarAlt)),
                    ]
                ),
              ),
              body:
              TabBarView(
                  controller: _tabController,
                  children: [
                    Container(color: Colors.green,), Container(color: Colors.red,), Container(color: Colors.blue,),
                    // tasksTabPage, tasksTabPage, tasksTabPage
                  ]
              ),

              drawer: SizedBox(
                width: 270,
                child: Drawer(


                  child: Column(
                    children: <Widget>[
                      UserAccountsDrawerHeader(

                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColorDark,
                        ),
                        accountName: Text("Senkiházi"),
                        accountEmail: Text(""),
                      ),

                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            //   Divider(),
                            Hero(
                              tag: "settings",
                              child: ListTile(
                                  onTap: (){
                                    Navigator.pop(context);
                                    Navigator.pushNamed(context, "/settings");
                                  },
                                  leading: Icon(FontAwesomeIcons.cog),
                                  title: Text(locText(context, key: "settings"))),
                            ),
                            Row(
                              children: [
                                Expanded(child:
                                ListTile(
                                  leading:  Transform.rotate(
                                      angle: -math.pi,
                                      child:  Icon(FontAwesomeIcons.signOutAlt)
                                  ),
                                  title: Text(locText(context, key: "textview_logout_drawer")),
                                  onTap: () async {
                                    await AppState.logout();
                                  },
                                ),),
                                Padding(
                                  padding: const EdgeInsets.only(right: 4, left: 10),
                                  child: Builder(
                                      builder:(context){
                                        Icon icon = isDark?
                                        Icon(FontAwesomeIcons.solidSun, color: Colors.orangeAccent, size: 43):
                                        Icon(FontAwesomeIcons.solidMoon, color: Colors.black45, size: 39);

                                        return IconButton(
                                          iconSize: 50,
                                          icon: icon,
                                          onPressed: () async {
                                            if(await HazizzTheme.isDark()) {
                                              DynamicTheme.of(context).setThemeData(HazizzTheme.lightThemeData);
                                              await HazizzTheme.setLight();
                                              isDark = false;
                                            }else{
                                              DynamicTheme.of(context).setThemeData(HazizzTheme.darkThemeData);
                                              await HazizzTheme.setDark();
                                              isDark = true;
                                            }
                                          },
                                        );
                                      }
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        )
    );
  }
}
