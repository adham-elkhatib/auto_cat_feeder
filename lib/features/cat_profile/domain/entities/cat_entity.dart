import 'cat_breed.dart';
import 'energy_level.dart';
import 'gender.dart';

class CatEntity {
  final String id;
  final String name;
  final int age;
  final double weight;
  final Gender gender;
  final String userId;
  final String? feederId;
  final CatBreed breed;
  final EnergyLevel energyLevel;

  const CatEntity({
    required this.id,
    required this.name,
    required this.age,
    required this.weight,
    required this.gender,
    required this.userId,
    this.feederId,
    required this.breed,
    required this.energyLevel,
  });

  CatEntity copyWith({
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
    return CatEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      weight: weight ?? this.weight,
      gender: gender ?? this.gender,
      userId: userId ?? this.userId,
      feederId: feederId,
      breed: breed ?? this.breed,
      energyLevel: energyLevel ?? this.energyLevel,
    );
  }
}
