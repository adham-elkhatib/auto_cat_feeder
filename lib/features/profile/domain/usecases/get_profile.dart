import 'package:dartz/dartz.dart';

import '../../../../core/Services/Error Handling/errors/failure.dart';
import '../../../../core/params/profile/profile_params.dart';
import '../entities/user_entity.dart';
import '../repositories/profile_repository.dart';

class GetProfile {
  final ProfileRepository profileRepository;

  GetProfile({required this.profileRepository});

  Future<Either<Failure, UserEntity>> call({
    required ProfileParams params,
  }) async {
    return await profileRepository.getProfile(params: params);
  }
}
