part of 'meals_bloc.dart';

sealed class MealsEvent extends Equatable {
  const MealsEvent();
}

class LoadMealsEvent extends MealsEvent {
  final String userId;

  const LoadMealsEvent({required this.userId});

  @override
  List<Object?> get props => [userId];
}

class CreateMealEvent extends MealsEvent {
  final MealParams params;

  const CreateMealEvent({required this.params});

  @override
  List<Object?> get props => [params];
}

class UpdateMealEvent extends MealsEvent {
  final MealEntity meal;

  const UpdateMealEvent({required this.meal});

  @override
  List<Object?> get props => [meal];
}

class DeleteMealEvent extends MealsEvent {
  final DeleteMealParams params;

  const DeleteMealEvent({required this.params});

  @override
  List<Object?> get props => [params];
}

class ToggleMealEvent extends MealsEvent {
  final String mealId;
  final bool isEnabled;

  const ToggleMealEvent({required this.mealId, required this.isEnabled});

  @override
  List<Object?> get props => [mealId, isEnabled];
}
