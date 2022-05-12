// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'homework_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_HomeworkModel _$$_HomeworkModelFromJson(Map<String, dynamic> json) =>
    _$_HomeworkModel(
      id: json['id'] as int? ?? 0,
      beginning_date: json['beginning_date'] as String? ?? '',
      deadline: json['deadline'] as String? ?? '',
      status: json['status'] as int? ?? 0,
      description: json['description'] as String? ?? '',
    );

Map<String, dynamic> _$$_HomeworkModelToJson(_$_HomeworkModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'beginning_date': instance.beginning_date,
      'deadline': instance.deadline,
      'status': instance.status,
      'description': instance.description,
    };
