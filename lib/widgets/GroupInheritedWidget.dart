import 'package:dusza2019/pojos/pojo_group.dart';
import 'package:dusza2019/pojos/pojo_student.dart';
import 'package:flutter/cupertino.dart';

class GroupInheritedWidget extends InheritedWidget {
  PojoGroup group;
  PojoStudent student;

  GroupInheritedWidget(Widget child): super();


  void pr(){
    print("group: ${group?.name}");
  }

  static GroupInheritedWidget of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(GroupInheritedWidget);
  }

  @override
  bool updateShouldNotify(GroupInheritedWidget old) =>
      group != old.group || student != old.student;
}
