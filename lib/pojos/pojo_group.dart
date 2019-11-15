import 'package:dusza2019/pojos/pojo_student.dart';
import 'package:json_annotation/json_annotation.dart';



// flutter packages pub run build_runner build --delete-conflicting-outputs
part 'pojo_group.g.dart';

@JsonSerializable()
class PojoGroup{

  String uuId;

  String name;

  List<PojoStudent> students;


  PojoGroup(this.uuId, this.name, this.students);

  @override
  factory PojoGroup.fromJson(Map<String, dynamic> json) =>
      _$PojoGroupFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PojoGroupToJson(this);

}