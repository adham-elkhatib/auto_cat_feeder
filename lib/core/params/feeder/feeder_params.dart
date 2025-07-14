import '../../../features/meals/domain/entities/meal_entity.dart';

class ConnectFeederParams {
  final String id;
  final List<MealEntity> meals;

  const ConnectFeederParams({
    required this.id,
    required this.meals,
  });
}

class SyncToFeederParams {
  final String id;
  final List<MealEntity>? meals;
  final String? token;

  const SyncToFeederParams({
    required this.id,
    this.meals,
    this.token,
  });
}
