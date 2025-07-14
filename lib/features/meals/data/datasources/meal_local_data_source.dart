import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/Services/Error Handling/exports.error_handling.dart';
import '../models/meal_model.dart';

abstract class MealLocalDataSource {
  Future<void> cacheMeals({required List<MealModel> mealsToCache});

  Future<List<MealModel>> getLastMeals();
}

const cachedMeals = 'CACHED_MEALS';

class MealLocalDataSourceImpl implements MealLocalDataSource {
  final SharedPreferences sharedPreferences;

  MealLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheMeals({required List<MealModel> mealsToCache}) async {
    if (mealsToCache.isNotEmpty) {
      final jsonString = json.encode(
        mealsToCache.map((meal) => meal.toMap()).toList(),
      );
      await sharedPreferences.setString(cachedMeals, jsonString);
    } else {
      await sharedPreferences.remove(cachedMeals);
    }
  }

  @override
  Future<List<MealModel>> getLastMeals() {
    try {
      final jsonString = sharedPreferences.getString(cachedMeals);

      if (jsonString != null) {
        final List<dynamic> decodedJson = json.decode(jsonString);
        final meals = decodedJson
            .map((mealMap) =>
                MealModel.fromMap(Map<String, dynamic>.from(mealMap)))
            .toList();
        return Future.value(meals);
      } else {
        throw CacheException(message: 'No cached meals found.');
      }
    } catch (e) {
      throw CacheException(message: 'Failed to decode cached meals: $e');
    }
  }
}
