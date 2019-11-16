
import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';

import 'game.dart';

class StudentSprite extends SpriteComponent {

  bool slowingDown = false;

  String imgPath;

  // creates a component that renders the crate.png sprite, with size 16 x 16
  StudentSprite({@required double x, @required double y, int rand = 1}) : super.fromSprite(100.0, 100.0, new Sprite("ember-${rand}.png")){
    this.x = x;
    this.y = y;
    imgPath = "assets/images/ember-${rand}.png";
  }

  void reuse(){

  }

  @override
  void resize(Size size) {
    // we don't need to set the x and y in the constructor, we can set then here
    this.x = (size.width - this.width)/ 2;
    this.y = (size.height - this.height) / 2;
  }

  @override
  void update(double t) {

    if(MyGame.vel_x > 0){
      x += MyGame.vel_x;
    }


  }

  @override
  void render(Canvas canvas) {
    // TODO: implement render
    super.render(canvas);
  }

}