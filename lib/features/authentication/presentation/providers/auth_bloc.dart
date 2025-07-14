import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/Services/Auth/auth.service.dart';
import '../../../../core/Services/Error Handling/exports.error_handling.dart';
import '../../../../core/params/authentication/authentication_params.dart';
import '../../../../core/params/profile/profile_params.dart';
import '../../../Profile/domain/usecases/create_profile.dart';
import '../../domain/usecases/login_user.dart';
import '../../domain/usecases/register_user.dart';
import '../../domain/usecases/reset_password.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUser loginUseCase;
  final RegisterUser registerUseCase;
  final ResetPassword resetPasswordUseCase;
  final CreateProfile createProfileUseCase;
  final AuthService authService;

  AuthBloc({
    required this.loginUseCase,
    required this.authService,
    required this.registerUseCase,
    required this.resetPasswordUseCase,
    required this.createProfileUseCase,
  }) : super(const AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<RegisterRequested>(_onRegisterRequested);
    on<ResetPasswordRequested>(_onResetPasswordRequested);
    on<AuthCheckRequested>(_onAuthCheckRequested);
    on<LogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onAuthCheckRequested(
      AuthCheckRequested event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    final isLoggedIn = await authService.isUserLoggedIn().first;
    emit(isLoggedIn != null
        ? const AuthAuthenticated()
        : const AuthUnauthenticated());
  }

  Future<void> _onLoginRequested(
      LoginRequested event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    try {
      final result = await loginUseCase(
        loginParams: LoginParams(
          email: event.email,
          password: event.password,
        ),
      );

      result.fold(
        (failure) {
          final appError = AppErrorMapper.fromFailure(failure);
          emit(AuthFailure(error: appError));
        },
        (_) => emit(const AuthAuthenticated()),
      );
    } catch (e, s) {
      ErrorHandlingService.handle(
        e,
        s,
        location: 'AuthBloc/login',
        onFailure: (f) {
          final appError = AppErrorMapper.fromFailure(f);
          emit(AuthFailure(error: appError));
        },
      );
    }
  }

  Future<void> _onRegisterRequested(
    RegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    try {
      final result = await registerUseCase(
        registerParams: RegisterParams(
          email: event.email,
          password: event.password,
        ),
      );

      await result.fold(
        (failure) {
          final appError = AppErrorMapper.fromFailure(failure);
          emit(AuthFailure(error: appError));
        },
        (authEntity) async {
          final createProfileResult = await createProfileUseCase(
            params: CreateProfileParams(
              id: authEntity.uid,
              email: event.email,
              fName: event.fName,
              lName: event.lName,
              phoneNumber: event.phoneNumber,
            ),
          );

          createProfileResult.fold(
            (failure) {
              final appError = AppErrorMapper.fromFailure(failure);
              emit(AuthFailure(error: appError));
            },
            (_) => emit(const AuthAuthenticated()),
          );
        },
      );
    } catch (e, s) {
      ErrorHandlingService.handle(
        e,
        s,
        location: 'AuthBloc/register',
        onFailure: (f) {
          final appError = AppErrorMapper.fromFailure(f);
          emit(AuthFailure(error: appError));
        },
      );
    }
  }

  Future<void> _onResetPasswordRequested(
      ResetPasswordRequested event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    try {
      final result = await resetPasswordUseCase(
        resetPasswordParams: ResetPasswordParams(email: event.email),
      );

      result.fold(
        (failure) {
          final appError = AppErrorMapper.fromFailure(failure);
          emit(AuthFailure(error: appError));
        },
        (_) =>
            emit(const AuthAuthenticated(message: "Password reset link sent")),
      );
    } catch (e, s) {
      ErrorHandlingService.handle(
        e,
        s,
        location: 'AuthBloc/reset password',
        onFailure: (f) {
          final appError = AppErrorMapper.fromFailure(f);
          emit(AuthFailure(error: appError));
        },
      );
    }
  }

  Future<void> _onLogoutRequested(
      LogoutRequested event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    try {
      await authService.signOut();
      emit(const AuthUnauthenticated());
    } catch (e, s) {
      ErrorHandlingService.handle(
        e,
        s,
        location: 'AuthBloc/logout',
        onFailure: (f) {
          final appError = AppErrorMapper.fromFailure(f);
          emit(AuthFailure(error: appError));
        },
      );
    }
  }
}
