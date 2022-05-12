part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class Authenticating extends AuthState {}

class Authenticated extends AuthState {
  final String? token;
  final Map<String, dynamic> user_data;

  const Authenticated(this.token, this.user_data);
}

class UnAuthenticated extends AuthState {}
