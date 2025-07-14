import 'package:dartz/dartz.dart';

import '../../../../core/Services/Error Handling/exports.error_handling.dart';
import '../../../../core/params/Cat/cat_params.dart';
import '../entities/cat_entity.dart';
import '../repositories/cat_profile_repository.dart';

class UpdateCatProfile {
  final CatProfileRepository catProfileRepository;

  UpdateCatProfile({required this.catProfileRepository});

  Future<Either<Failure, CatEntity>> call({
    required UpdateCatProfileParams params,
  }) async {
    return await catProfileRepository.updateCatProfile(params: params);
  }
}
