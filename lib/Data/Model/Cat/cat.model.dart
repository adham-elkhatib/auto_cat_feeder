import 'dart:convert';

import 'cat_breed.dart';
import 'energy_level.dart';
import 'gender.dart';

class Cat {
  String id;
  String name;
  int age;
  double weight;
  Gender gender;
  String userId;
  String? feederId;
  CatBreed breed;
  EnergyLevel energyLevel;

  Cat({
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

  Cat copyWith({
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
    return Cat(
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

  factory Cat.fromMap(Map<String, dynamic> map) {
    return Cat(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      age: map['age'] ?? 0,
      weight: (map['weight'] ?? 0.0).toDouble(),
      gender: Gender.values[map['gender'] ?? 0],
      userId: map['userId'] ?? '',
      feederId: map['feederId'],
      breed: CatBreed.values[map['breed'] ?? 0],
      energyLevel: EnergyLevel.values[map['energyLevel'] ?? 1],
    );
  }

  String toJson() => json.encode(toMap());

  factory Cat.fromJson(String source) =>
      Cat.fromMap(json.decode(source) as Map<String, dynamic>);
}
