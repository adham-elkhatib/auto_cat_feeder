import 'package:dartz/dartz.dart';

import '../../../../core/Services/Error Handling/exports.error_handling.dart';
import '../../../../core/params/meal/meal_params.dart';
import '../entities/meal_entity.dart';
import '../repositories/meal_repository.dart';

class CreateMeal {
  final MealRepository mealRepository;

  CreateMeal({required this.mealRepository});

  Future<Either<Failure, MealEntity>> call({
    required MealParams params,
  }) async {
    return await mealRepository.createMeal(params: params);
  }
}
