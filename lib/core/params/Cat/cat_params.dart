import '../../../features/cat_profile/domain/entities/cat_breed.dart';
import '../../../features/cat_profile/domain/entities/cat_entity.dart';
import '../../../features/cat_profile/domain/entities/energy_level.dart';
import '../../../features/cat_profile/domain/entities/gender.dart';

class CatProfileParams {
  CatProfileParams();
}

class CreateCatProfileParams {
  final String? id;
  final String name;
  final int age;
  final double weight;
  final Gender gender;
  final String? userId;
  final CatBreed breed;
  final EnergyLevel energyLevel;

  CreateCatProfileParams({
    this.id,
    required this.name,
    required this.age,
    required this.weight,
    required this.gender,
    this.userId,
    required this.breed,
    required this.energyLevel,
  });

  CreateCatProfileParams copyWith({
    String? id,
    String? userId,
  }) {
    return CreateCatProfileParams(
      id: id ?? this.id,
      name: name,
      age: age,
      weight: weight,
      gender: gender,
      userId: userId ?? this.userId,
      breed: breed,
      energyLevel: energyLevel,
    );
  }
}

class UpdateCatProfileParams {
  final String id;
  final String name;
  final int age;
  final double weight;
  final Gender gender;
  final String userId;
  final CatBreed breed;
  final EnergyLevel energyLevel;
  final String? feederId;

  UpdateCatProfileParams({
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

  factory UpdateCatProfileParams.fromEntity(CatEntity cat) {
    return UpdateCatProfileParams(
      id: cat.id,
      name: cat.name,
      age: cat.age,
      feederId: cat.feederId,
      weight: cat.weight,
      gender: cat.gender,
      breed: cat.breed,
      energyLevel: cat.energyLevel,
      userId: cat.userId,
    );
  }
}
