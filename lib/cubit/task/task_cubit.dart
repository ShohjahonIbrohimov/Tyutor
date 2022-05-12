import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moreinfo/bloc/homework/homework_bloc.dart';

class TaskCubitModel {
  int? id;
  bool? isAdd;
  HomeworkEvent? taskEvent;

  TaskCubitModel({this.id, this.isAdd, this.taskEvent});
}

class TaskCubit extends Cubit<TaskCubitModel> {
  TaskCubit() : super(TaskCubitModel(isAdd: true));

  void setIsAdd(val) => emit(val);
}
