import 'package:dartz/dartz.dart';

import '../../../../core/Services/Error Handling/errors/failure.dart';
import '../../../../core/params/authentication/authentication_params.dart';
import '../entities/auth_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthEntity>> login({
    required LoginParams loginParams,
  });

  Future<Either<Failure, AuthEntity>> register({
    required RegisterParams registerParams,
  });

  Future<Either<Failure, void>> resetPassword({
    required ResetPasswordParams resetPasswordParams,
  });

  Future<Either<Failure, void>> logout();

  Future<Either<Failure, bool>> isLoggedIn();
}
