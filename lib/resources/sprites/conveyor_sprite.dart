
import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';

import '../../game_parts/game.dart';

class ConveyorSprite extends SpriteComponent {


  // creates a component that renders the crate.png sprite, with size 16 x 16
  ConveyorSprite({@required double x, @required double y, double width}) : super.fromSprite(width, 50.0, new Sprite("futoszalag.png")){
    this.x = x;
    this.y = y;
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
    if(MyGame.velocityX > 0){
      x += MyGame.velocityX;
    }
  }

  @override
  void render(Canvas canvas) {
    // TODO: implement render
    super.render(canvas);
  }

}