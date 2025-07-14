import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/connection/network_info.dart';
import '../../../../core/Services/Error Handling/exports.error_handling.dart';
import '../../../../core/params/feeder/feeder_params.dart';
import '../../../../locator.dart';
import '../../../meals/data/models/meal_model.dart';
import '../../domain/entities/feeder_entity.dart';
import '../../domain/repositories/feeder_repository.dart';
import '../datasources/feeder_local_data_source.dart';
import '../datasources/feeder_remote_data_source.dart';
import '../models/feeder_model.dart';

class FeederRepositoryImpl implements FeederRepository {
  final FeederRemoteDataSource remoteDataSource;
  final FeederLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  FeederRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, FeederEntity>> getFeeder(
      {required String feederId}) async {
    if (await networkInfo.isConnected!) {
      try {
        FeederModel remoteFeeder =
            await remoteDataSource.getFeeder(feederId: feederId);

        await localDataSource.cacheFeeder(feederToCache: remoteFeeder);

        return Right(remoteFeeder.toEntity());
      } on ServerException {
        return Left(
            ServerFailure(message: 'This is a server exception', code: 500));
      }
    } else {
      try {
        FeederModel localFeeder = await localDataSource.getLastFeeder();
        return Right(localFeeder.toEntity());
      } on CacheException {
        return Left(CacheFailure(message: 'This is a cache exception'));
      }
    }
  }

  @override
  Future<Either<Failure, void>> connectFeeder({
    required String feederId,
  }) async {
    if (await networkInfo.isConnected!) {
      try {
        final feederModel = FeederModel(
          id: feederId,
          meals: [],
        );

        await remoteDataSource.connectFeeder(feeder: feederModel);

        final prefs = sl<SharedPreferences>();
        await prefs.setString('cached_feeder_id', feederModel.id);

        return const Right(null);
      } on ServerException {
        return Left(ServerFailure(
          message: 'Server error occurred while connecting feeder.',
          code: 500,
        ));
      }
    } else {
      return Left(NetworkFailure(
        message: 'No internet connection.',
      ));
    }
  }

  @override
  Future<Either<Failure, void>> syncToFeeder(
      {required SyncToFeederParams params}) async {
    if (await networkInfo.isConnected!) {
      try {
        final feederModel = FeederModel(
          id: params.id,
          meals: params.meals
                  ?.map((mealEntity) => MealModel.fromEntity(mealEntity))
                  .toList() ??
              [],
          token: params.token,
        );

        await remoteDataSource.syncToFeeder(feeder: feederModel);

        await localDataSource.cacheFeeder(feederToCache: feederModel);

        return const Right(null);
      } on ServerException {
        return Left(
          ServerFailure(
              message: 'Server error occurred while updating feeder.',
              code: 500),
        );
      }
    } else {
      return Left(NetworkFailure(
        message: 'No internet connection.',
      ));
    }
  }

  @override
  Stream<Either<Failure, FeederEntity>> streamFeeder(
      {required String feederId}) {
    return remoteDataSource
        .streamFeeder(feederId: feederId)
        .map((model) => Right<Failure, FeederEntity>(model.toEntity()))
        .handleError(
          (error) => Left<Failure, FeederEntity>(
            ServerFailure(
              message: error.toString(),
              code: 500,
            ),
          ),
        );
  }

  @override
  Future<Either<Failure, void>> disconnectFeeder(
      {required String feederId}) async {
    if (await networkInfo.isConnected!) {
      try {
        await remoteDataSource.disconnectFeeder(feederId: feederId);

        final prefs = sl<SharedPreferences>();
        await prefs.setString('cached_feeder_id', feederId);

        return const Right(null);
      } on ServerException {
        return Left(ServerFailure(
          message: 'Server error occurred while connecting feeder.',
          code: 500,
        ));
      }
    } else {
      return Left(NetworkFailure(
        message: 'No internet connection.',
      ));
    }
  }
}
