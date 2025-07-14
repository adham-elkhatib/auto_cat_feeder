part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();
}

final class AuthLoading extends AuthState {
  const AuthLoading();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {
  const AuthInitial();

  @override
  List<Object> get props => [];
}

final class AuthAuthenticated extends AuthState {
  final String? message;

  const AuthAuthenticated({this.message});

  @override
  List<Object> get props => [];
}

final class AuthFailure extends AuthState {
  final AppError error;

  const AuthFailure({required this.error});

  @override
  List<Object> get props => [error];
}

final class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated();

  @override
  List<Object> get props => [];
}
