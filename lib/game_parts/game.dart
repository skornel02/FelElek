import 'dart:math';
import 'dart:ui';

import 'package:dusza2019/game_parts/student_sprite.dart';
import 'package:dusza2019/navigation/business_navigator.dart';
import 'package:dusza2019/other/spinner_data.dart';
import 'package:dusza2019/other/winner_data.dart';
import 'package:dusza2019/pojos/pojo_student.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flame/time.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'claw_sprite.dart';
import 'conveyor_sprite.dart';

class MyGame extends Game with TapDetector {

  bool poped = false;

  double lastTime = 0;

  double deltaTime = 0;


  List<PojoStudent> pojoStudents;

  SpinnerData spinnerData;

  static double acc_x = 0.0;
  static double vel_x = 4;

  int counter = 1;

  Size screenSize;

  final countdown = Timer(5);


  List<StudentSprite> students;

  StudentSprite winnerStudent;
  bool winnerStudentSpawned = false;

  List<ConveyorSprite> conveyors;


  ClawSprite claw;


  MyGame({this.screenSize, @required this.spinnerData}){
    acc_x = 0.0;
    vel_x = 4;
    vel_x = screenSize.width / 100;

    pojoStudents = spinnerData.students;

    students = [];

    conveyors = [ConveyorSprite(x: 0, y: screenSize.height/2 + 40, width: screenSize.width),
                 ConveyorSprite(x: -screenSize.width, y: screenSize.height/2 + 40, width: screenSize.width),
    ];


    claw = ClawSprite(x: screenSize.width/2 - 42, y: -screenSize.height + 200 );

    init();
  }

  void init() async {
    countdown.start();
    resize(await Flame.util.initialDimensions());
  }

  void spawnWinner(){


    winnerStudent = StudentSprite(x: - 70, y: screenSize.height/2, rand: pojoStudents[counter % pojoStudents.length].id % 100);
    students.add(winnerStudent);//x: - screenSize.width - 10, y: screenSize.height/2, vel_x: 0.1)];
    winnerStudentSpawned = true;
    counter++;
  }

  void addStudent(){
    students.add(StudentSprite(x: - 70, y: screenSize.height/2, rand: pojoStudents[ counter % pojoStudents.length].id % 100),);//x: - screenSize.width - 10, y: screenSize.height/2, vel_x: 0.1)];
    counter++;
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
    deltaTime = t;

    for(ConveyorSprite c in conveyors){
      c.update(t);
      if(c.x > screenSize.width){
        c.x = -screenSize.width;
      }
    }

    if(winnerStudentSpawned){
      double distance = screenSize.width/2 - (winnerStudent.x + 20);
      print(screenSize.width/2 - winnerStudent.x);
      if(winnerStudent.x >= screenSize.width/2 * 0.5){
        acc_x = (screenSize.width/2 - winnerStudent.x)/ vel_x / deltaTime;
        acc_x = (distance) / 100000 / deltaTime;
        if (acc_x < 0)
          acc_x = -1;
      }
    }

    if(vel_x > 0 && acc_x != -1){
      vel_x -= acc_x;
    }else{
      vel_x = 0;
      //Megállt
      double distance = screenSize.width/2 - (winnerStudent.x + 20);

      if(!poped){

        WinnerData winner = WinnerData(student: spinnerData.winner, imgPath: winnerStudent.imgPath);
        BusinessNavigator().currentState().popAndPushNamed("/absent/spinner/chosen_student", arguments: winner);
        
        poped = true;
      }
    }

    countdown.update(t);


    if(students.isEmpty || students[students.length-1].x >= 10 && students[students.length-1].x < screenSize.width + 50){


      if(countdown.isFinished() && !winnerStudentSpawned){

        spawnWinner();

      }
        // slowing down
      //  vel_x -= acc_x;
      else{
        addStudent();
      }

    }

    for(int i = 0; i < students.length; i++){
      if(students[i].x >= screenSize.width+50 ){

      }
    }
    students.forEach((StudentSprite s) => s.update(t));

    lastTime = t;
  }

  @override
  void render(Canvas canvas) {

    claw.render(canvas);
    canvas.restore();
    canvas.save();

    conveyors.forEach((ConveyorSprite c) {
      c.render(canvas);
      canvas.restore();
      canvas.save();
    });

    students.forEach((StudentSprite s) {
      s.render(canvas);
      canvas.restore();
      canvas.save();
    });
  }
}