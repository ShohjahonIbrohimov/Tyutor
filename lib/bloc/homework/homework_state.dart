part of 'homework_bloc.dart';

abstract class HomeworkState extends Equatable {
  const HomeworkState();

  @override
  List<Object?> get props => [];
}

class HomeworkInitial extends HomeworkState {}

class HomeworkLoading extends HomeworkState {}

class HomeworkSuccess extends HomeworkState {
  List<HomeworkModel>? data;
  TaskDetailModel? taskData;
  List<ReportModel> reportsData;
  ReportModel? reportData;

  HomeworkSuccess({
    this.data,
    this.taskData,
    this.reportsData = const [],
    this.reportData,
  });
}

class HomeworkError extends HomeworkState {
  final String message;
  const HomeworkError(this.message);
}
