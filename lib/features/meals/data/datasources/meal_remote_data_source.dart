import '../../../../core/Providers/FB Firestore/fbfirestore_repo.dart';
import '../../../../core/Providers/src/condition_model.dart';
import '../../../../core/Providers/src/operators.dart';
import '../../../../core/Services/Error Handling/exports.error_handling.dart';
import '../models/meal_model.dart';

abstract class MealRemoteDataSource {
  Future<MealModel> getMeal({required String id});

  Future<List<MealModel>> getMeals({required String userId});

  Future<MealModel> createMeal(MealModel meal);

  Future<MealModel> updateMeal(MealModel meal);

  Future<void> deleteMeal(String id);
}

class MealRemoteDataSourceImpl implements MealRemoteDataSource {
  final FirestoreRepo<MealModel> firestoreRepo;

  MealRemoteDataSourceImpl({required this.firestoreRepo});

  @override
  Future<MealModel> getMeal({required String id}) async {
    try {
      final meal = await firestoreRepo.readSingle(id);
      if (meal == null) {
        throw ServerException(message: "Meal not found");
      }
      return meal;
    } catch (e) {
      throw ServerException(message: "Failed to get meal: $e");
    }
  }

  @override
  Future<List<MealModel>> getMeals({required String userId}) async {
    try {
      final meals = await firestoreRepo.readAllWhere(
        [
          QueryCondition(
              field: "userId", operator: QueryOperator.equals, value: userId)
        ],
      );

      return (meals ?? []).whereType<MealModel>().toList();
    } catch (e) {
      throw ServerException(message: "Failed to get meals: $e");
    }
  }

  @override
  Future<MealModel> createMeal(MealModel meal) async {
    try {
      await firestoreRepo.createSingle(meal, itemId: meal.id);
      return meal;
    } catch (e) {
      throw ServerException(message: "Failed to create meal: $e");
    }
  }

  @override
  Future<MealModel> updateMeal(MealModel meal) async {
    try {
      await firestoreRepo.updateSingle(meal.id, meal);
      return meal;
    } catch (e) {
      throw ServerException(message: "Failed to update meal: $e");
    }
  }

  @override
  Future<void> deleteMeal(String id) async {
    try {
      await firestoreRepo.deleteSingle(id);
    } catch (e) {
      throw ServerException(message: "Failed to delete meal: $e");
    }
  }
}
