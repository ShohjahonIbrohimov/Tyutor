import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:moreinfo/data/repositories/homework/homework_repository.dart';

part 'taskupload_event.dart';
part 'taskupload_state.dart';

class TaskUploadBloc extends Bloc<TaskUploadEvent, TaskUploadState> {
  TaskUploadBloc({
    required HomeworkRepository apiRepository,
  })  : _apiRepository = apiRepository,
        super(TaskUploadInitial()) {
    on<StartUploadTask>(_onStartUploadTask);
  }
  final HomeworkRepository _apiRepository;

  _onStartUploadTask(
      StartUploadTask event, Emitter<TaskUploadState> emit) async {
    try {
      emit(TaskUploadLoading());
      await _apiRepository.uploadTaskRP(event.data, event.taskId);

      emit(TaskUploadSuccess());
    } catch (e) {
      emit(TaskUploadError(e.toString()));
    }
  }
}
