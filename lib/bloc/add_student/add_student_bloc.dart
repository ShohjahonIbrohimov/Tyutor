import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:moreinfo/data/repositories/add_student/add_student_repository.dart';

part 'add_student_event.dart';
part 'add_student_state.dart';

class AddStudentBloc extends Bloc<AddStudentEvent, AddStudentState> {
  AddStudentBloc({
    required AddStudentRepository apiRepository,
  })  : _apiRepository = apiRepository,
        super(AddStudentLoadInitial()) {
    on<StartFetchFaculties>(_onStartFetchFaculties);
    on<StartAddStudent>(_onStartAddStudent);
    on<StartUpdateStudent>(_onStartUpdateStudent);
  }
  final AddStudentRepository _apiRepository;

  _onStartFetchFaculties(event, Emitter<AddStudentState> emit) async {
    try {
      emit(FetchFacultiesLoadInProgress());
      List data = await _apiRepository.getFacultiesRP();

      emit(AddStudentFacultySuccess(faculties: data));
    } catch (e) {
      emit(AddStudentLoadFailure(e.toString()));
    }
  }

  _onStartAddStudent(
      StartAddStudent event, Emitter<AddStudentState> emit) async {
    try {
      emit(AddStudentLoadInProgress());
      String message = await _apiRepository.addStudentRP(event.data);

      emit(AddStudentLoadSuccess(message: message));
    } catch (e) {
      emit(AddStudentLoadFailure(e.toString()));
    }
  }

  _onStartUpdateStudent(
      StartUpdateStudent event, Emitter<AddStudentState> emit) async {
    try {
      emit(AddStudentLoadInProgress());
      String message =
          await _apiRepository.updateStudentRP(event.data, event.studentId);

      emit(AddStudentLoadSuccess(message: message));
    } catch (e) {
      emit(AddStudentLoadFailure(e.toString()));
    }
  }
}
