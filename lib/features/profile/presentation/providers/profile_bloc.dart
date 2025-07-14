import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/Services/Auth/auth.service.dart';
import '../../../../core/params/profile/profile_params.dart';
import '../../../../locator.dart';
import '../../../authentication/domain/usecases/logout_user.dart';
import '../../../authentication/presentation/providers/auth_bloc.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/create_profile.dart';
import '../../domain/usecases/get_profile.dart';
import '../../domain/usecases/update_profile.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfile getProfileUseCase;
  final CreateProfile createProfileUseCase;
  final UpdateProfile updateProfileUseCase;
  final LogoutUser logoutUserUseCase;

  ProfileBloc({
    required this.getProfileUseCase,
    required this.createProfileUseCase,
    required this.updateProfileUseCase,
    required this.logoutUserUseCase,
  }) : super(const ProfileInitial()) {
    on<GetProfileEvent>(_onGetProfile);
    on<CreateProfileEvent>(_onCreateProfile);
    on<UpdateProfileEvent>(_onUpdateProfile);
    on<LogoutEvent>(_onLogout);
  }

  Future<void> _onGetProfile(
    GetProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(const ProfileLoading());
    try {
      final uid = sl<AuthService>().getCurrentUserId();
      final result = await getProfileUseCase(params: ProfileParams(id: uid!));
      result.fold(
        (failure) => emit(ProfileFailure(message: failure.message)),
        (user) => emit(ProfileLoaded(user)),
      );
    } catch (e) {
      emit(const ProfileFailure(message: "Unexpected error"));
    }
  }

  Future<void> _onCreateProfile(
    CreateProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(const ProfileLoading());
    try {
      final result = await createProfileUseCase(params: event.params);
      result.fold(
        (failure) => emit(ProfileFailure(message: failure.message)),
        (user) =>
            emit(const ProfileSuccess(message: "Profile created successfully")),
      );
    } catch (e) {
      emit(const ProfileFailure(message: "Unexpected error"));
    }
  }

  Future<void> _onUpdateProfile(
    UpdateProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(const ProfileLoading());
    try {
      final result = await updateProfileUseCase(params: event.params);
      result.fold(
        (failure) => emit(ProfileFailure(message: failure.message)),
        (user) =>
            emit(const ProfileSuccess(message: "Profile updated successfully")),
      );
    } catch (e) {
      emit(const ProfileFailure(message: "Unexpected error"));
    }
  }

  Future<void> _onLogout(
    LogoutEvent event,
    Emitter<ProfileState> emit,
  ) async {
    final result = await logoutUserUseCase();
    result.fold(
      (failure) => emit(ProfileFailure(message: failure.message)),
      (_) {
        sl<AuthBloc>().add(const LogoutRequested());

        emit(const LogoutSuccess());
      },
    );
  }
}
