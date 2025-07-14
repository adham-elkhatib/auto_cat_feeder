import 'package:dartz/dartz.dart';

import '../../../../core/Services/Error Handling/exports.error_handling.dart';
import '../../../../core/params/meal/meal_params.dart';
import '../repositories/meal_repository.dart';

class DeleteMeal {
  final MealRepository mealRepository;

  DeleteMeal({required this.mealRepository});

  Future<Either<Failure, void>> call({
    required DeleteMealParams params,
  }) async {
    return await mealRepository.deleteMeal(params: params);
  }
}
