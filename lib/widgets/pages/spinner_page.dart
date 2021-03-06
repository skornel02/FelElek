import 'package:dusza2019/game_parts/game.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class SpinnerPage extends StatelessWidget {
  final spinnerData;

  SpinnerPage({Key key, this.spinnerData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(body: SafeArea(child: Container(
        child: Builder(
          builder: (context) {
            Game game = MyGame(
                screenSize: MediaQuery.of(context).size,
                spinnerData: spinnerData);
            return game.widget;
          },
        ),
      ))),
    );
  }
}
