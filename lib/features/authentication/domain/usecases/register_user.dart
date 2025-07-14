import 'package:dartz/dartz.dart';

import '../../../../core/Services/Error Handling/errors/failure.dart';
import '../../../../core/params/authentication/authentication_params.dart';
import '../entities/auth_entity.dart';
import '../repositories/auth_repository.dart';

class RegisterUser {
  final AuthRepository authRepository;

  RegisterUser({required this.authRepository});

  Future<Either<Failure, AuthEntity>> call({
    required RegisterParams registerParams,
  }) async {
    return await authRepository.register(registerParams: registerParams);
  }
}
