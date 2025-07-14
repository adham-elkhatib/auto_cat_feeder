import '../../../../core/Services/Auth/auth.service.dart';
import '../../../../core/Services/Auth/src/Providers/firebase/firebase_provider_index.dart';
import '../../../../core/Services/Error Handling/exports.error_handling.dart';
import '../../../../core/params/authentication/authentication_params.dart';
import '../models/auth_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthModel> login({required LoginParams loginParams});

  Future<AuthModel> register({required RegisterParams registerParams});

  Future<void> resetPassword(
      {required ResetPasswordParams resetPasswordParams});

  Future<void> logout();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final AuthService authService;

  AuthRemoteDataSourceImpl({required this.authService});

  @override
  Future<AuthModel> login({required LoginParams loginParams}) async {
    try {
      final authEntity = await authService.signIn(
        EmailAuthMethod(
          email: loginParams.email,
          password: loginParams.password,
        ),
      );
      // todo temp fix
      return AuthModel(
        uid: authEntity!.uid,
        authenticationToken: authEntity.authenticationToken,
        refreshToken: authEntity.refreshToken,
        provider: authEntity.provider,
      );
    } catch (e, s) {
      throw ErrorMapper.map(e, s, location: "AuthRemoteDataSource/login");
    }
  }

  @override
  Future<AuthModel> register({required RegisterParams registerParams}) async {
    try {
      final authEntity = await authService.signUp(
        registerParams.email,
        registerParams.password,
      );

      return AuthModel(
        uid: authEntity!.uid,
        authenticationToken: authEntity.authenticationToken,
        refreshToken: authEntity.refreshToken,
        provider: authEntity.provider,
      );
    } catch (e, s) {
      throw ErrorMapper.map(e, s, location: "AuthRemoteDataSource/register");
    }
  }

  @override
  Future<void> resetPassword(
      {required ResetPasswordParams resetPasswordParams}) async {
    try {
      await authService.resetPassword(resetPasswordParams.email);

      return;
    } catch (e, s) {
      throw ErrorMapper.map(e, s,
          location: "AuthRemoteDataSource/resetPassword");
    }
  }

  @override
  Future<void> logout() async {
    try {
      await authService.signOut();
      return;
    } catch (e, s) {
      throw ErrorMapper.map(e, s, location: "AuthRemoteDataSource/logout");
    }
  }
}
