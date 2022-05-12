import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
part 'report_model.freezed.dart';
part 'report_model.g.dart';

@freezed
class ReportModel with _$ReportModel {
  const factory ReportModel({
    @Default(0) int id,
    @Default('') String beginning_date,
    @Default('') String deadline,
    @Default(0) int status,
    @Default('') String description,
    @Default('') String taskFiles,
    @Default('') String prorektor_description,
    @Default('') String tyutor_description,
    @Default(0) int compleated_persent,
  }) = _ReportModel;
  factory ReportModel.fromJson(Map<String, dynamic> json) =>
      _$ReportModelFromJson(json);
}
