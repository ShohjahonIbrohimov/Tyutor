import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:moreinfo/data/repositories/add_student/add_student_repository.dart';
import 'package:moreinfo/data/repositories/student_info/student_info_repository.dart';

part 'student_info_event.dart';
part 'student_info_state.dart';

class StudentInfoBloc extends Bloc<StudentInfoEvent, StudentInfoState> {
  StudentInfoBloc({
    required StudentInfoRepository apiRepository,
  })  : _apiRepository = apiRepository,
        super(StudentInfoLoadInitial()) {
    on<StartFetchStudent>(_onStartFetchStudent);
  }
  final StudentInfoRepository _apiRepository;

  _onStartFetchStudent(
      StartFetchStudent event, Emitter<StudentInfoState> emit) async {
    try {
      emit(FetchStudentLoadInProgress());
      Map<String, dynamic> data = await _apiRepository.getStudentRP(event.id);

      emit(StudentInfoLoadSuccess(studentInfo: data));
    } catch (e) {
      emit(StudentInfoLoadFailure(e.toString()));
    }
  }
}
