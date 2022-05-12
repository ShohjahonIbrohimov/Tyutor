part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginWithCredentials extends LoginEvent {
  LoginCredentials data;

  LoginWithCredentials(this.data);
}

class ResetGetCode extends LoginEvent {
  ResetPassModel data;

  ResetGetCode(this.data);
}

class ResetSendCode extends LoginEvent {
  ResetPassModel data;

  ResetSendCode(this.data);
}

class ResetSendNewPassword extends LoginEvent {
  ResetPassModel data;

  ResetSendNewPassword(this.data);
}

class ResetPassword extends LoginEvent {
  ResetPasswordPrivateModel data;

  ResetPassword(this.data);
}
