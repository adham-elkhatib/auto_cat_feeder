part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();
}

final class ProfileInitial extends ProfileState {
  const ProfileInitial();

  @override
  List<Object> get props => [];
}

final class ProfileLoading extends ProfileState {
  const ProfileLoading();

  @override
  List<Object> get props => [];
}

final class ProfileLoaded extends ProfileState {
  final UserEntity user;

  const ProfileLoaded(this.user);

  @override
  List<Object> get props => [user];
}

final class ProfileSuccess extends ProfileState {
  final String? message;

  const ProfileSuccess({this.message});

  @override
  List<Object> get props => [];
}

final class ProfileFailure extends ProfileState {
  final String message;

  const ProfileFailure({required this.message});

  @override
  List<Object> get props => [];
}

class LogoutSuccess extends ProfileState {
  const LogoutSuccess();

  @override
  List<Object?> get props => [];
}
