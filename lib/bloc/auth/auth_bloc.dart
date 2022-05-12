import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:moreinfo/bloc/login/types.dart';
import 'package:moreinfo/data/providers/config.dart';
import 'package:moreinfo/data/repositories/auth/auth_repository.dart';
import 'package:moreinfo/data/repositories/auth/token_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required TokenRepository apiRepository,
  })  : _apiRepository = apiRepository,
        super(UnAuthenticated()) {
    on<Authenticate>(_onAuthenticate);
    on<Logout>(_onLogout);
  }
  final TokenRepository _apiRepository;

  _onAuthenticate(event, Emitter<AuthState> emit) async {
    emit(Authenticating());
    String? token = await _apiRepository.getToken();
    var user_data = await _apiRepository.getUserData();

    if (token != "null") {
      dio.options.headers = {
        'Authorization': 'Bearer $token',
      };
      emit(Authenticated(token, user_data));
    } else {
      emit(UnAuthenticated());
    }
  }

  _onLogout(event, Emitter<AuthState> emit) async {
    dio.options.headers = {};
    await _apiRepository.removeToken();
    emit(UnAuthenticated());
  }
}
