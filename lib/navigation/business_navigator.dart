
import 'package:flutter/widgets.dart';

class BusinessNavigator{


  static final BusinessNavigator _singleton = new BusinessNavigator._internal();
  factory BusinessNavigator() {
    return _singleton;
  }
  BusinessNavigator._internal();


  final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();


  NavigatorState currentState() {
    return navigatorKey.currentState;
  }
}

/*

AnimationController _controller;

@override
void initState() {
  super.initState();
  _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 1000));
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: Text("Title")),
    body: AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return GridTile(
          child: Transform.translate(
            child: Transform.translate(
              child: Image.asset(
                MultiPlayerGameLogic().imageProvider(i),
                fit: BoxFit.scaleDown,
              ),
              offset: Offset(0, -1000),
            ),
            offset: Offset(0, 1000),
          ),
        );
      },
    ),
  );
}

* */