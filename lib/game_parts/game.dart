import 'dart:math';
import 'dart:ui';

import 'package:dusza2019/game_parts/student_sprite.dart';
import 'package:dusza2019/navigation/business_navigator.dart';
import 'package:dusza2019/pojos/pojo_student.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flame/time.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'conveyor_sprite.dart';

class MyGame extends Game with TapDetector {

  List<PojoStudent> pojoStudents;


  static double acc_x = 0.01;
  static double vel_x = 2;


  Size screenSize;

  final countdown = Timer(20);


  List<StudentSprite> students;
  StudentSprite student;
  StudentSprite student2;

  ConveyorSprite conveyor;

  MyGame({this.screenSize, this.pojoStudents}){

    acc_x = 0.01;
    vel_x = 2;

    students = [
      StudentSprite(x: 10, y: 100),
      StudentSprite(x: 10, y: 300),
    ];


    conveyor = ConveyorSprite(x: 0, y: screenSize.height/2 + 20, width: 500);

    init();
  }

  void init() async {
    countdown.start();
    resize(await Flame.util.initialDimensions());
  }

  void addStudent(){
    Random r = Random();
    students.add(StudentSprite(x: - 70, y: screenSize.height/2, rand: r.nextInt(99)+1),);//x: - screenSize.width - 10, y: screenSize.height/2, vel_x: 0.1)];

  }

  @override
  void onTapDown(TapDownDetails details) {
    print("Player tap down on ${details.globalPosition.dx} - ${details
        .globalPosition.dy}");

  }

  @override
  void onTapUp(TapUpDetails details) {
    print("Player tap up on ${details.globalPosition.dx} - ${details
        .globalPosition.dy}");
  }

  @override
  void update(double t) {

    if(vel_x <= 0){
     // BusinessNavigator().currentState().pop();
    }

    countdown.update(t);

    if(countdown.isFinished()){
      // slowing down
      vel_x -= acc_x;
    }


    if(students[students.length-1].x >= 10 && students[students.length-1].x < screenSize.width + 50){
      addStudent();
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

    conveyor.render(canvas);
    canvas.restore();
    canvas.save();

    students.forEach((StudentSprite s) {
      s.render(canvas);
      canvas.restore();
      canvas.save();
    });
  }
}