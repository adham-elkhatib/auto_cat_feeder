import 'package:dartz/dartz.dart';

import '../../../../core/Services/Error Handling/exports.error_handling.dart';
import '../../../../core/params/meal/meal_params.dart';
import '../entities/meal_entity.dart';

abstract class MealRepository {
  Future<Either<Failure, List<MealEntity>>> getMeals({
    required String params,
  });

  Future<Either<Failure, MealEntity>> updateMeal({
    required MealEntity meal,
  });

  Future<Either<Failure, void>> deleteMeal({
    required DeleteMealParams params,
  });

  Future<Either<Failure, MealEntity>> createMeal({
    required MealParams params,
  });
}
