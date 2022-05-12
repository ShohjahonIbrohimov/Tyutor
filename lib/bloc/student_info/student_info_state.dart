part of 'student_info_bloc.dart';

abstract class StudentInfoState extends Equatable {
  const StudentInfoState();

  @override
  List<Object?> get props => [];
}

class StudentInfoLoadInitial extends StudentInfoState {}

class StudentInfoLoadInProgress extends StudentInfoState {}

class FetchFacultiesLoadInProgress extends StudentInfoState {}

class FetchStudentLoadInProgress extends StudentInfoState {}

class StudentInfoLoadFailure extends StudentInfoState {
  final String message;
  const StudentInfoLoadFailure(this.message);
}

class StudentInfoLoadSuccess extends StudentInfoState {
  const StudentInfoLoadSuccess({this.faculties, this.studentInfo});

  final List? faculties;
  final Map<String, dynamic>? studentInfo;
}
