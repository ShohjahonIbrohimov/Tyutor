part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class Authenticating extends AuthState {}

class Authenticated extends AuthState {
  final String? token;

  const Authenticated(this.token);
}

class UnAuthenticated extends AuthState {}
