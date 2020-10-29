import 'package:dusza2019/resources/pojos/pojo_student.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'pojo_group.g.dart';

@JsonSerializable()
class PojoGroup {
  String uuId;

  String name;

  List<PojoStudent> students;

  PojoGroup(this.uuId, this.name, this.students);

  PojoGroup.fromName(String name) {
    this.name = name;
    uuId = Uuid().v1();
    students = new List();
  }

  @override
  factory PojoGroup.fromJson(Map<String, dynamic> json) =>
      _$PojoGroupFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PojoGroupToJson(this);
}
