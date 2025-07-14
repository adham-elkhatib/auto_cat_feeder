import 'package:dartz/dartz.dart';

import '../../../../core/Services/Error Handling/errors/failure.dart';
import '../../../../core/params/authentication/authentication_params.dart';
import '../entities/auth_entity.dart';
import '../repositories/auth_repository.dart';

class LoginUser {
  final AuthRepository authRepository;

  LoginUser({required this.authRepository});

  Future<Either<Failure, AuthEntity>> call({
    required LoginParams loginParams,
  }) async {
    return await authRepository.login(loginParams: loginParams);
  }
}
