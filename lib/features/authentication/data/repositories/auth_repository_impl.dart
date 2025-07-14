import 'package:dartz/dartz.dart';

import '../../../../../core/connection/network_info.dart';
import '../../../../../core/params/authentication/authentication_params.dart';
import '../../../../core/Services/Error Handling/exports.error_handling.dart';
import '../../domain/entities/auth_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_data_source.dart';
import '../datasources/auth_remote_data_source.dart';
import '../models/auth_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  /// ✅ Login
  @override
  Future<Either<Failure, AuthEntity>> login({
    required LoginParams loginParams,
  }) async {
    if (await networkInfo.isConnected!) {
      try {
        final AuthModel remoteAuth =
            await remoteDataSource.login(loginParams: loginParams);

        localDataSource.cacheAuthData(authToCache: remoteAuth);

        return Right(remoteAuth.toEntity());
      } catch (e, s) {
        return Left(
            ErrorHandlingService.handle(e, s, location: 'AuthRepo/login'));
      }
    } else {
      return Left(NetworkFailure(
        message: 'No internet connection',
      ));
    }
  }

  /// ✅ Register
  @override
  Future<Either<Failure, AuthEntity>> register({
    required RegisterParams registerParams,
  }) async {
    if (await networkInfo.isConnected!) {
      try {
        final AuthModel remoteAuth =
            await remoteDataSource.register(registerParams: registerParams);

        localDataSource.cacheAuthData(authToCache: remoteAuth);

        return Right(remoteAuth.toEntity());
      } catch (e, s) {
        final failure =
            ErrorHandlingService.handle(e, s, location: 'AuthRepo/register');
        return Left(failure);
      }
    } else {
      return Left(NetworkFailure(
        message: 'No internet connection',
      ));
    }
  }

  /// ✅ Logout
  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await remoteDataSource.logout();
      await localDataSource.clearCachedAuthData();
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(
        message: 'Failed to clear local session',
      ));
    }
  }

  /// ✅ IsLoggedIn
  @override
  Future<Either<Failure, bool>> isLoggedIn() async {
    try {
      final bool isLoggedIn = await localDataSource.isLoggedIn();
      return Right(isLoggedIn);
    } catch (e) {
      return Left(CacheFailure(
        message: 'Could not check local session',
      ));
    }
  }

  @override
  Future<Either<Failure, void>> resetPassword(
      {required ResetPasswordParams resetPasswordParams}) async {
    if (await networkInfo.isConnected!) {
      try {
        await remoteDataSource.resetPassword(
            resetPasswordParams: resetPasswordParams);
        await localDataSource.clearCachedAuthData();

        return const Right(null);
      } catch (e, s) {
        final failure = ErrorHandlingService.handle(e, s,
            location: 'AuthRepo/resetPassword');
        return Left(failure);
      }
    } else {
      return Left(NetworkFailure(
        message: 'No internet connection',
      ));
    }
  }
}
