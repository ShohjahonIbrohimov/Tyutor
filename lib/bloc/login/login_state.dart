part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final Map<String, dynamic>? user_data;

  LoginSuccess({this.user_data});
}

class LoginError extends LoginState {
  final String message;
  const LoginError(this.message);
}
