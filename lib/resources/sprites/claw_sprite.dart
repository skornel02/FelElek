import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';

class ClawSprite extends SpriteComponent {
  bool timeToPick = false;

  double movePosX = 0;

  double oldY;

  // creates a component that renders the crate.png sprite, with size 16 x 16
  ClawSprite({@required double x, @required double y})
      : super.fromSprite(84, 750, new Sprite("claw3.png")) {
    this.x = x;
    this.y = y;
    oldY = y;
  }

  @override
  void resize(Size size) {
    // we don't need to set the x and y in the constructor, we can set then here
    this.x = (size.width - this.width) / 2;
    this.y = (size.height - this.height) / 2;
  }

  @override
  void update(double t) {}

  @override
  void render(Canvas canvas) {
    // TODO: implement render
    super.render(canvas);
  }
}
