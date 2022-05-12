part of 'homework_bloc.dart';

abstract class HomeworkEvent extends Equatable {
  const HomeworkEvent();

  @override
  List<Object> get props => [];
}

class StartFetchHomework extends HomeworkEvent {}

class StartFetchSpirtualLessons extends HomeworkEvent {}

class StartFetchReports extends HomeworkEvent {}

class StartFetchTask extends HomeworkEvent {
  int taskId;

  StartFetchTask(this.taskId);
}

class StartFetchReport extends HomeworkEvent {
  int reportId;

  StartFetchReport(this.reportId);
}
