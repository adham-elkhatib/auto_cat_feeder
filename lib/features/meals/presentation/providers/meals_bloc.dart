import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/params/meal/meal_params.dart';
import '../../domain/entities/meal_entity.dart';
import '../../domain/usecases/create_meal.dart';
import '../../domain/usecases/delete_meal.dart';
import '../../domain/usecases/get_meals.dart';
import '../../domain/usecases/update_meal.dart';

part 'meals_event.dart';
part 'meals_state.dart';

class MealsBloc extends Bloc<MealsEvent, MealsState> {
  final GetMeals getMealsUseCase;
  final CreateMeal createMealUseCase;
  final UpdateMeal updateMealUseCase;
  final DeleteMeal deleteMealUseCase;

  MealsBloc({
    required this.getMealsUseCase,
    required this.createMealUseCase,
    required this.updateMealUseCase,
    required this.deleteMealUseCase,
  }) : super(MealsInitial()) {
    on<LoadMealsEvent>(_onLoadMeals);
    on<CreateMealEvent>(_onCreateMeal);
    on<UpdateMealEvent>(_onUpdateMeal);
    on<DeleteMealEvent>(_onDeleteMeal);
    // on<ToggleMealEvent>(_onToggleMeal);
  }

  Future<void> _onLoadMeals(
      LoadMealsEvent event, Emitter<MealsState> emit) async {
    emit(MealsLoading());
    final result = await getMealsUseCase(params: event.userId);

    result.fold(
      (failure) => emit(MealsFailure(message: failure.toString())),
      (meals) => emit(MealsLoaded(meals: meals)),
    );
  }

  Future<void> _onCreateMeal(
      CreateMealEvent event, Emitter<MealsState> emit) async {
    emit(MealsLoading());
    final result = await createMealUseCase(params: event.params);

    result.fold(
      (failure) => emit(MealsFailure(message: failure.toString())),
      (meal) => emit(const MealOperationSuccess(message: "Meal created")),
    );
  }

  Future<void> _onUpdateMeal(
      UpdateMealEvent event, Emitter<MealsState> emit) async {
    emit(MealsLoading());
    final result = await updateMealUseCase(meal: event.meal);

    result.fold(
      (failure) => emit(MealsFailure(message: failure.toString())),
      (meal) => emit(const MealOperationSuccess(message: "Meal updated")),
    );
  }

  Future<void> _onDeleteMeal(
      DeleteMealEvent event, Emitter<MealsState> emit) async {
    emit(MealsLoading());
    final result = await deleteMealUseCase(
      params: event.params,
    );

    result.fold(
      (failure) => emit(MealsFailure(message: failure.toString())),
      (_) => emit(const MealOperationSuccess(message: "Meal deleted")),
    );
  }
// todo implement later "optional feature"
// Future<void> _onToggleMeal(
//     ToggleMealEvent event, Emitter<MealsState> emit) async {
//   emit(MealsLoading());
//   // انت حر هنا: ممكن تبعت UpdateMealEvent بالـ params الجديدة!
//   // أو تكتب logic مخصص هنا:
//   final toggleParams = MealParams(
//     id: event.mealId,
//     isEnabled: event.isEnabled,
//     // باقي البيانات المطلوبة حسب الـ UseCase
//   );
//
//   final result = await updateMealUseCase(params: toggleParams);
//
//   result.fold(
//         (failure) => emit(MealsFailure(message: failure.toString())),
//         (_) => emit(const MealOperationSuccess(message: "Meal toggled")),
//   );
// }
}
