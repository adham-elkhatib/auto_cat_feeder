import 'package:dartz/dartz.dart';

import '../../../../core/Services/Error Handling/exports.error_handling.dart';
import '../entities/meal_entity.dart';
import '../repositories/meal_repository.dart';

class GetMeals {
  final MealRepository mealRepository;

  GetMeals({required this.mealRepository});

  Future<Either<Failure, List<MealEntity>>> call({
    required String params,
  }) async {
    return await mealRepository.getMeals(params: params);
  }
}
