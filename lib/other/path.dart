import 'package:dusza2019/pojos/pojo_group.dart';
import 'package:dusza2019/pojos/pojo_student.dart';

class Path{
  PojoGroup group;

  PojoStudent student;

  static final Path _singleton = new Path._internal();
  factory Path() {

    return _singleton;
  }
  Path._internal();
}