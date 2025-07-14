import 'package:dartz/dartz.dart';

import '../../../../../core/connection/network_info.dart';
import '../../../../core/Services/Auth/auth.service.dart';
import '../../../../core/Services/Error Handling/exports.error_handling.dart';
import '../../../../core/params/Cat/cat_params.dart';
import '../../../../locator.dart';
import '../../domain/entities/cat_entity.dart';
import '../../domain/repositories/cat_profile_repository.dart';
import '../datasources/cat_profile_local_data_source.dart';
import '../datasources/cat_profile_remote_data_source.dart';
import '../models/cat_model.dart';

class CatRepositoryImpl implements CatProfileRepository {
  final CatRemoteDataSource remoteDataSource;
  final CatLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  CatRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, CatEntity>> getCatProfile(
      {required String uid}) async {
    if (await networkInfo.isConnected!) {
      try {
        CatModel remoteCat = await remoteDataSource.getCat(uid);

        await localDataSource.cacheCat(catToCache: remoteCat);

        return Right(remoteCat.toEntity());
      } on ServerException {
        return Left(
            ServerFailure(message: 'This is a server exception', code: 500));
      }
    } else {
      try {
        CatModel localCat = await localDataSource.getLastCat();
        return Right(localCat.toEntity());
      } on CacheException {
        return Left(CacheFailure(
          message: 'This is a cache exception',
        ));
      }
    }
  }

  @override
  Future<Either<Failure, CatEntity>> createCatProfile({
    required CreateCatProfileParams params,
  }) async {
    if (await networkInfo.isConnected!) {
      try {
        final authService = sl<AuthService>();
        final String? userId = authService.getCurrentUserId();

        final CatModel catModel = CatModel(
          id: userId!,
          userId: userId,
          name: params.name,
          age: params.age,
          weight: params.weight,
          gender: params.gender,
          breed: params.breed,
          energyLevel: params.energyLevel,
        );

        await remoteDataSource.createCatProfile(catModel);

        await localDataSource.cacheCat(catToCache: catModel);
        await localDataSource.fistTime();
        return Right(catModel.toEntity());
      } on ServerException {
        return Left(ServerFailure(
          message: "Server error creating cat",
          code: 500,
        ));
      }
    } else {
      return Left(NetworkFailure(
        message: "No Internet Connection",
      ));
    }
  }

  @override
  Future<Either<Failure, CatEntity>> updateCatProfile(
      {required UpdateCatProfileParams params}) async {
    if (await networkInfo.isConnected!) {
      try {
        final CatModel catModel = CatModel(
          id: params.id,
          name: params.name,
          age: params.age,
          weight: params.weight,
          gender: params.gender,
          feederId: params.feederId,
          userId: params.userId,
          breed: params.breed,
          energyLevel: params.energyLevel,
        );
        CatModel remoteCat = await remoteDataSource.updateCatProfile(catModel);

        localDataSource.cacheCat(catToCache: remoteCat);

        return Right(remoteCat.toEntity());
      } on ServerException {
        return Left(
            ServerFailure(message: 'This is a server exception', code: 500));
      }
    } else {
      return Left(
        NetworkFailure(
          message: 'No internet connection',
        ),
      );
    }
  }
}
