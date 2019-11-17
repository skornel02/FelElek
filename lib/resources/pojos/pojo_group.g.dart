// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pojo_group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PojoGroup _$PojoGroupFromJson(Map<String, dynamic> json) {
  return PojoGroup(
      json['uuId'] as String,
      json['name'] as String,
      (json['students'] as List)
          ?.map((e) => e == null
              ? null
              : PojoStudent.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$PojoGroupToJson(PojoGroup instance) => <String, dynamic>{
      'uuId': instance.uuId,
      'name': instance.name,
      'students': instance.students
    };
