// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_StudentModel _$$_StudentModelFromJson(Map<String, dynamic> json) =>
    _$_StudentModel(
      id: json['id'] as int? ?? 0,
      fio: json['fio'] as String? ?? '',
      status: json['status'] as int? ?? 0,
      cur_living_description: json['cur_living_description'] as String? ?? '',
      cur_living_address: json['cur_living_address'] as String? ?? '',
    );

Map<String, dynamic> _$$_StudentModelToJson(_$_StudentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fio': instance.fio,
      'status': instance.status,
      'cur_living_description': instance.cur_living_description,
      'cur_living_address': instance.cur_living_address,
    };
