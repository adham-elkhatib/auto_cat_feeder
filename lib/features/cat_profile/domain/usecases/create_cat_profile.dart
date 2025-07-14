import 'package:dartz/dartz.dart';

import '../../../../core/Services/Error Handling/exports.error_handling.dart';
import '../../../../core/params/Cat/cat_params.dart';
import '../entities/cat_entity.dart';
import '../repositories/cat_profile_repository.dart';

class CreateCatProfile {
  final CatProfileRepository catProfileRepository;

  CreateCatProfile({required this.catProfileRepository});

  Future<Either<Failure, CatEntity>> call({
    required CreateCatProfileParams params,
  }) async {
    return await catProfileRepository.createCatProfile(params: params);
  }
}
