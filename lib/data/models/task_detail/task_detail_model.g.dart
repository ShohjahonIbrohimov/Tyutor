// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TaskDetailModel _$$_TaskDetailModelFromJson(Map<String, dynamic> json) =>
    _$_TaskDetailModel(
      id: json['id'] as int? ?? 0,
      beginning_date: json['beginning_date'] as String? ?? '',
      deadline: json['deadline'] as String? ?? '',
      status: json['status'] as int? ?? 0,
      task_description: json['task_description'] as String? ?? '',
      taskFiles: json['taskFiles'] as String? ?? '',
      prorektor_description: json['prorektor_description'] as String? ?? '',
      documentFiles: json['documentFiles'] as Map<String, dynamic>? ?? const {},
      imageFiles: json['imageFiles'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$_TaskDetailModelToJson(_$_TaskDetailModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'beginning_date': instance.beginning_date,
      'deadline': instance.deadline,
      'status': instance.status,
      'task_description': instance.task_description,
      'taskFiles': instance.taskFiles,
      'prorektor_description': instance.prorektor_description,
      'documentFiles': instance.documentFiles,
      'imageFiles': instance.imageFiles,
    };
