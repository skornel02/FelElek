import 'dart:math';

import 'package:dusza2019/blocs/groups_bloc.dart';
import 'package:dusza2019/pojos/pojo_group.dart';
import 'package:dusza2019/pojos/pojo_student.dart';
import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StudentSprite extends SpriteComponent {

  double vel_x;
  Color color;
  // creates a component that renders the crate.png sprite, with size 16 x 16
  StudentSprite({@required double x, @required double y, this.vel_x = 0.05, this.color}){
    this.x = x;
    this.y = y;

    Random r = Random();

    sprite = Sprite("emberek${r.nextInt(40)}.png", height: 100, width: 100);

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
    x += vel_x;
  }

  @override
  void render(Canvas canvas) {
    // TODO: implement render
    super.render(canvas);
  }

}