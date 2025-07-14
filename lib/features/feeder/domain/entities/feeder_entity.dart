import '../../../meals/domain/entities/meal_entity.dart';

class FeederEntity {
  final String id;
  final double? catWeight;
  final bool? foodContainerEmpty;
  final String? ipAddress;
  final List<MealEntity> meals;
  final String? token;

  const FeederEntity({
    required this.id,
    this.catWeight,
    this.foodContainerEmpty,
    this.ipAddress,
    required this.meals,
    this.token,
  });

  FeederEntity copyWith({
    String? id,
    double? catWeight,
    bool? foodContainerEmpty,
    String? ipAddress,
    List<MealEntity>? meals,
    String? token,
  }) {
    return FeederEntity(
      id: id ?? this.id,
      catWeight: catWeight ?? this.catWeight,
      foodContainerEmpty: foodContainerEmpty ?? this.foodContainerEmpty,
      ipAddress: ipAddress ?? this.ipAddress,
      meals: meals ?? this.meals,
      token: token ?? this.token,
    );
  }
}
