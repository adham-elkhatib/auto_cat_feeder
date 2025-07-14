import 'package:dartz/dartz.dart';

import '../../../../core/Services/Error Handling/errors/failure.dart';
import '../repositories/auth_repository.dart';

class CheckAuthStatus {
  final AuthRepository authRepository;

  CheckAuthStatus({required this.authRepository});

  Future<Either<Failure, bool>> call() async {
    return await authRepository.isLoggedIn();
  }
}
