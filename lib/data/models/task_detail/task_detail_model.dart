import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
part 'task_detail_model.freezed.dart';
part 'task_detail_model.g.dart';

@freezed
class TaskDetailModel with _$TaskDetailModel {
  const factory TaskDetailModel({
    @Default(0) int id,
    @Default('') String beginning_date,
    @Default('') String deadline,
    @Default(0) int status,
    @Default('') String task_description,
    @Default('') String taskFiles,
    @Default('') String prorektor_description,
    @Default({}) Map<String, dynamic> documentFiles,
    @Default({}) Map<String, dynamic> imageFiles,
  }) = _TaskDetailModel;
  factory TaskDetailModel.fromJson(Map<String, dynamic> json) =>
      _$TaskDetailModelFromJson(json);
}
