part of 'cat_profile_bloc.dart';

sealed class CatProfileState extends Equatable {
  const CatProfileState();
}

final class CatProfileInitial extends CatProfileState {
  @override
  List<Object> get props => [];
}

class CatProfileLoading extends CatProfileState {
  @override
  List<Object?> get props => [];
}

class CatProfileSuccess extends CatProfileState {
  final String? message;
  final CatEntity cat;

  const CatProfileSuccess({required this.cat, this.message});

  @override
  List<Object?> get props => [message];
}

class CatProfileLoaded extends CatProfileState {
  final CatEntity catProfile;

  const CatProfileLoaded({required this.catProfile});

  @override
  List<Object?> get props => [catProfile];
}

class CatProfileFailure extends CatProfileState {
  final String message;

  const CatProfileFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
