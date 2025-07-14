import 'package:dartz/dartz.dart';

import '../../../../../core/connection/network_info.dart';
import '../../../../core/Services/Auth/auth.service.dart';
import '../../../../core/Services/Error Handling/exports.error_handling.dart';
import '../../../../core/Services/Id Generating/id_generating.service.dart';
import '../../../../core/params/meal/meal_params.dart';
import '../../../../locator.dart';
import '../../domain/entities/meal_entity.dart';
import '../../domain/repositories/meal_repository.dart';
import '../datasources/meal_local_data_source.dart';
import '../datasources/meal_remote_data_source.dart';
import '../models/meal_model.dart';

class MealRepositoryImpl implements MealRepository {
  final MealRemoteDataSource remoteDataSource;
  final MealLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  MealRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, MealEntity>> createMeal(
      {required MealParams params}) async {
    if (await networkInfo.isConnected!) {
      try {
        final id = IdGeneratingService.generate();
        final userId = sl<AuthService>().getCurrentUserId();

        final mealModel = MealModel(
            id: id,
            serving: params.serving,
            isEnabled: params.isEnabled,
            userId: userId!,
            time: params.time);
        final createdMeal = await remoteDataSource.createMeal(mealModel);

        final meals = await remoteDataSource.getMeals(userId: userId);
        await localDataSource.cacheMeals(mealsToCache: meals);

        return Right(createdMeal.toEntity());
      } on ServerException {
        return Left(ServerFailure(
          message: 'Server error while creating meal',
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
  Future<Either<Failure, void>> deleteMeal(
      {required DeleteMealParams params}) async {
    if (await networkInfo.isConnected!) {
      try {
        await remoteDataSource.deleteMeal(params.id);
        // todo implement getting user id
        // final meals = await remoteDataSource.getMeals(userId: params.userId!);
        // await localDataSource.cacheMeals(mealsToCache: meals);

        return const Right(null);
      } on ServerException {
        return Left(ServerFailure(
          message: 'Server error while deleting meal',
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
  Future<Either<Failure, List<MealEntity>>> getMeals(
      {required String params}) async {
    if (await networkInfo.isConnected!) {
      try {
        final remoteMeals = await remoteDataSource.getMeals(userId: params);
        await localDataSource.cacheMeals(mealsToCache: remoteMeals);

        return Right(remoteMeals.map((e) => e.toEntity()).toList());
      } on ServerException {
        return Left(ServerFailure(
          message: 'Server error while fetching meals',
          code: 500,
        ));
      } on CacheException {
        return Left(ServerFailure(
          message: ' error while caching meals',
          code: 500,
        ));
      }
    } else {
      try {
        final localMeals = await localDataSource.getLastMeals();
        return Right(localMeals.map((e) => e.toEntity()).toList());
      } on CacheException {
        return Left(CacheFailure(
          message: 'No cached meals found',
        ));
      }
    }
  }

  @override
  Future<Either<Failure, MealEntity>> updateMeal(
      {required MealEntity meal}) async {
    if (await networkInfo.isConnected!) {
      try {
        final userId = sl<AuthService>().getCurrentUserId();

        final mealModel = MealModel(
            id: meal.id,
            serving: meal.serving,
            isEnabled: meal.isEnabled,
            userId: userId!,
            time: meal.time);

        final updatedMeal = await remoteDataSource.updateMeal(mealModel);

        final meals = await remoteDataSource.getMeals(userId: userId);
        await localDataSource.cacheMeals(mealsToCache: meals);

        return Right(updatedMeal.toEntity());
      } on ServerException {
        return Left(ServerFailure(
          message: 'Server error while updating meal',
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
