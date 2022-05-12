import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
part 'groups_model.freezed.dart';
part 'groups_model.g.dart';

@freezed
class GroupsModel with _$GroupsModel {
  const factory GroupsModel({
    @Default(0) int id,
    @Default('No group name') String name,
    @Default(0) int studentCount,
  }) = _GroupsModel;
  factory GroupsModel.fromJson(Map<String, dynamic> json) =>
      _$GroupsModelFromJson(json);
}
