import 'dart:convert';

import '../../domain/entities/cat_breed.dart';
import '../../domain/entities/cat_entity.dart';
import '../../domain/entities/energy_level.dart';
import '../../domain/entities/gender.dart';

class CatModel {
  final String id;
  final String name;
  final int age;
  final double weight;
  final Gender gender;
  final String userId;
  final String? feederId;
  final CatBreed breed;
  final EnergyLevel energyLevel;

  CatModel({
    required this.id,
    required this.name,
    required this.age,
    required this.weight,
    required this.gender,
    required this.userId,
    required this.breed,
    required this.energyLevel,
    this.feederId,
  });

  // ✅ Map to JSON
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'weight': weight,
      'gender': gender.index,
      'userId': userId,
      'feederId': feederId,
      'breed': breed.index,
      'energyLevel': energyLevel.index,
    };
  }

  factory CatModel.fromMap(Map<String, dynamic> map) {
    return CatModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      age: map['age'] ?? 0,
      weight: (map['weight'] ?? 0).toDouble(),
      gender: Gender.values[map['gender'] ?? 0],
      userId: map['userId'] ?? '',
      feederId: map['feederId'],
      breed: CatBreed.values[map['breed'] ?? 0],
      energyLevel: EnergyLevel.values[map['energyLevel'] ?? 1],
    );
  }

  String toJson() => json.encode(toMap());

  factory CatModel.fromJson(String source) =>
      CatModel.fromMap(json.decode(source));

  // ✅ تحويل من Entity لـ Model
  factory CatModel.fromEntity(CatEntity entity) {
    return CatModel(
      id: entity.id,
      name: entity.name,
      age: entity.age,
      weight: entity.weight,
      gender: entity.gender,
      userId: entity.userId,
      feederId: entity.feederId,
      breed: entity.breed,
      energyLevel: entity.energyLevel,
    );
  }

  // ✅ تحويل من Model لـ Entity
  CatEntity toEntity() {
    return CatEntity(
      id: id,
      name: name,
      age: age,
      weight: weight,
      gender: gender,
      userId: userId,
      feederId: feederId,
      breed: breed,
      energyLevel: energyLevel,
    );
  }

  CatModel copyWith({
    String? id,
    String? name,
    int? age,
    double? weight,
    Gender? gender,
    String? userId,
    String? feederId,
    CatBreed? breed,
    EnergyLevel? energyLevel,
  }) {
    return CatModel(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      weight: weight ?? this.weight,
      gender: gender ?? this.gender,
      userId: userId ?? this.userId,
      feederId: feederId ?? this.feederId,
      breed: breed ?? this.breed,
      energyLevel: energyLevel ?? this.energyLevel,
    );
  }
}
