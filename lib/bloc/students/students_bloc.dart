import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:moreinfo/data/models/student/student_model.dart';
import 'package:moreinfo/data/repositories/students/students_repository.dart';

part 'students_event.dart';
part 'student_state.dart';

class StudentsBloc extends Bloc<StudentsEvent, StudentsState> {
  StudentsBloc({
    required StudentsRepository apiRepository,
  })  : _apiRepository = apiRepository,
        super(StudentsInitial()) {
    on<StartFetchStudents>(_onStartFetchStudents);
    on<StartFetchTalentedStudents>(_onStartFetchTalentedStudents);
    on<StartFetchTalentList>(_onStartFetchTalentList);
    on<StartAddTalent>(_onStartAddTalent);
  }
  final StudentsRepository _apiRepository;

  _onStartFetchStudents(
      StartFetchStudents event, Emitter<StudentsState> emit) async {
    try {
      emit(StudentsLoading());
      List<StudentModel> data =
          await _apiRepository.getStudentsRP(event.groupId);

      emit(StudentsGroupSuccess(data));
    } catch (e) {
      emit(StudentsError(e.toString()));
    }
  }

  _onStartFetchTalentedStudents(event, Emitter<StudentsState> emit) async {
    try {
      emit(StudentsLoading());
      List data = await _apiRepository.geTalentedtStudentsRP();

      emit(StudentsSuccess(talentedStudents: data));
    } catch (e) {
      emit(StudentsError(e.toString()));
    }
  }

  _onStartFetchTalentList(event, Emitter<StudentsState> emit) async {
    try {
      emit(StudentsLoading());
      List data = await _apiRepository.getTalentListRP();

      emit(StudentsSuccess(talentList: data));
    } catch (e) {
      emit(StudentsError(e.toString()));
    }
  }

  _onStartAddTalent(StartAddTalent event, Emitter<StudentsState> emit) async {
    try {
      emit(StudentsAddTalentedLoading());
      await _apiRepository.addTalentRP(event.data);

      emit(StudentsAddTalentedSuccess());
    } catch (e) {
      emit(StudentsError(e.toString()));
    }
  }
}
