// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'groups_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_GroupsModel _$$_GroupsModelFromJson(Map<String, dynamic> json) =>
    _$_GroupsModel(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? 'No group name',
      studentCount: json['studentCount'] as int? ?? 0,
    );

Map<String, dynamic> _$$_GroupsModelToJson(_$_GroupsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'studentCount': instance.studentCount,
    };
