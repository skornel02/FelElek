import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pojo_student.g.dart';


@JsonSerializable()
class PojoStudent{

  String name;

  int id;

  List<int> grades;

  bool isAbsent;

  PojoStudent({@required this.name, @required this.id, @required this.grades, @required this.isAbsent});


  @override
  factory PojoStudent.fromJson(Map<String, dynamic> json) =>
      _$PojoStudentFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PojoStudentToJson(this);

}