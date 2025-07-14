class LoginParams {
  final String email;
  final String password;

  LoginParams({
    required this.email,
    required this.password,
  });
}

class RegisterParams {
  final String email;
  final String password;

  RegisterParams({
    required this.email,
    required this.password,
  });
}

class ResetPasswordParams {
  final String email;

  ResetPasswordParams({
    required this.email,
  });
}
