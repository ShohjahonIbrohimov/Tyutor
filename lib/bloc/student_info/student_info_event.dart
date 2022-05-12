part of 'student_info_bloc.dart';

abstract class StudentInfoEvent extends Equatable {
  const StudentInfoEvent();

  @override
  List<Object> get props => [];
}

class StartFetchStudent extends StudentInfoEvent {
  int id;

  StartFetchStudent(this.id);
}
