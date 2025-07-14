import 'package:dartz/dartz.dart';

import '../../../../core/Services/Error Handling/errors/failure.dart';
import '../../../../core/params/authentication/authentication_params.dart';
import '../repositories/auth_repository.dart';

class ResetPassword {
  final AuthRepository authRepository;

  ResetPassword({required this.authRepository});

  Future<Either<Failure, void>> call({
    required ResetPasswordParams resetPasswordParams,
  }) async {
    return await authRepository.resetPassword(
        resetPasswordParams: resetPasswordParams);
  }
}
