import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/Services/Auth/auth.service.dart';
import '../../../../core/params/Cat/cat_params.dart';
import '../../../../core/params/feeder/feeder_params.dart';
import '../../../../locator.dart';
import '../../../cat_profile/domain/entities/cat_entity.dart';
import '../../../cat_profile/domain/usecases/get_cat_profile.dart';
import '../../../cat_profile/domain/usecases/update_cat_profile.dart';
import '../../../feeder/domain/usecases/connect_feeder.dart';
import '../../../feeder/domain/usecases/disconnect_feeder.dart';
import '../../../feeder/domain/usecases/get_feeder.dart';
import '../../../feeder/domain/usecases/sync_to_feeder.dart';
import '../../../meals/domain/entities/meal_entity.dart';
import '../../../meals/domain/usecases/create_meal.dart';
import '../../../meals/domain/usecases/delete_meal.dart';
import '../../../meals/domain/usecases/get_meals.dart';
import '../../../meals/domain/usecases/update_meal.dart';
import 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetCatProfile getCatProfileUseCase;
  final UpdateCatProfile updateCatProfileUseCase;
  final GetFeeder getFeederUseCase;
  final CreateMeal createMealUseCase;
  final DeleteMeal deleteMealUseCase;
  final UpdateMeal updateMealUseCase;
  final GetMeals getMealsUseCase;
  final SyncToFeeder syncToFeederUseCase;
  final ConnectToFeeder connectFeederUseCase;
  final DisconnectFeeder disconnectFeederUseCase;

  HomeBloc({
    required this.getCatProfileUseCase,
    required this.updateCatProfileUseCase,
    required this.getFeederUseCase,
    required this.deleteMealUseCase,
    required this.createMealUseCase,
    required this.updateMealUseCase,
    required this.getMealsUseCase,
    required this.syncToFeederUseCase,
    required this.connectFeederUseCase,
    required this.disconnectFeederUseCase,
  }) : super(HomeInitial()) {
    on<LoadHomeDataEvent>(_onLoadHomeData);
    on<UpdatePetProfileEvent>(_onUpdatePetProfile);
    on<AddMealEvent>(_onAddMeal);
    on<DeleteMealEvent>(_onDeleteMeal);
    on<UpdateMealServingEvent>(_onUpdateMealServing);
    on<ToggleMealEvent>(_onToggleMeal);
    on<ConnectFeederEvent>(_onConnectFeeder);
    on<DisconnectFeederEvent>(_onDisconnectFeeder);
  }

  Future<void> _onLoadHomeData(
    LoadHomeDataEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());

    try {
      final String? userId = sl<AuthService>().getCurrentUserId();
      if (userId == null) {
        emit(const HomeError(message: "User not logged in."));
        return;
      }

      final catResult = await getCatProfileUseCase(uid: userId);

      if (catResult.isLeft()) {
        final message = catResult.fold(
          (failure) => failure.message,
          (_) => 'Unknown error',
        );
        emit(HomeError(message: message));
        return;
      }

      final cat =
          catResult.getOrElse(() => throw Exception("Unexpected null cat"));

      List<MealEntity>? meals;

      final mealsResult = await getMealsUseCase(params: userId);

      meals = mealsResult.fold(
        (failure) => null,
        (value) => value,
      );

      emit(HomeLoaded(cat: cat, meals: meals));
    } catch (e) {
      emit(HomeError(message: e.toString()));
    }
  }

  Future<void> _onUpdatePetProfile(
    UpdatePetProfileEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (state is HomeLoaded) {
      final current = state as HomeLoaded;
      final params = UpdateCatProfileParams.fromEntity(event.updatedCat);

      final updatedCatResult = await updateCatProfileUseCase(params: params);

      updatedCatResult.fold(
          (failure) => emit(HomeError(message: failure.message)),
          (updatedCatResult) =>
              emit(HomeLoaded(cat: updatedCatResult, meals: current.meals)));
    }
  }

  Future<void> _onAddMeal(
    AddMealEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (state is HomeLoaded) {
      final current = state as HomeLoaded;

      final createdMealResult = await createMealUseCase(params: event.newMeal);

      if (createdMealResult.isLeft()) {
        final failure = createdMealResult.swap().getOrElse(
              () => throw Exception("Unknown Failure"),
            );
        emit(HomeError(message: failure.message));
        return;
      }

      final addedMeal = createdMealResult.getOrElse(
        () => throw Exception("Unexpected null meal"),
      );

      final updatedMeals = [...?current.meals, addedMeal];

      emit(HomeLoaded(
        cat: current.cat,
        meals: updatedMeals,
      ));
      if (current.cat.feederId != null) {
        final syncResult = await syncToFeederUseCase(
          params: SyncToFeederParams(
            id: current.cat.feederId!,
            meals: updatedMeals,
          ),
        );

        if (syncResult.isLeft()) {
          final failure = syncResult.swap().getOrElse(
                () => throw Exception("Unknown Failure"),
              );
          emit(HomeError(message: failure.message));
          return;
        }
      }
    }
  }

  Future<void> _onDeleteMeal(
    DeleteMealEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (state is HomeLoaded) {
      final current = state as HomeLoaded;

      final deletedResult = await deleteMealUseCase(params: event.params);

      if (deletedResult.isLeft()) {
        final failure = deletedResult.swap().getOrElse(
              () => throw Exception("Unknown Failure"),
            );
        emit(HomeError(message: failure.message));
        return;
      }

      final updatedMeals =
          current.meals?.where((e) => e.id != event.params.id).toList();

      emit(HomeLoaded(
        cat: current.cat,
        meals: updatedMeals,
      ));

      if (current.cat.feederId != null) {
        final syncResult = await syncToFeederUseCase(
          params: SyncToFeederParams(
            id: current.cat.feederId!,
            meals: updatedMeals,
          ),
        );

        if (syncResult.isLeft()) {
          final failure = syncResult.swap().getOrElse(
                () => throw Exception("Unknown Failure"),
              );
          emit(HomeError(message: failure.message));
          return;
        }
      }
    }
  }

  Future<void> _onUpdateMealServing(
    UpdateMealServingEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (state is HomeLoaded) {
      final current = state as HomeLoaded;

      final updatedResult = await updateMealUseCase(meal: event.updatedMeal);

      if (updatedResult.isLeft()) {
        final failure = updatedResult.swap().getOrElse(
              () => throw Exception("Unknown Failure"),
            );
        emit(HomeError(message: failure.message));
        return;
      }

      final updatedMeal = updatedResult.getOrElse(
        () => throw Exception("Unexpected null meal"),
      );

      final updatedMeals = current.meals?.map((meal) {
        if (meal.id == updatedMeal.id) {
          return updatedMeal;
        }
        return meal;
      }).toList();

      emit(HomeLoaded(
        cat: current.cat,
        meals: updatedMeals,
      ));
      if (current.cat.feederId != null) {
        final syncResult = await syncToFeederUseCase(
          params: SyncToFeederParams(
            id: current.cat.feederId!,
            meals: updatedMeals,
          ),
        );

        if (syncResult.isLeft()) {
          final failure = syncResult.swap().getOrElse(
                () => throw Exception("Unknown Failure"),
              );
          emit(HomeError(message: failure.message));
          return;
        }
      }
    }
  }

  Future<void> _onDisconnectFeeder(
      DisconnectFeederEvent event, Emitter<HomeState> emit) async {
    if (state is! HomeLoaded) return;
    // emit(HomeLoading());

    final current = state as HomeLoaded;

    // Step 1: Connect to Feeder
    final disconnectResult =
        await disconnectFeederUseCase(feederId: event.feederId);

    if (disconnectResult.isLeft()) {
      final failure =
          disconnectResult.swap().getOrElse(() => throw Exception());
      emit(HomeError(message: failure.message));
      return;
    }

    // Step 2: Update Cat Profile
    final updatedCat = current.cat.copyWith(feederId: null);
    final updateResult = await updateCatProfileUseCase(
      params: UpdateCatProfileParams.fromEntity(updatedCat),
    );

    if (updateResult.isLeft()) {
      final failure = updateResult.swap().getOrElse(() => throw Exception());
      emit(HomeError(message: failure.message));
      return;
    }

    final finalCat = updateResult.getOrElse(() => updatedCat);

    // Final: Emit Updated State
    emit(HomeLoaded(cat: finalCat, meals: current.meals));
  }

  Future<void> _onConnectFeeder(
    ConnectFeederEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (state is! HomeLoaded) return;
    // emit(HomeLoading());

    final current = state as HomeLoaded;

    // Step 1: Connect to Feeder
    final connectResult = await connectFeederUseCase(feederId: event.feederId);
    if (connectResult.isLeft()) {
      final failure = connectResult.swap().getOrElse(() => throw Exception());
      emit(HomeError(message: failure.message));
      return;
    }

    // Step 2: Update Cat Profile
    final updatedCat = current.cat.copyWith(feederId: event.feederId);
    final updateResult = await updateCatProfileUseCase(
      params: UpdateCatProfileParams.fromEntity(updatedCat),
    );

    if (updateResult.isLeft()) {
      final failure = updateResult.swap().getOrElse(() => throw Exception());
      emit(HomeError(message: failure.message));
      return;
    }

    final finalCat = updateResult.getOrElse(() => updatedCat);

    // Step 3: Sync Meals to Feeder
    final syncResult = await syncToFeederUseCase(
      params: SyncToFeederParams(
        id: finalCat.feederId!,
        meals: current.meals,
      ),
    );

    if (syncResult.isLeft()) {
      final failure = syncResult.swap().getOrElse(() => throw Exception());
      emit(HomeError(message: failure.message));
      return;
    }

    // Final: Emit Updated State
    emit(HomeLoaded(cat: finalCat, meals: current.meals));
  }

  Future<void> _onToggleMeal(
    ToggleMealEvent event,
    Emitter<HomeState> emit,
  ) async {
    /// نفس فكرة UpdateMeal
    /// تقدر تستخدم نفس UseCase أو تعمل UseCase خاص
  }
}
