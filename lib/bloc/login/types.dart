class LoginCredentials {
  String username;
  String password;

  LoginCredentials({
    required this.username,
    required this.password,
  });
}

class ResetPasswordPrivateModel {
  String old_passowrd;
  String new_passowrd;

  ResetPasswordPrivateModel({
    required this.old_passowrd,
    required this.new_passowrd,
  });
}
