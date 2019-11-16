import 'dart:ui';

import 'package:dusza2019/game_parts/student_sprite.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class MyGame extends Game with TapDetector {

  Size screenSize;

  List<StudentSprite> students;
  StudentSprite student;
  StudentSprite student2;

  MyGame(this.screenSize){

    students = [StudentSprite(x: 10, y: screenSize.height/2 + 20, vel_x: 0.2), StudentSprite(x: 50, y: screenSize.height/2 - 20, vel_x: 0.09), ];//x: - screenSize.width - 10, y: screenSize.height/2, vel_x: 0.1)];

    students = [
      StudentSprite(x: 10, y: 100, vel_x: 0.50),
      StudentSprite(x: 10, y: 300, vel_x: 0.50),
      //StudentSprite(x: 10, y: screenSize.height/2 + 20, vel_x: 0.2)
    ];//x: - screenSize.width - 10, y: screenSize.height/2, vel_x: 0.1)];
   // student = students[0];
   // student2 = students[1];
    init();
  }

  void init() async {
    resize(await Flame.util.initialDimensions());
  }

  @override
  void onTapDown(TapDownDetails details) {
    print("Player tap down on ${details.globalPosition.dx} - ${details
        .globalPosition.dy}");

    students.add(StudentSprite(x: 200, y: 300, vel_x: 0.09));
  }

  @override
  void onTapUp(TapUpDetails details) {
    print("Player tap up on ${details.globalPosition.dx} - ${details
        .globalPosition.dy}");
  }

  @override
  void update(double t) {
    /*
    for(int i = 0; i < students.length; i++){
      students[i].x += students[i].vel_x;
    }
    */


    if(students[students.length-1].x >= 10 && students[students.length-1].x < screenSize.width + 50){
      students.add(StudentSprite(x: - 70, y: screenSize.height/2, vel_x: 0.8));//x: - screenSize.width - 10, y: screenSize.height/2, vel_x: 0.1)];
      print("boi: ${students}");
    }


    for(int i = 0; i < students.length; i++){
      if(students[i].x >= screenSize.width+50 ){

      }
    }


    students.forEach((StudentSprite s) => s.update(t));
  }

  @override
  void render(Canvas canvas) {
    /*
    for(int i = 0; i < students.length; i++){
     // students[i].x_position += students[i].x_velocity;

      students[i].render(canvas);
    }
  */
   // students.forEach((StudentSprite s) => s.render(canvas));

   // canvas.save();
    students.forEach((StudentSprite s) {
      s.render(canvas);
      canvas.restore();
      canvas.save();
    });
  }

}