import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:moreinfo/bloc/login/types.dart';
import 'package:moreinfo/data/models/groups/groups_model.dart';
import 'package:moreinfo/data/repositories/groups/groups_repository.dart';

part 'groups_event.dart';
part 'groups_state.dart';

class GroupsBloc extends Bloc<GroupsEvent, GroupsState> {
  GroupsBloc({
    required GroupsRepository apiRepository,
  })  : _apiRepository = apiRepository,
        super(GroupsInitial()) {
    on<StartFetchGroups>(_onStartFetchGroups);
  }
  final GroupsRepository _apiRepository;

  _onStartFetchGroups(event, Emitter<GroupsState> emit) async {
    try {
      emit(GroupsLoading());
      List<GroupsModel> data = await _apiRepository.getGroupsRP();

      emit(GroupsSuccess(data));
    } catch (e) {
      emit(GroupsError(e.toString()));
    }
  }
}
