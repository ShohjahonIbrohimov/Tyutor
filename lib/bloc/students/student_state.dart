part of 'students_bloc.dart';

abstract class StudentsState extends Equatable {
  const StudentsState();

  @override
  List<Object?> get props => [];
}

class StudentsInitial extends StudentsState {}

class StudentsLoading extends StudentsState {}

class StudentsAddTalentedLoading extends StudentsState {}

class StudentsAddTalentedSuccess extends StudentsState {}

class StudentsGroupSuccess extends StudentsState {
  List<StudentModel>? data;

  StudentsGroupSuccess(this.data);
}

class StudentsSuccess extends StudentsState {
  List<StudentModel>? data;
  List? talentedStudents;
  List? talentList;

  StudentsSuccess({this.data, this.talentedStudents, this.talentList});
}

class StudentsError extends StudentsState {
  final String message;
  const StudentsError(this.message);
}
