import 'dart:convert';

import '../../../meals/data/models/meal_model.dart';
import '../../domain/entities/feeder_entity.dart';

class FeederModel {
  final String id;
  final double? catWeight;
  final bool? foodContainerEmpty;
  final String? ipAddress;
  final List<MealModel>? meals;
  final String? token;

  const FeederModel({
    required this.id,
    this.catWeight,
    this.foodContainerEmpty,
    this.ipAddress,
    required this.meals,
    this.token,
  });

  /// Model -> Entity
  FeederEntity toEntity() {
    return FeederEntity(
      id: id,
      catWeight: catWeight,
      foodContainerEmpty: foodContainerEmpty,
      ipAddress: ipAddress,
      meals: meals?.map((m) => m.toEntity()).toList() ?? [],
      token: token,
    );
  }

  /// Entity -> Model
  factory FeederModel.fromEntity(FeederEntity entity) {
    return FeederModel(
      id: entity.id,
      catWeight: entity.catWeight,
      foodContainerEmpty: entity.foodContainerEmpty,
      ipAddress: entity.ipAddress,
      meals: entity.meals.map((m) => MealModel.fromEntity(m)).toList(),
      token: entity.token,
    );
  }

  /// من Map
  factory FeederModel.fromMap(Map<String, dynamic> map) {
    return FeederModel(
      id: map['id'] ?? '',
      catWeight: (map['catWeight'] ?? 0).toDouble(),
      foodContainerEmpty: map['foodContainerEmpty'] ?? true,
      ipAddress: map['ip_address'] ?? '',
      meals: List<MealModel>.from(
        (map['meals'] ?? []).map(
          (m) => MealModel.fromMap(Map<String, dynamic>.from(m)),
        ),
      ),
      token: map['token'],
    );
  }

  /// إلى Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'catWeight': catWeight,
      'foodContainerEmpty': foodContainerEmpty,
      'ip_address': ipAddress,
      'meals': meals?.map((m) => m.toMap()).toList(),
      'token': token,
    };
  }

  /// من JSON String
  factory FeederModel.fromJson(String source) =>
      FeederModel.fromMap(json.decode(source));

  /// إلى JSON String
  String toJson() => json.encode(toMap());
}
