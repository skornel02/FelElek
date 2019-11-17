// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pojo_student.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PojoStudent _$PojoStudentFromJson(Map<String, dynamic> json) {
  return PojoStudent(
      name: json['name'] as String,
      id: json['id'] as int,
      grades: (json['grades'] as List)?.map((e) => e as int)?.toList(),
      isAbsent: json['isAbsent'] as bool);
}

Map<String, dynamic> _$PojoStudentToJson(PojoStudent instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'grades': instance.grades,
      'isAbsent': instance.isAbsent
    };
