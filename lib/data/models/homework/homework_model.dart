import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
part 'homework_model.freezed.dart';
part 'homework_model.g.dart';

@freezed
class HomeworkModel with _$HomeworkModel {
  const factory HomeworkModel({
    @Default(0) int id,
    @Default('') String beginning_date,
    @Default('') String deadline,
    @Default(0) int status,
    @Default('') String description,
  }) = _HomeworkModel;
  factory HomeworkModel.fromJson(Map<String, dynamic> json) =>
      _$HomeworkModelFromJson(json);
}
