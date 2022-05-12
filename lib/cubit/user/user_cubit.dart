import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moreinfo/data/models/user/user_model.dart';

class UserCubit extends Cubit<UserModel?> {
  UserCubit() : super(null);

  void setUser(UserModel val) => emit(val);
}
