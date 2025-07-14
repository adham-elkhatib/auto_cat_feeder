import 'package:dartz/dartz.dart';

import '../../../../core/Services/Error Handling/exports.error_handling.dart';
import '../../../../core/params/profile/profile_params.dart';
import '../repositories/profile_repository.dart';

class UpdateProfile {
  final ProfileRepository profileRepository;

  UpdateProfile({required this.profileRepository});

  Future<Either<Failure, void>> call({
    required UpdateProfileParams params,
  }) async {
    return await profileRepository.updateProfile(params: params);
  }
}
