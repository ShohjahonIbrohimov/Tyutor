import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:moreinfo/data/models/homework/homework_model.dart';
import 'package:moreinfo/data/models/report_model/report_model.dart';
import 'package:moreinfo/data/models/student/student_model.dart';
import 'package:moreinfo/data/models/task_detail/task_detail_model.dart';
import 'package:moreinfo/data/repositories/homework/homework_repository.dart';
import 'package:moreinfo/data/repositories/students/students_repository.dart';

part 'homework_event.dart';
part 'homework_state.dart';

class HomeworkBloc extends Bloc<HomeworkEvent, HomeworkState> {
  HomeworkBloc({
    required HomeworkRepository apiRepository,
  })  : _apiRepository = apiRepository,
        super(HomeworkInitial()) {
    on<StartFetchHomework>(_onStartFetchHomework);
    on<StartFetchTask>(_onStartFetchTask);
    on<StartFetchReport>(_onStartFetchReport);
    on<StartFetchSpirtualLessons>(_onStartFetchSpirtualLessons);
    on<StartFetchReports>(_onStartFetchReports);
  }
  final HomeworkRepository _apiRepository;

  _onStartFetchHomework(
      StartFetchHomework event, Emitter<HomeworkState> emit) async {
    try {
      emit(HomeworkLoading());
      List<HomeworkModel> data = await _apiRepository.getHomeworkRP();

      emit(HomeworkSuccess(data: data));
    } catch (e) {
      emit(HomeworkError(e.toString()));
    }
  }

  _onStartFetchTask(StartFetchTask event, Emitter<HomeworkState> emit) async {
    try {
      emit(HomeworkLoading());
      TaskDetailModel data = await _apiRepository.getTaskRP(event.taskId);

      emit(HomeworkSuccess(taskData: data));
    } catch (e) {
      emit(HomeworkError(e.toString()));
    }
  }

  _onStartFetchReport(
      StartFetchReport event, Emitter<HomeworkState> emit) async {
    try {
      emit(HomeworkLoading());
      ReportModel data = await _apiRepository.getReportRP(event.reportId);

      emit(HomeworkSuccess(reportData: data));
    } catch (e) {
      emit(HomeworkError(e.toString()));
    }
  }

  _onStartFetchSpirtualLessons(event, Emitter<HomeworkState> emit) async {
    try {
      emit(HomeworkLoading());
      List<HomeworkModel> data = await _apiRepository.getSpirtualLessonsRP();

      emit(HomeworkSuccess(data: data));
    } catch (e) {
      emit(HomeworkError(e.toString()));
    }
  }

  _onStartFetchReports(event, Emitter<HomeworkState> emit) async {
    try {
      emit(HomeworkLoading());
      List<ReportModel> data = await _apiRepository.getReportsRP();

      emit(HomeworkSuccess(reportsData: data));
    } catch (e) {
      emit(HomeworkError(e.toString()));
    }
  }
}
