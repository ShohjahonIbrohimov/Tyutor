part of 'groups_bloc.dart';

abstract class GroupsState extends Equatable {
  const GroupsState();

  @override
  List<Object?> get props => [];
}

class GroupsInitial extends GroupsState {}

class GroupsLoading extends GroupsState {}

class GroupsSuccess extends GroupsState {
  List<GroupsModel> data;

  GroupsSuccess(this.data);
}

class GroupsError extends GroupsState {
  final String message;
  const GroupsError(this.message);
}
