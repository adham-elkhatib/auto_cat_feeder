import 'dart:convert';

import 'meal.model.dart';

class FeederModel {
  final String id;

  final double catWeight;
  final bool foodContainerEmpty;
  final String ipAddress;
  List<Meal> meals;
  String? token;

  FeederModel({
    required this.id,
    required this.catWeight,
    required this.foodContainerEmpty,
    required this.ipAddress,
    required this.meals,
    this.token,
  });

  FeederModel copyWith({
    String? id,
    double? catWeight,
    bool? foodContainerEmpty,
    String? ipAddress,
    List<Meal>? meals,
    String? token,
  }) {
    return FeederModel(
      id: id ?? this.id,
      catWeight: catWeight ?? this.catWeight,
      foodContainerEmpty: foodContainerEmpty ?? this.foodContainerEmpty,
      ipAddress: ipAddress ?? this.ipAddress,
      meals: meals ?? this.meals,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        'catWeight': catWeight,
        'foodContainerEmpty': foodContainerEmpty,
        'ip_address': ipAddress,
        'meals': meals.map((m) => m.toMap()).toList(),
        "token": token,
      };

  factory FeederModel.fromMap(Map<String, dynamic> map) => FeederModel(
        id: map['id'],
        catWeight: (map['catWeight'] ?? 0).toDouble(),
        foodContainerEmpty: map['foodContainerEmpty'] ?? false,
        ipAddress: map['ip_address'] ?? '',
        meals: List<Meal>.from(
          (map['meals'] ?? [])
              .map((m) => Meal.fromMap(Map<String, dynamic>.from(m))),
        ),
        token: map['token'],
      );

  String toJson() => json.encode(toMap());

  factory FeederModel.fromJson(String source) =>
      FeederModel.fromMap(json.decode(source));
}
