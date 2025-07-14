import 'package:dartz/dartz.dart';

import '../../../../core/Services/Error Handling/exports.error_handling.dart';
import '../entities/meal_entity.dart';
import '../repositories/meal_repository.dart';

class UpdateMeal {
  final MealRepository mealRepository;

  UpdateMeal({required this.mealRepository});

  Future<Either<Failure, MealEntity>> call({
    required MealEntity meal,
  }) async {
    return await mealRepository.updateMeal(meal: meal);
  }
}
