import 'package:equatable/equatable.dart';

import '../../../../core/params/meal/meal_params.dart';
import '../../../cat_profile/domain/entities/cat_entity.dart';
import '../../../meals/domain/entities/meal_entity.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class LoadHomeDataEvent extends HomeEvent {
  @override
  List<Object> get props => [];
}

class UpdatePetProfileEvent extends HomeEvent {
  final CatEntity updatedCat;

  const UpdatePetProfileEvent({required this.updatedCat});

  @override
  List<Object> get props => [updatedCat];
}

class AddMealEvent extends HomeEvent {
  final MealParams newMeal;

  const AddMealEvent({required this.newMeal});

  @override
  List<Object> get props => [newMeal];
}

class DeleteMealEvent extends HomeEvent {
  final DeleteMealParams params;

  const DeleteMealEvent({required this.params});

  @override
  List<Object> get props => [params];
}

class UpdateMealServingEvent extends HomeEvent {
  final MealEntity updatedMeal;

  const UpdateMealServingEvent({required this.updatedMeal});

  @override
  List<Object> get props => [updatedMeal];
}

class ConnectFeederEvent extends HomeEvent {
  final String feederId;
  final CatEntity cat;

  const ConnectFeederEvent({
    required this.feederId,
    required this.cat,
  });

  @override
  List<Object?> get props => [feederId, cat];
}

class DisconnectFeederEvent extends HomeEvent {
  final String feederId;

  const DisconnectFeederEvent({required this.feederId});

  @override
  List<Object?> get props => [feederId];
}

class ToggleMealEvent extends HomeEvent {
  final String mealId;
  final bool isEnabled;

  const ToggleMealEvent({
    required this.mealId,
    required this.isEnabled,
  });

  @override
  List<Object> get props => [mealId, isEnabled];
}
