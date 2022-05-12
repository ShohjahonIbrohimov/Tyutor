import 'package:flutter_bloc/flutter_bloc.dart';

class UserDataCubit extends Cubit<Map<String, dynamic>?> {
  UserDataCubit() : super(null);

  void setUserData(state) => emit(state);
}
