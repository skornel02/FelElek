
import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';

import 'game.dart';

String a(int n){
  if(n <= 9){
    return "0$n";
  }
  return n.toString();
}

class StudentSprite extends SpriteComponent {

  bool slowingDown = false;


  Color color;
  // creates a component that renders the crate.png sprite, with size 16 x 16
  StudentSprite({@required double x, @required double y, this.color, int rand = 1}) : super.fromSprite(100.0, 100.0, new Sprite("ember-${a(rand)}.png")){
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