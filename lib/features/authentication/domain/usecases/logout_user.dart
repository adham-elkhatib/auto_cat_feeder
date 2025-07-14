import 'package:dartz/dartz.dart';

import '../../../../core/Services/Error Handling/errors/failure.dart';
import '../repositories/auth_repository.dart';

class LogoutUser {
  final AuthRepository authRepository;

  LogoutUser({required this.authRepository});

  Future<Either<Failure, void>> call() async {
    return await authRepository.logout();
  }
}
