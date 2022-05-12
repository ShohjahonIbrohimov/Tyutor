import 'package:flutter_bloc/flutter_bloc.dart';

class TokenCubit extends Cubit<String?> {
  TokenCubit() : super(null);

  void setToken(token) => emit(token);
}
