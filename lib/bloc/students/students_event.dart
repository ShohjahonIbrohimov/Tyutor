part of 'students_bloc.dart';

abstract class StudentsEvent extends Equatable {
  const StudentsEvent();

  @override
  List<Object> get props => [];
}

class StartFetchStudents extends StudentsEvent {
  String groupId;

  StartFetchStudents(this.groupId);
}

class StartFetchTalentedStudents extends StudentsEvent {}

class StartFetchTalentList extends StudentsEvent {}

class StartAddTalent extends StudentsEvent {
  Map<String, dynamic> data;

  StartAddTalent(this.data);
}
