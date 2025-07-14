part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();
}

final class LoginRequested extends AuthEvent {
  final String email;
  final String password;

  const LoginRequested({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}

final class RegisterRequested extends AuthEvent {
  final String email;
  final String password;
  final String fName;
  final String lName;
  final String phoneNumber;

  const RegisterRequested({
    required this.email,
    required this.password,
    required this.fName,
    required this.lName,
    required this.phoneNumber,
  });

  @override
  List<Object?> get props => [email, password];
}

final class ResetPasswordRequested extends AuthEvent {
  final String email;

  const ResetPasswordRequested({
    required this.email,
  });

  @override
  List<Object?> get props => [email];
}

class AuthCheckRequested extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class LogoutRequested extends AuthEvent {
  const LogoutRequested();

  @override
  List<Object?> get props => [];
}
