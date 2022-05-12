import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:moreinfo/data/providers/config.dart';
import 'package:moreinfo/data/repositories/auth/token_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final TokenRepository _tokenRepository;

  AuthCubit(
    this._tokenRepository,
  ) : super(Authenticating());

  Future<void> authenticate(lang) async {
    emit(Authenticating());
    String? token = await _tokenRepository.getToken();
    if (token != "null") {
      dio.options.headers = {
        'Authorization': 'Bearer $token',
        'contentType': 'application/json',
      };
      emit(Authenticated(token));
    } else {
      emit(UnAuthenticated());
    }
  }

  Future<void> removeToken() async {
    dio.options.headers = {};
    await _tokenRepository.removeToken();
    emit(UnAuthenticated());
  }
}
