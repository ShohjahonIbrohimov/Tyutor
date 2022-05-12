import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moreinfo/data/models/groups/groups_model.dart';

class CurrentGroupCubit extends Cubit<GroupsModel?> {
  CurrentGroupCubit() : super(null);

  void setCurrentGroup(GroupsModel? val) => emit(val);
}
