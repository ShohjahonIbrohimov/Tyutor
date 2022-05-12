part of 'taskupload_bloc.dart';

abstract class TaskUploadEvent extends Equatable {
  const TaskUploadEvent();

  @override
  List<Object> get props => [];
}

class StartFetchHomework extends TaskUploadEvent {}

class StartUploadTask extends TaskUploadEvent {
  Map<String, dynamic> data;
  int taskId;

  StartUploadTask({
    required this.taskId,
    required this.data,
  });
}
