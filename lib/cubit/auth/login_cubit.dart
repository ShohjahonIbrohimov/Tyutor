// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:moreinfo/data/models/user_model/user_model.dart';
// import 'package:moreinfo/data/providers/config.dart';
// import 'package:moreinfo/data/repositories/auth/auth_repository.dart';
// import 'package:moreinfo/data/repositories/auth/token_repository.dart';

// part 'login_state.dart';

// class LoginCubit extends Cubit<LoginState> {
//   final AuthRepository _authRepository;
//   final TokenRepository _tokenRepository;

//   LoginCubit(
//     this._authRepository,
//     this._tokenRepository,
//   ) : super(LoginInitial());

//   Future<void> getAuthCB(data, lang) async {
//     emit(LoginLoading());
//     try {
//       Map<String, dynamic> res = await _authRepository.loginRP(data);
    
//       await _tokenRepository.setToken(res['token']);
//       await _tokenRepository.setUserData(res['user_data']);
//       emit(LoginSuccess(res['user_data']));
//     } catch (error) {
//       emit(LoginError(error.toString()));
//     }
//   }
// }
