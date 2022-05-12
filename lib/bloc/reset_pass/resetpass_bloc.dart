import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:moreinfo/bloc/reset_pass/types.dart';
import 'package:moreinfo/data/models/student/student_model.dart';
import 'package:moreinfo/data/repositories/resetpass/resetpass_repository.dart';
import 'package:moreinfo/data/repositories/students/students_repository.dart';

part 'resetpass_event.dart';
part 'resetpass_state.dart';

class ResetPassBloc extends Bloc<ResetPassEvent, ResetPassState> {
  ResetPassBloc({
    required ResetPassRepository apiRepository,
  })  : _apiRepository = apiRepository,
        super(ResetPassInitial()) {
    on<StartResetPass>(_onStartResetPass);
  }
  final ResetPassRepository _apiRepository;

  _onStartResetPass(StartResetPass event, Emitter<ResetPassState> emit) async {
    try {
      emit(ResetPassLoading());
      await _apiRepository.resetPassRP(event.data);

      emit(ResetPassSuccess());
    } catch (e) {
      emit(ResetPassError(e.toString()));
    }
  }
}
