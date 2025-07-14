import 'package:dartz/dartz.dart';

import '../../../../core/Services/Error Handling/errors/failure.dart';
import '../../../../core/params/profile/profile_params.dart';
import '../entities/user_entity.dart';

abstract class ProfileRepository {
  Future<Either<Failure, UserEntity>> getProfile({
    required ProfileParams params,
  });

  Future<Either<Failure, void>> updateProfile({
    required UpdateProfileParams params,
  });

  Future<Either<Failure, void>> createProfile({
    required CreateProfileParams params,
  });
}
