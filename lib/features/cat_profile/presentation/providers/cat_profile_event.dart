part of 'cat_profile_bloc.dart';

sealed class CatProfileEvent extends Equatable {
  const CatProfileEvent();
}

class LoadProfileEvent extends CatProfileEvent {
  final String catId;

  const LoadProfileEvent({required this.catId});

  @override
  List<Object?> get props => [catId];
}

class SubmitProfileEvent extends CatProfileEvent {
  final CreateCatProfileParams params;

  const SubmitProfileEvent({required this.params});

  @override
  List<Object?> get props => [params];
}

class UpdateProfileEvent extends CatProfileEvent {
  final UpdateCatProfileParams params;

  const UpdateProfileEvent({required this.params});

  @override
  List<Object?> get props => [params];
}
