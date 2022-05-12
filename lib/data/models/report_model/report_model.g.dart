// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ReportModel _$$_ReportModelFromJson(Map<String, dynamic> json) =>
    _$_ReportModel(
      id: json['id'] as int? ?? 0,
      beginning_date: json['beginning_date'] as String? ?? '',
      deadline: json['deadline'] as String? ?? '',
      status: json['status'] as int? ?? 0,
      description: json['description'] as String? ?? '',
      taskFiles: json['taskFiles'] as String? ?? '',
      prorektor_description: json['prorektor_description'] as String? ?? '',
      tyutor_description: json['tyutor_description'] as String? ?? '',
      compleated_persent: json['compleated_persent'] as int? ?? 0,
    );

Map<String, dynamic> _$$_ReportModelToJson(_$_ReportModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'beginning_date': instance.beginning_date,
      'deadline': instance.deadline,
      'status': instance.status,
      'description': instance.description,
      'taskFiles': instance.taskFiles,
      'prorektor_description': instance.prorektor_description,
      'tyutor_description': instance.tyutor_description,
      'compleated_persent': instance.compleated_persent,
    };
