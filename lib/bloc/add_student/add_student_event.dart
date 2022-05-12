part of 'add_student_bloc.dart';

abstract class AddStudentEvent extends Equatable {
  const AddStudentEvent();

  @override
  List<Object> get props => [];
}

class StartFetchFaculties extends AddStudentEvent {}

class StartAddStudent extends AddStudentEvent {
  Map<String, dynamic> data;

  StartAddStudent(this.data);
}

class StartUpdateStudent extends AddStudentEvent {
  Map<String, dynamic> data;
  int studentId;

  StartUpdateStudent({required this.data, required this.studentId});
}
