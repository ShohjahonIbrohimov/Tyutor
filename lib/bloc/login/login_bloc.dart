import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:moreinfo/bloc/login/types.dart';
import 'package:moreinfo/cubit/reset_pass/reset_pass_cubit.dart';
import 'package:moreinfo/data/models/user/user_model.dart';
import 'package:moreinfo/data/providers/config.dart';
import 'package:moreinfo/data/repositories/auth/auth_repository.dart';
import 'package:moreinfo/data/repositories/auth/token_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required AuthRepository apiRepository,
    required TokenRepository tokenRepository,
  })  : _apiRepository = apiRepository,
        _tokenRepository = tokenRepository,
        super(LoginInitial()) {
    on<LoginWithCredentials>(_onLoginWithCredentials);
    on<ResetGetCode>(_onResetGetCode);
    on<ResetSendCode>(_onResetSendCode);
    on<ResetSendNewPassword>(_onResetSendNewPassword);
    on<ResetPassword>(_onResetPassword);
  }
  final AuthRepository _apiRepository;
  final TokenRepository _tokenRepository;

  _onLoginWithCredentials(event, Emitter<LoginState> emit) async {
    try {
      emit(LoginLoading());
      String token = await _apiRepository.loginRP(event.data);
      await _tokenRepository.setToken(token);
      dio.options.headers = {
        'Authorization': 'Bearer $token',
      };
      await _apiRepository.getUserRP();
      var user_data = await _tokenRepository.getUserData();

      emit(LoginSuccess(user_data: user_data));
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }

  _onResetGetCode(event, Emitter<LoginState> emit) async {
    try {
      emit(LoginLoading());
      await _apiRepository.getCodeRP(event.data);

      emit(LoginSuccess());
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }

  _onResetSendCode(event, Emitter<LoginState> emit) async {
    try {
      emit(LoginLoading());
      await _apiRepository.sendCodeRP(event.data);

      emit(LoginSuccess());
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }

  _onResetSendNewPassword(event, Emitter<LoginState> emit) async {
    try {
      emit(LoginLoading());
      await _apiRepository.sendPasswordRP(event.data);

      emit(LoginSuccess());
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }

  _onResetPassword(event, Emitter<LoginState> emit) async {
    try {
      emit(LoginLoading());
      await _apiRepository.resetPasswordRP(event.data);

      emit(LoginSuccess());
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }
}
