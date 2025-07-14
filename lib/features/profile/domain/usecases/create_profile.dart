import 'package:dartz/dartz.dart';

import '../../../../core/Services/Error Handling/exports.error_handling.dart';
import '../../../../core/params/profile/profile_params.dart';
import '../repositories/profile_repository.dart';

class CreateProfile {
  final ProfileRepository profileRepository;

  CreateProfile({required this.profileRepository});

  Future<Either<Failure, void>> call({
    required CreateProfileParams params,
  }) async {
    return await profileRepository.createProfile(params: params);
  }
}
