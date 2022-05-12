part of 'add_student_bloc.dart';

abstract class AddStudentState extends Equatable {
  const AddStudentState();

  @override
  List<Object?> get props => [];
}

class AddStudentLoadInitial extends AddStudentState {}

class AddStudentLoadInProgress extends AddStudentState {}

class FetchFacultiesLoadInProgress extends AddStudentState {}

class FetchStudentLoadInProgress extends AddStudentState {}

class AddStudentLoadFailure extends AddStudentState {
  final String message;
  const AddStudentLoadFailure(this.message);
}

class AddStudentLoadSuccess extends AddStudentState {
  const AddStudentLoadSuccess({this.message});

  final String? message;
}

class AddStudentFacultySuccess extends AddStudentState {
  const AddStudentFacultySuccess({this.faculties});

  final List? faculties;
}
