import 'package:dartz/dartz.dart';

import '../../../../core/Services/Error Handling/exports.error_handling.dart';
import '../../../../core/params/Cat/cat_params.dart';
import '../entities/cat_entity.dart';

abstract class CatProfileRepository {
  Future<Either<Failure, CatEntity>> getCatProfile({
    required String uid,
  });

  Future<Either<Failure, CatEntity>> createCatProfile({
    required CreateCatProfileParams params,
  });

  Future<Either<Failure, CatEntity>> updateCatProfile({
    required UpdateCatProfileParams params,
  });
}
