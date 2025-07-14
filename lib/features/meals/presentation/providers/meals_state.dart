part of 'meals_bloc.dart';

sealed class MealsState extends Equatable {
  const MealsState();
}

class MealsInitial extends MealsState {
  @override
  List<Object> get props => [];
}

class MealsLoading extends MealsState {
  @override
  List<Object?> get props => [];
}

class MealsLoaded extends MealsState {
  final List<MealEntity> meals;

  const MealsLoaded({required this.meals});

  @override
  List<Object?> get props => [meals];
}

class MealOperationSuccess extends MealsState {
  final String? message;

  const MealOperationSuccess({this.message});

  @override
  List<Object?> get props => [message];
}

class MealsFailure extends MealsState {
  final String message;

  const MealsFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
