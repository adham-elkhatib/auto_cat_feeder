import 'package:dartz/dartz.dart';

import '../../../../core/Services/Error Handling/exports.error_handling.dart';
import '../entities/cat_entity.dart';
import '../repositories/cat_profile_repository.dart';

class GetCatProfile {
  final CatProfileRepository catProfileRepository;

  GetCatProfile({required this.catProfileRepository});

  Future<Either<Failure, CatEntity>> call({
    required String uid,
  }) async {
    return await catProfileRepository.getCatProfile(uid: uid);
  }
}
